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
    [UMSocialData setAppKey:@"5211818556240bc9ee01db2f"];
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    return YES;
}

- (BOOL)application: (UIApplication *)application openURL: (NSURL *)url sourceApplication: (NSString *)sourceApplication annotation: (id)annotation {
    if([url.absoluteString containsString:@"gitauth"]){
        return [[MBGithubOAuthClient sharedClient] handleOpenURL:url];
    }else if([url.absoluteString containsString:@"com.ljw.test"]){
        return [GPPURLHandler handleURL:url
                      sourceApplication:sourceApplication
                             annotation:annotation];
    }else{
        return [UMSocialSnsService handleOpenURL:url];
    }
}



@end
