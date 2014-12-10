//
//  OAuthSignUtil.h
//  OAuthSignUtils
//
//  Created by MexiQQ on 14/12/8.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

//github
#define kGithubClientID @"f0ef3164bde57f49c9b1"
#define kGithubClientSecret @"e8a747d116e8d56535103f3b67eab18b7004399b"

//google
#define KGoogleClientID @"602865423207-1v9cenqp7e78lsgv5e3t3k05o877mjap.apps.googleusercontent.com"
//UMeng

#import <Foundation/Foundation.h>
#import "MBGithubOAuthClient.h"
#import "UMSocial.h"
#import "UMSocialSinaHandler.h"

#import <GooglePlus/GooglePlus.h>
#import <QuartzCore/QuartzCore.h>
#import "GPPSignIn.h"
#import "GPPSignInButton.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
@protocol OAuthSignUtilDelegate<NSObject>

@required
-(void)didFinishOAuthSign:(NSDictionary *)userInfo accessToken:(NSString *) accessToken;

@end

typedef enum {
    SignIntoGithub,
    SignIntoGoogle,
    SignIntoSina,
    SignIntoQQ
} SignInOptions;

typedef void(^OAuthSignUtilCompletionHandler) (BOOL success, NSError *error);

@interface OAuthSignUtil : NSObject <MBGithubOAuthDelegate,UMSocialUIDelegate,GPPSignInDelegate>

@property (nonatomic,assign) id<OAuthSignUtilDelegate> oAuthDelegate;

+(OAuthSignUtil *)sharedOAuthSignUtil;

-(void)print;
-(void)signInto:(SignInOptions)options viewController:(UIViewController *)viewContrller;

@end
