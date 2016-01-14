//
//  VKSimpleAuthorization.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VKConsts.h"
#import "VKPermissions.h"
#import "VKAuthorizationView.h"

#define VKSimpleAuth [VKSimpleAuthorization sharedSimpleAuth]

@interface VKSimpleAuthorization : NSObject

+ (instancetype)sharedSimpleAuth;

@property (nonatomic, strong) VKAuthorizationView *authView;

- (void)authSuccess:(CodeBlock)success failure:(CodeBlock)failure;

- (void)authInViewSuccess:(CodeBlock)success failure:(FailureBlock)failure;

- (void)logout;

@end
