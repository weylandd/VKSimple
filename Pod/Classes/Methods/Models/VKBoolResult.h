//
//  VKBoolAnswer.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKConsts.h"

@interface VKBoolResult : NSObject

@property (nonatomic, assign) BOOL value;

+ (void)parseResultFromResponse:(id)response
                        success:(CodeBlock)success
                        failure:(FailureBlock)failure;

+ (instancetype)resultFromResponse:(id)response;

@end
