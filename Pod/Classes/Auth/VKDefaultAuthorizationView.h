//
//  VKAuthorizationController.h
//  Pods
//
//  Created by Alex Kopachev on 14.02.16.
//
//

#import <UIKit/UIKit.h>
#import "VKAuthorizationView.h"

@interface VKDefaultAuthorizationView : UIView

@property (nonatomic, strong) VKAuthorizationView *authView;

- (void)present;

- (void)dismiss;

@end
