//
//  VKBoolAnswer.m
//  VkSimpleSdk
//

#import "VKBoolResult.h"

@implementation VKBoolResult

+ (void)parseResultFromResponse:(id)response success:(CodeBlock)success failure:(FailureBlock)failure
{
    VKBoolResult *result = [VKBoolResult resultFromResponse:response];
    if (result.value)
    {
        if (success)
        {
            success();
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
    if (response && [response isKindOfClass:[NSNumber class]])
    {
        return [[self alloc] initWithNumber:response];
    }
    return nil;
}

- (instancetype)initWithNumber:(NSNumber *)number
{
    self = [super init];
    if (self)
    {
        _value = [number boolValue];
    }
    return self;
}

@end
