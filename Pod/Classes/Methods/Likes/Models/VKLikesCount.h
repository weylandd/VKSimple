//
//  VKLikesCount.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKConsts.h"

@interface VKLikesCount : NSObject

@property (nonatomic, assign) NSInteger value;

+ (void)parseResultFromResponse:(id)response
                        success:(void(^)(VKLikesCount *likesCount))success
                        failure:(FailureBlock)failure;

+ (instancetype)resultFromResponse:(id)response;

@end
