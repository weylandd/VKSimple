//
//  VKAuthorizationView.h
//  VkSimpleSdk
//

#import <UIKit/UIKit.h>

@protocol VKAuthorizationViewDelegate <NSObject>

- (void)vkAuthViewAuthSuccess;

- (void)vkAuthViewAuthFailed;

@optional

- (void)vkAuthViewDidConnectionProblem;

@end

@interface VKAuthorizationView : UIView

@property (nonatomic, weak) id<VKAuthorizationViewDelegate> output;

- (void)authWithURL:(NSURL *)url;

@end
