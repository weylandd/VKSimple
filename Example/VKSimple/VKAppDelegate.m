//
//  VKAppDelegate.m
//  VKSimple
//
//  Created by Alex Kopachev on 01/14/2016.
//  Copyright (c) 2016 Alex Kopachev. All rights reserved.
//

#import "VKAppDelegate.h"
#import "VKSimpleSDK.h"

static NSString *kClientId = @"5202171";

@implementation VKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [VKSimple setClientId:kClientId permissions:VK_PER_FRIENDS + VK_PER_WALL + VK_PER_OFFLINE + VK_PER_PHOTOS];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [VKSimple handleOpenURL:url fromApplication:sourceApplication];
    return YES;
}

@end
