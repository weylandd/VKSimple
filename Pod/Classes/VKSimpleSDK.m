//
//  VKSimpleSDK.m
//  VkSimpleSdk
//

#import "VKSimpleSDK.h"
#import "VKStorage.h"
#import "VKAuthorizationHelper.h"

@implementation VKSimpleSDK

+ (instancetype)sharedSimpleSDK
{
    static id sharedSimpleSDK = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSimpleSDK = [[[self class] alloc] init];
    });
    return sharedSimpleSDK;
}

- (void)setClientId:(NSString *)clientId permissions:(NSInteger)permissions
{
    [AuthorizationHelper setClientId:clientId];
    [AuthorizationHelper setPermissions:permissions];
}

- (void)handleOpenURL:(NSURL *)url fromApplication:(NSString *)aplication
{
    [AuthorizationHelper handleOpenURL:url fromApplication:aplication];
}

- (void)wakeUpSuccess:(CodeBlock)success failure:(FailureBlock)failure
{
    // проверяем на наличие токена и время его жизни (если в настройки доступа не передан VK_PER_OFFLINE)
    if (![VKStorage isTokenValid])
    {
        if (failure)
        {
            failure(YES, nil);
        }
        return;
    }
    // пробуем вызвать метод для проверки токена
    [VKSimpleMethodsUsers get_success:^(VKUser *user) {
        if (success)
        {
            success();
        }
    } failure:^(BOOL isConnection, VKApiError *error) {
        if (!isConnection)
        {
            [AuthorizationHelper logout];
        }
        if (failure)
        {
            failure(isConnection, error);
        }
    }];
}

@end
