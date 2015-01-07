//
//  OAuthSignUtil.m
//  OAuthSignUtils
//
//  Created by MexiQQ on 14/12/8.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "OAuthSignUtil.h"


@implementation OAuthSignUtil
static OAuthSignUtil *shareOAuthSignUtil = nil;

//单例类
+(OAuthSignUtil *)sharedOAuthSignUtil
{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        shareOAuthSignUtil = [[self alloc] init];
    });
    return  shareOAuthSignUtil;
}

//signIn方法
-(void)signInto:(SignInOptions)options viewController:(UIViewController *)viewContrller
{
    if(options == SignIntoGithub){
        MXOAuthViewController *mx = [[MXOAuthViewController alloc] initWithNibName:@"MXOAuthWebView" bundle:nil];
        mx.type = @"github";
        mx.ClientID = kGithubClientID;
        mx.ClientSecret = kGithubClientSecret;
        mx.RedirectUrl = kGithubRedirectUrl;
        mx.mydelegate = self;
        [viewContrller presentViewController:mx animated:YES completion:^(void){
            NSLog(@"success");
        }];
    }else if(options == SignIntoGoogle){
        MXOAuthViewController *mx = [[MXOAuthViewController alloc] initWithNibName:@"MXOAuthWebView" bundle:nil];
        mx.type = @"google";
        mx.ClientID = KGoogleClientID;
        mx.ClientSecret = kGoogleClientSecret;
        mx.RedirectUrl = kGoogleRedirectUrl;
        mx.mydelegate = self;
        [viewContrller presentViewController:mx animated:YES completion:^(void){
            NSLog(@"success");
        }];
    }else if(options == SignIntoSina){
        MXOAuthViewController *mx = [[MXOAuthViewController alloc] initWithNibName:@"MXOAuthWebView" bundle:nil];
        mx.type = @"sina";
        mx.ClientID = KSinaClientID;
        mx.ClientSecret = KSinaClientSecret;
        mx.RedirectUrl = KSinaRedirectUrl;
        mx.mydelegate = self;
        [viewContrller presentViewController:mx animated:YES completion:^(void){
            NSLog(@"success");
        }];
    }else if(options == SignIntoQQ){
        MXOAuthViewController *mx = [[MXOAuthViewController alloc] initWithNibName:@"MXOAuthWebView" bundle:nil];
        mx.type = @"qq";
        mx.ClientID = KQQClientID;
        mx.ClientSecret = kQQClientSecret;
        mx.RedirectUrl = kQQRedirectUrl;
        mx.mydelegate = self;
        [viewContrller presentViewController:mx animated:YES completion:^(void){
            NSLog(@"success");
        }];
      }
}

- (void)didFinishOAuthViewSign:(NSString *)accessToken type:(NSString *)type{
    [self finishOAuth:type accessToken:accessToken];
}

- (void)finishOAuth:(NSString *) type accessToken:(NSString *)accessToken
{
    [_oAuthDelegate didFinishOAuthSign:type accessToken:accessToken];
}
@end
