//
//  VKSimpleAuthorization.m
//  VkSimpleSdk
//

#import "VKSimpleAuthorization.h"
#import "VKAuthorizationHelper.h"

@interface VKSimpleAuthorization ()  <VKAuthorizationHelperDelegate>

@property (nonatomic, copy) CodeBlock successBlock;
@property (nonatomic, copy) CodeBlock failureCodeBlock;
@property (nonatomic, copy) FailureBlock failureBlock;

@end

@implementation VKSimpleAuthorization

+ (instancetype)sharedSimpleAuth
{
    static id sharedSimpleAuth = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSimpleAuth = [[[self class] alloc] init];
        AuthorizationHelper.output = sharedSimpleAuth;
        AuthorizationHelper.authView = [sharedSimpleAuth authView];
    });
    return sharedSimpleAuth;
}

#pragma mark - interface

- (void)authSuccess:(CodeBlock)success failure:(CodeBlock)failure
{
    self.successBlock = success;
    self.failureCodeBlock = failure;
    [AuthorizationHelper authInVkApp];
}

- (void)authInViewSuccess:(CodeBlock)success failure:(FailureBlock)failure
{
    self.successBlock = success;
    self.failureBlock = failure;
    [AuthorizationHelper authInVKAuthorizationView];
}

- (void)logout
{
    [AuthorizationHelper logout];
}

#pragma mark - <VKAuthorizationHelperDelegate>

- (void)vkAuthViewAuthSuccess
{
    if (self.successBlock)
    {
        self.successBlock();
        [self _cleanBlocks];
    }
}

- (void)vkAuthViewAuthFailed
{
    if (self.failureBlock)
    {
        self.failureBlock(YES, nil);
        [self _cleanBlocks];
    }
    if (self.failureCodeBlock)
    {
        self.failureCodeBlock();
        [self _cleanBlocks];
    }
}

- (void)vkAuthViewDidConnectionProblem
{
    if (self.failureBlock)
    {
        self.failureBlock(NO, nil);
        [self _cleanBlocks];
    }
}

- (void)vkAuthViewWillOpen
{
    self.authView.hidden = NO;
}

- (void)vkAuthViewDidClose
{
    self.authView.hidden = YES;
}

#pragma mark - getters

- (VKAuthorizationView *)authView
{
    return AuthorizationHelper.authView;
}

#pragma mark - private

- (void)_cleanBlocks
{
    self.successBlock = nil;
    self.failureCodeBlock = nil;
    self.failureBlock = nil;
}

@end
