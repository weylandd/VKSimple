//
//  VKAuthorizationController.h
//  VkSimpleSdk
//

#import <UIKit/UIKit.h>
#import "VKAuthorizationView.h"

@interface VKDefaultAuthorizationView : UIView

@property (nonatomic, strong) VKAuthorizationView *authView;

- (void)present;

- (void)dismiss;

@end
