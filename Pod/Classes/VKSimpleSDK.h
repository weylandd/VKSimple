//
//  VKSimpleSDK.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VKSimpleAuthorization.h"
#import "VKMethods.h"

#define VKSimple [VKSimpleSDK sharedSimpleSDK]

@interface VKSimpleSDK : NSObject

+ (instancetype)sharedSimpleSDK;

- (void)setClientId:(NSString *)clientId permissions:(NSInteger)permissions;

- (void)handleOpenURL:(NSURL *)url fromApplication:(NSString *)aplication;

- (void)wakeUpSuccess:(CodeBlock)success failure:(FailureBlock)failure;

@end
