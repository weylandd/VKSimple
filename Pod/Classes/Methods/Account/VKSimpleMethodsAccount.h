//
//  VKSimpleAccountMethods.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKMethodsRequest.h"

typedef NS_ENUM(NSInteger, VKCall)
{
    VKCall_default,
    VKCall_possible
};

@interface VKSimpleMethodsAccount : NSObject

+ (void)setOnline_success:(CodeBlock)success failure:(FailureBlock)failure;
+ (void)setOnline_withVoip:(VKCall)voip success:(CodeBlock)success failure:(FailureBlock)failure;

@end
