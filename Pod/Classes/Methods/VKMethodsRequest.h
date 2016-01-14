//
//  VKMethodsRequest.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKBoolResult.h"
#import "VKConsts.h"

typedef void(^ResponseBlock)(id responseObject);

@interface VKMethodsRequest : NSObject

+ (void)responseWithMethod:(NSString *)method
                    params:(NSDictionary *)params
               isNeedToken:(BOOL)isNeedToken
                completion:(ResponseBlock)completion
                   failure:(FailureBlock)failure;

@end
