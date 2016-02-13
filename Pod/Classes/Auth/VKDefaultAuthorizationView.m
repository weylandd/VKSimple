//
//  VKAuthorizationController.m
//  Pods
//
//  Created by Alex Kopachev on 14.02.16.
//
//

#import "VKDefaultAuthorizationView.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]

@interface VKDefaultAuthorizationView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIImageView *logoView;

@end

@implementation VKDefaultAuthorizationView

- (void)present
{
    UIView *topView = [self _topController].view;
    [topView addSubview:self];
    [topView bringSubviewToFront:self];
    self.backgroundColor = RGBA(245, 245, 245, 1);
    
    CGRect rect = [UIScreen mainScreen].bounds;
    CGRect startRect = rect;
    startRect.origin.y = CGRectGetHeight(rect);
    self.frame = startRect;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = rect;
    }];
}

- (void)dismiss
{
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.origin.y = CGRectGetHeight(rect);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        [self.authView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - Actions

- (void)backButtonAction
{
    [self dismiss];
}

#pragma mark - Setters

- (void)setAuthView:(VKAuthorizationView *)authView
{
    _authView = authView;
    [self addSubview:authView];
}

#pragma mark - Private

- (UIViewController *)_topController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    return topController;
}

#pragma mark - > Layout <

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self _layoutTopView];
    [self _layoutBackButton];
    [self _layoutLogoView];
    [self _layoutAuthView];
}

- (void)_layoutTopView
{
    CGRect rect = self.bounds;
    rect.size.height = CGRectGetWidth(rect) < CGRectGetHeight(rect)? 64: 30;
    self.topView.frame = rect;
}

- (void)_layoutBackButton
{
    CGRect rect = self.bounds;
    rect.origin.y = CGRectGetWidth(rect) < CGRectGetHeight(rect)? 20: 0;
    rect.size.height = CGRectGetWidth(rect) < CGRectGetHeight(rect)? 44: 30;
    rect.size.width = 80;
    self.backButton.frame = rect;
}

- (void)_layoutLogoView
{
    CGRect rect = self.bounds;
    NSInteger statusBarHeight = CGRectGetWidth(rect) < CGRectGetHeight(rect)? 20: 0;
    NSInteger navBarHeight = CGRectGetWidth(rect) < CGRectGetHeight(rect)? 64: 30;
    rect.origin.x = (CGRectGetWidth(rect) - 40) / 2;
    rect.origin.y = (navBarHeight - 24) / 2 + statusBarHeight;
    rect.size.width = 40;
    rect.size.height = 24;
    self.logoView.frame = rect;
}

- (void)_layoutAuthView
{
    CGRect rect = self.bounds;
    NSInteger navBarHeight = CGRectGetWidth(rect) < CGRectGetHeight(rect)? 64: 30;
    rect.origin.y += navBarHeight;
    rect.size.height -= navBarHeight;
    self.authView.frame = rect;
}

#pragma mark - Lazy initialization

- (UIView *)topView
{
    if (!_topView)
    {
        _topView = [UIView new];
        _topView.backgroundColor = RGBA(90, 131, 178, 1);
        [self addSubview:_topView];
    }
    return _topView;
}

- (UIButton *)backButton
{
    if (!_backButton)
    {
        _backButton = [UIButton new];
        [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setTitle:@"Отмена" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _backButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        _backButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:_backButton];
    }
    return _backButton;
}

- (UIImageView *)logoView
{
    if (!_logoView)
    {
        _logoView = [UIImageView new];
        _logoView.image = [UIImage imageNamed:@"vk_logo_image"];
        [self.topView addSubview:_logoView];
    }
    return _logoView;
}

@end
