//
//  VKLikes.m
//  VkSimpleSdk
//

#import "VKLikes.h"
#import "VKConsts.h"

static NSString *kCount = @"count";
static NSString *kUserLikes = @"user_likes";

@implementation VKLikes

+ (instancetype)likesFromResponse:(id)response
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
        _userLikes = [dictionary[kUserLikes] integerValue];
    }
    return self;
}

@end
