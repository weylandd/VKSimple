//
//  VKAuthorizationResult.m
//  VkSimpleSdk
//

#import "VKAuthorizationResult.h"
#import "VKConsts.h"
#import <UIKit/UIKit.h>

static NSString *kErrorDescription = @"error_description";
static NSString *kAccessToken = @"access_token";
static NSString *kExpiresIn = @"expires_in";
static NSString *kUserId = @"user_id";
static NSString *kError = @"error";

@implementation VKAuthorizationResult

+ (instancetype)resultFromUrl:(NSURL *)url
{
    return [[self alloc] initWithUrlString:url];
}

- (instancetype)initWithUrlString:(NSURL *)url
{
    self = [super init];
    if (self)
    {
        NSString *string = url.absoluteString;
        NSDictionary *parameters = [self _parametersFromUrlString:string];
        if (parameters[kError])
        {
            _error = parameters[kErrorDescription]?: @"";
        }
        else if (parameters[kAccessToken])
        {
            _token = [parameters[kAccessToken] copy];
            _userId = [parameters[kUserId] copy];
            _expiresIn = [parameters[kExpiresIn] integerValue];
            _created = [[NSDate new] timeIntervalSince1970];
            VKlog(@"good auth\nuserId = %@\ntoken = %@", _userId, _token);
        }
    }
    return self;
}

- (NSDictionary *)_parametersFromUrlString:(NSString *)urlString
{
    NSArray *array = [urlString componentsSeparatedByString:@"#"];
    if (array.count > 1)
    {
        return [self _explodeQueryString:[array lastObject]];
    }
    return [self _explodeQueryString:urlString];
}

- (NSDictionary *)_explodeQueryString:(NSString *)queryString
{
    NSArray *keyValuePairs = [queryString componentsSeparatedByString:@"&"];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    for (NSString *keyValueString in keyValuePairs)
    {
        NSArray *keyValueArray = [keyValueString componentsSeparatedByString:@"="];
        parameters[keyValueArray[0]] = keyValueArray[1];
    }
    return parameters;
}

@end
