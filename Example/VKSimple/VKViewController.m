//
//  VKViewController.m
//  VKSimple
//
//  Created by Alex Kopachev on 01/14/2016.
//  Copyright (c) 2016 Alex Kopachev. All rights reserved.
//

#import "VKViewController.h"
#import "VKSimpleSDK.h"

@interface VKViewController ()

@property (nonatomic, weak) IBOutlet UIButton *signInApp;
@property (nonatomic, weak) IBOutlet UIButton *signInWeb;
@property (nonatomic, weak) IBOutlet UIButton *signOut;

// окно авторизации // с версии 1.2 его необязательно устанавливать, хотя и можно
//@property (nonatomic, strong) VKAuthorizationView *authView;
@property (nonatomic, assign) BOOL isUserLogged;

@end

@implementation VKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _setupInitialState];
}

- (void)_setupInitialState
{
    // метод проверяет авторизованы ли вы
    [VKSimple wakeUpSuccess:^{
        self.isUserLogged = YES;
    } failure:^(BOOL isConnection, VKApiError *error) {
        self.isUserLogged = !isConnection;
    }];
//    self.authView = VKSimpleAuth.authView;
//    self.authView.hidden = YES;
//    [self.view addSubview:self.authView];
}

#pragma mark - > layout <

- (void)viewWillLayoutSubviews
{
    [self _layoutAuthView];
}

- (void)_layoutAuthView
{
    // устанавливаем frame для окна авторизации
//    CGRect rect = self.view.bounds;
//    self.authView.frame = rect;
}

#pragma mark - actions

- (IBAction)signInWebButtonDidPressed:(id)sender
{
    // авторизация через web view
    [VKSimpleAuth authInViewSuccess:^{
        self.isUserLogged = YES;
    } failure:nil];
}
- (IBAction)signInAppButtonDidPressed:(id)sender
{
    // авторизация через официальное приложение
    [VKSimpleAuth authSuccess:^{
        self.isUserLogged = YES;
    } failure:nil];
}

- (IBAction)signOutButtonDidPressed:(id)sender
{
    // выход из под аккаунта
    [VKSimpleAuth logout];
    self.isUserLogged = NO;
}

#pragma mark - setters

- (void)setIsUserLogged:(BOOL)isUserLogged
{
    _isUserLogged = isUserLogged;
    self.signInApp.hidden = isUserLogged;
    self.signInWeb.hidden = isUserLogged;
    self.signOut.hidden = !isUserLogged;
}

@end
