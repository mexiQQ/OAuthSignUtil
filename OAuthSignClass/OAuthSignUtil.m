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
        MBGithubOAuthClient *githubClient = [MBGithubOAuthClient clientWithID:kGithubClientID
                                                                    andSecret:kGithubClientSecret];
        [githubClient oauthRequestWithParameters:@{
                                                   @"client_id" : githubClient.githubClientID,
                                                   @"scope" : @"email,user"
                                                   }];
        githubClient.mydelegate = self;
    }else if(options == SignIntoGoogle){
        GPPSignIn *signIn = [GPPSignIn sharedInstance];
        signIn.clientID = KGoogleClientID;
        signIn.shouldFetchGooglePlusUser = YES;
        signIn.shouldFetchGoogleUserEmail = YES;
        signIn.scopes = [NSArray arrayWithObjects:
                         kGTLAuthScopePlusLogin, // defined in GTLPlusConstants.h
                         nil];
        signIn.delegate = self;
        [signIn authenticate];
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
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.loginClickHandler(viewContrller,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                NSDictionary *re = (NSDictionary *)response.data;
                NSDictionary *userInfo = @{@"username":[re objectForKey:@"screen_name"],@"avatar_url":[re objectForKey:@"profile_image_url"],@"email":@"no"};
                [self finishOAuth:userInfo accessToken:[re objectForKey:@"access_token"]];
            }];
        });
        [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    }
}

-(void)didFinishGithubOAuth:(NSString *)accessToken response:(id)responseObject
{
    NSDictionary *res = (NSDictionary *)responseObject;
    NSDictionary *userInfo = @{@"username":[res objectForKey:@"name"],@"avatar_url":[res objectForKey:@"avatar_url"],@"email":[res objectForKey:@"email"]};
    [self finishOAuth:userInfo accessToken:accessToken];
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error
{
    GTLPlusPerson *person = [GPPSignIn sharedInstance].googlePlusUser;
    NSDictionary *userInfo = @{@"username":person.displayName,@"avatar_url":person.image.url,@"email":[GPPSignIn sharedInstance].userEmail};
    [self finishOAuth:userInfo accessToken:auth.authorizationTokenKey];
}

- (void)finishOAuth:(NSDictionary *) userInfo accessToken:(NSString *)accessToken
{
    [_oAuthDelegate didFinishOAuthSign:userInfo accessToken:accessToken];
}
@end
