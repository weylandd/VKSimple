//
//  VKArrayResult.m
//  VkSimpleSdk
//

#import "VKArrayResult.h"

static NSString *kParam_count = @"count";
static NSString *kParam_users = @"users";

@implementation VKArrayResult

+ (void)parseResultFromResponse:(id)response success:(void(^)(VKArrayResult *result))success failure:(FailureBlock)failure
{
    VKArrayResult *result = [VKArrayResult resultFromResponse:response];
    if (result)
    {
        if (success)
        {
            success(result);
        }
        return;
    }
    VKApiError *error = [VKApiError errorFromResponse:response];
    if (failure)
    {
        failure(YES, error);
    }
    if (error)
    {
        VKApiError(@"%@", error.message);
    }
    else
    {
        VKError(@"parse error");
    }
}

+ (instancetype)resultFromResponse:(id)response
{
    if (response && [response isKindOfClass:[NSDictionary class]])
    {
        id count = response[kParam_count];
        if (count && [count isKindOfClass:[NSNumber class]])
        {
            return [[self alloc] initWithDictionary:response];
        }
    }
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _count = dictionary[kParam_count];
        _array = dictionary[kParam_users];
    }
    return self;
}

@end
