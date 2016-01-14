//
//  VKArrayResult.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKConsts.h"

@interface VKArrayResult : NSObject

@property (nonatomic, assign) NSNumber *count;
@property (nonatomic, strong) NSArray *array;

+ (void)parseResultFromResponse:(id)response
                        success:(void(^)(VKArrayResult *result))success
                        failure:(FailureBlock)failure;

+ (instancetype)resultFromResponse:(id)response;

@end
