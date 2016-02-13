//
//  VKAuthorizationHelper.m
//  VkSimpleSdk
//

#import "VKAuthorizationHelper.h"
#import "VKSdkVersion.h"
#import "VKAuthorizationView.h"
#import "VKStorage.h"
#import "VKAuthorizationResult.h"
#import "VKConsts.h"
#import "VKDefaultAuthorizationView.h"

static NSString *VkAuth_inAppUrlString = @"vkauthorize://authorize";
static NSString *VkAuth_inWebUrlString = @"https://oauth.vk.com/authorize";
static NSString *VkAuth_clientId = @"client_id";
static NSString *VkAuth_scope = @"scope";
static NSString *VkAuth_revoke = @"revoke";
static NSString *VkAuth_redirectUri = @"redirect_uri";
static NSString *VkAuth_redirectUriWeb = @"https://oauth.vk.com/blank.html";
static NSString *VkAuth_display = @"display";
static NSString *VkAuth_displayIos = @"ios";
static NSString *VkAuth_displayPage = @"page";
static NSString *VkAuth_sdkVersion = @"sdk_version";
static NSString *VkAuth_sdkVersionNumber = @"1.3.8";
static NSString *VkAuth_responseType = @"response_type";
static NSString *VkAuth_token = @"token";
static NSString *VkAuth_version = @"v";
static NSString *VkOfficialClient = @"com.vk.vkclient";
static NSString *VkOfficialClientUrl = @"vkauthorize://";

@interface VKAuthorizationHelper () <VKAuthorizationViewDelegate>

@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, assign) NSInteger permissions;
@property (nonatomic, strong) VKDefaultAuthorizationView *defaultAuthorizationView;

@end

@implementation VKAuthorizationHelper
{
    struct
    {
        unsigned vkAuthViewAuthSuccess : 1;
        unsigned vkAuthViewAuthFailed : 1;
        unsigned vkAuthViewDidConnectionProblem : 1;
        unsigned vkAuthViewWillOpen : 1;
        unsigned vkAuthViewDidClose : 1;
    } _outputCan;
}

+ (instancetype)sharedAuthorization
{
    static id sharedAuthorization = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAuthorization = [[[self class] alloc] init];
    });
    return sharedAuthorization;
}

#pragma mark - interface

- (void)authInVkApp
{
    if (![self _checkVkApp])
    {
        [self authInVKAuthorizationView];
        VKError(@"vk app is not installed on the phone");
        return;
    }
    NSURL *url = [self _urlForAppWithPermissions:self.permissions revoke:1];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)authInVKAuthorizationView
{
    if (!self.authView.superview)
    {
        [self.defaultAuthorizationView present];
        self.defaultAuthorizationView.authView = self.authView;
    }
    if (_outputCan.vkAuthViewWillOpen)
    {
        [self.output vkAuthViewWillOpen];
    }
    NSURL *url = [self _urlForWebWithPermissions:self.permissions];
    [self.authView authWithURL:url];
}

- (void)logout
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies)
    {
        if (NSNotFound != [cookie.domain rangeOfString:@"vk.com"].location)
        {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
    [VKStorage removeUserInfo];
    [VKStorage saveIsUserLogged:NO];
}

- (BOOL)isTokenValid
{
    return [VKStorage isTokenValid];
}

- (void)handleOpenURL:(NSURL *)url fromApplication:(NSString *)aplication
{
    if (![aplication isEqualToString:VkOfficialClient])
    {
        return;
    }
    NSString *string = url.absoluteString;
    NSString *vkClient = [NSString stringWithFormat:@"vk%@", self.clientId];
    if (![string containsString:vkClient])
    {
        return;
    }
    [self handleOpenURL:url];
}

- (void)handleOpenURL:(NSURL *)url
{
    VKAuthorizationResult *result = [VKAuthorizationResult resultFromUrl:url];
    if (result.error)
    {
        [self _authFailed];
    }
    else if (result.token)
    {
        [VKStorage saveAuthorizationResult:result];
        [VKStorage saveIsUserLogged:YES];
        [self _authSuccess];
    }
}

#pragma mark - setters

- (void)setClientId:(NSString *)clientId
{
    _clientId = clientId;
}

- (void)setPermissions:(NSInteger)permissions
{
    _permissions = permissions;
}

- (void)setOutput:(id<VKAuthorizationHelperDelegate>)output
{
    _output = output;
    _outputCan.vkAuthViewAuthSuccess = [_output respondsToSelector:@selector(vkAuthViewAuthSuccess)];
    _outputCan.vkAuthViewAuthFailed = [_output respondsToSelector:@selector(vkAuthViewAuthFailed)];
    _outputCan.vkAuthViewDidConnectionProblem = [_output respondsToSelector:@selector(vkAuthViewDidConnectionProblem)];
    _outputCan.vkAuthViewWillOpen = [_output respondsToSelector:@selector(vkAuthViewWillOpen)];
    _outputCan.vkAuthViewDidClose = [_output respondsToSelector:@selector(vkAuthViewDidClose)];
}

#pragma mark - VKAuthorizationViewDelegate

- (void)vkAuthViewAuthSuccess
{
    [self _authSuccess];
}

- (void)vkAuthViewAuthFailed
{
    [self _authFailed];
}

- (void)vkAuthViewDidConnectionProblem
{
    if (_outputCan.vkAuthViewDidConnectionProblem)
    {
        [self.output vkAuthViewDidConnectionProblem];
    }
}

#pragma mark - output

- (void)_authSuccess
{
    if (_outputCan.vkAuthViewDidClose)
    {
        [self.output vkAuthViewDidClose];
    }
    if (_outputCan.vkAuthViewAuthSuccess)
    {
        [self.output vkAuthViewAuthSuccess];
    }
    [_defaultAuthorizationView dismiss];
}

- (void)_authFailed
{
    if (_outputCan.vkAuthViewDidClose)
    {
        [self.output vkAuthViewDidClose];
    }
    if (_outputCan.vkAuthViewAuthFailed)
    {
        [self.output vkAuthViewAuthFailed];
    }
    [_defaultAuthorizationView dismiss];
}

#pragma mark - private

- (BOOL)_checkVkApp
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:VkOfficialClientUrl]];
}

- (NSURL *)_urlForAppWithPermissions:(NSInteger)permissions revoke:(NSInteger)revoke
{
    NSDictionary *params = @{VkAuth_clientId: self.clientId,
                             VkAuth_scope: [self _stringFromInt:permissions],
                             VkAuth_revoke: [self _stringFromInt:revoke],
                             VkAuth_redirectUri: [self _redirectUri],
                             VkAuth_display: VkAuth_displayIos,
                             VkAuth_sdkVersion: VK_SDK_VERSION,
                             VkAuth_responseType: VkAuth_token};
    NSString *urlString = [NSString stringWithFormat:@"%@?%@", VkAuth_inAppUrlString, [self _stringFromDictionary:params]];
    return [NSURL URLWithString:urlString];
}

- (NSURL *)_urlForWebWithPermissions:(NSInteger)permissions
{
    NSDictionary *params = @{VkAuth_clientId: self.clientId,
                             VkAuth_display: VkAuth_displayPage,
                             VkAuth_redirectUri: VkAuth_redirectUriWeb,
                             VkAuth_scope: [self _stringFromInt:permissions],
                             VkAuth_version: VK_SDK_API_VERSION,
                             VkAuth_responseType: VkAuth_token};
    NSString *urlString = [NSString stringWithFormat:@"%@?%@", VkAuth_inWebUrlString, [self _stringFromDictionary:params]];
    return [NSURL URLWithString:urlString];
}

- (NSString *)_stringFromDictionary:(NSDictionary *)dictionary
{
    NSMutableString *string = [NSMutableString new];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"%@=%@&", key, obj];
    }];
    [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    return string;
}

- (NSString *)_stringFromInt:(NSInteger)integer
{
    return [NSString stringWithFormat:@"%ld", (long)integer];
}

- (NSString *)_redirectUri
{
    return [NSString stringWithFormat:@"vk%@://authorize", self.clientId];
}

#pragma mark - lazy initialization

- (VKAuthorizationView *)authView
{
    if (!_authView)
    {
        _authView = [VKAuthorizationView new];
        _authView.output = self;
    }
    return _authView;
}

- (VKDefaultAuthorizationView *)defaultAuthorizationView
{
    if (!_defaultAuthorizationView)
    {
        _defaultAuthorizationView = [VKDefaultAuthorizationView new];
    }
    return _defaultAuthorizationView;
}

@end
