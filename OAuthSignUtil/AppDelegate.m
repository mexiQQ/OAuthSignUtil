//
//  AppDelegate.m
//  MXGoogleOAuthLogin
//
//  Created by MexiQQ on 14/12/4.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "AppDelegate.h"
#import "OAuthSignUtilHeader.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UMSocialData setAppKey:@"547c0998fd98c5eec80009a9"];
    [UMSocialSinaHandler openSSOWithRedirectURL:@""];
    [UMSocialQQHandler setQQWithAppId:@"100522525" appKey:@"847a2742c2fe5d6c13e5fbb68967f128" url:@"http://segmentfault.com"];
    return YES;
}

- (BOOL)application: (UIApplication *)application openURL: (NSURL *)url sourceApplication: (NSString *)sourceApplication annotation: (id)annotation {
        return [UMSocialSnsService handleOpenURL:url];
}

@end
