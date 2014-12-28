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
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        snsPlatform.loginClickHandler(viewContrller,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                NSDictionary *re = (NSDictionary *)response.data;
                NSDictionary *userInfo = @{@"username":[re objectForKey:@"screen_name"],@"avatar_url":[re objectForKey:@"profile_image_url"],@"email":@"no"};
                [self finishOAuth:userInfo accessToken:[re objectForKey:@"access_token"]];
            }];
        });
        [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
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

- (void)didFinishGithubOrGoogleOAuth:(NSString *)accessToken response:(id)responseObject{
    [self finishOAuth:nil accessToken:accessToken];
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
    NSDictionary *userInfo = @{@"username":snsAccount.userName,@"avatar_url":snsAccount.iconURL,@"email":@"no"};
    [self finishOAuth:userInfo accessToken:snsAccount.accessToken];
}

- (void)finishOAuth:(NSDictionary *) userInfo accessToken:(NSString *)accessToken
{
    [_oAuthDelegate didFinishOAuthSign:userInfo accessToken:accessToken];
}
@end
