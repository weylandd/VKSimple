//
//  VKReposts.m
//  VkSimpleSdk
//

#import "VKReposts.h"
#import "VKConsts.h"

static NSString *kCount = @"count";

@implementation VKReposts

+ (instancetype)repostsFromResponse:(id)response
{
    if (response && [response isKindOfClass:[NSDictionary class]])
    {
        return [[self alloc] initWithDictionary:response];
    }
    VKApiError *error = [VKApiError errorFromResponse:response];
    if (error)
    {
        VKApiError(@"%@", error.message);
    }
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _count = [dictionary[kCount] integerValue];
    }
    return self;
}

@end
