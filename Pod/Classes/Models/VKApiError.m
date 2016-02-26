//
//  VKError.m
//  VkSimpleSdk
//

#import "VKApiError.h"

NSString * const VKAuthFailedNotification = @"VKAuthFailedNotification";

static NSString *kError = @"error";
static NSString *kCode = @"error_code";
static NSString *kMessage = @"error_msg";

@implementation VKApiError

+ (instancetype)errorFromResponse:(id)response
{
    if ([response isKindOfClass:[NSDictionary class]])
    {
        id error = response[kError];
        if (error && [error isKindOfClass:[NSDictionary class]])
        {
            VKApiError *error = [[VKApiError alloc] initWithError:response[kError]];
            if ([error.code isEqualToNumber:@5])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:VKAuthFailedNotification object:nil];
            }
            return error;
        }
    }
    return nil;
}

- (instancetype)initWithError:(NSDictionary *)error
{
    self = [super init];
    if (self)
    {
        _code = error[kCode];
        _message = error[kMessage];
    }
    return self;
}

@end
