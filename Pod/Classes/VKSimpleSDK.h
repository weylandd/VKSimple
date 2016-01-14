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

// первоначальная настройка
- (void)setClientId:(NSString *)clientId permissions:(NSInteger)permissions;

// обработка полученого урл
- (void)handleOpenURL:(NSURL *)url fromApplication:(NSString *)aplication;

// проверка на авторизован / не авторизован
- (void)wakeUpSuccess:(CodeBlock)success failure:(FailureBlock)failure;

@end
