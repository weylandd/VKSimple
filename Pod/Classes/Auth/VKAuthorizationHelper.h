//
//  VKAuthorizationHelper.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VKPermissions.h"
@class VKAuthorizationView;

#define AuthorizationHelper [VKAuthorizationHelper sharedAuthorization]

@protocol VKAuthorizationHelperDelegate <NSObject>

@optional

- (void)vkAuthViewAuthSuccess;

- (void)vkAuthViewAuthFailed;

- (void)vkAuthViewDidConnectionProblem;

- (void)vkAuthViewWillOpen;

- (void)vkAuthViewDidClose;

@end

@interface VKAuthorizationHelper : NSObject

@property (nonatomic, weak) id<VKAuthorizationHelperDelegate> output;

@property (nonatomic, strong) VKAuthorizationView *authView;

+ (instancetype)sharedAuthorization;

- (void)setClientId:(NSString *)clientId;

- (void)setPermissions:(NSInteger)permissions; // Example VK_PER_FRIENDS + VK_PER_WALL

- (void)authInVkApp;

- (void)authInVKAuthorizationView;

- (void)logout;

- (BOOL)isTokenValid;

- (void)handleOpenURL:(NSURL *)url fromApplication:(NSString *)aplication;

- (void)handleOpenURL:(NSURL *)url;

@end
