//
//  VkStorage.h
//  VkSimpleSdk
//

#import <UIKit/UIKit.h>
@class VKAuthorizationResult;

@interface VKStorage : NSObject

+ (void)saveAuthorizationResult:(VKAuthorizationResult *)result;

+ (NSString *)accessToken;
+ (NSString *)userId;

+ (void)saveIsUserLogged:(BOOL)isUserLogged;
+ (BOOL)isUserLogged;

+ (BOOL)isTokenValid;
+ (BOOL)isExpired;

+ (void)removeUserInfo;

@end
