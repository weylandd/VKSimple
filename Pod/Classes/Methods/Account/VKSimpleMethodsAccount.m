//
//  VKSimpleAccountMethods.m
//  VkSimpleSdk
//

#import "VKSimpleMethodsAccount.h"

static NSString *kMethod_setOnline = @"account.setOnline";

static NSString *kParam_voip = @"voip";

@implementation VKSimpleMethodsAccount

+ (void)setOnline_success:(CodeBlock)success failure:(FailureBlock)failure
{
    [self setOnline_withVoip:VKCall_default success:success failure:failure];
}

+ (void)setOnline_withVoip:(VKCall)voip success:(CodeBlock)success failure:(FailureBlock)failure
{
    NSDictionary *params = @{kParam_voip: ObjectOrNull(@(voip))};
    [VKMethodsRequest responseWithMethod:kMethod_setOnline params:params isNeedToken:YES completion:^(id responseObject) {
        [VKBoolResult parseResultFromResponse:responseObject success:success failure:failure];
    } failure:failure];
}

static id ObjectOrNull(id object)
{
    return object ?: [NSNull null];
}

@end
