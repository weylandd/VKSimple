//
//  VKLikesCount.m
//  VkSimpleSdk
//

#import "VKLikesCount.h"

static NSString *kParam_likes = @"likes";

@implementation VKLikesCount

+ (void)parseResultFromResponse:(id)response success:(void (^)(VKLikesCount *likesCount))success failure:(FailureBlock)failure
{
    VKLikesCount *result = [VKLikesCount resultFromResponse:response];
    if (result.value)
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
        return [[self alloc] initWithDictionary:response];
    }
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _value = [dict[kParam_likes] integerValue];
    }
    return self;
}

@end
