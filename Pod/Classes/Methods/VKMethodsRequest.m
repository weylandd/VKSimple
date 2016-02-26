//
//  VKMethodsRequest.m
//  VkSimpleSdk
//

#import "VKMethodsRequest.h"
#import "AFNetworking.h"
#import "VKConsts.h"
#import "VKSdkVersion.h"
#import "VKStorage.h"

static NSString *kApiVkMethod = @"https://api.vk.com/method/";
static NSString *kResponse = @"response";

static NSString *kParam_version = @"version";
static NSString *kParam_token = @"access_token";

static NSString *kErrorCodeKey = @"_kCFStreamErrorCodeKey";

@implementation VKMethodsRequest

+ (void)responseWithMethod:(NSString *)method params:(NSDictionary *)params isNeedToken:(BOOL)isNeedToken completion:(ResponseBlock)completion failure:(FailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@%@", kApiVkMethod, method];
    [manager GET:url
      parameters:[self _paramsWithVersion:params isNeedToken:isNeedToken]
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             [self _parseResponseObject:responseObject completion:completion];
         } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             BOOL isConnection = ![self _isConnectionError:error];
             if (!isConnection)
             {
                 VKError(@"%@\nconnection problem", error);
             }
             if (failure)
             {
                 failure(isConnection, nil);
             }
         }];
}

#pragma mark - private

+ (void)_parseResponseObject:(id)responseObject completion:(ResponseBlock)completion
{
    if (completion)
    {
        if ([responseObject isKindOfClass:[NSDictionary class]] && responseObject[kResponse])
        {
            completion(responseObject[kResponse]);
            return;
        }
        completion(responseObject);
    }
}

+ (BOOL)_isConnectionError:(NSError *)error
{
    NSDictionary *params = error.userInfo;
    NSInteger code = [params[kErrorCodeKey] integerValue];
    return code == 8;
}

+ (NSDictionary *)_paramsWithVersion:(NSDictionary *)params isNeedToken:(BOOL)isNeedToken
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:params];
    [dict setObject:VK_SDK_API_VERSION forKey:kParam_version];
    if (isNeedToken)
    {
        [dict setObject:ObjectOrNull([VKStorage accessToken]) forKey:kParam_token];
    }
    return dict;
}

static id ObjectOrNull(id object)
{
    return object ?: [NSNull null];
}

@end
