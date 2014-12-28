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
#define kGithubRedirectUrl @""

//google
#define KGoogleClientID @"602865423207-a0hsl9nq65ddsc5fc1t7vb7pu0m36fv5.apps.googleusercontent.com"
#define kGoogleClientSecret @"lbkdtIUyN-gB-3CwhhZzn5jR"
#define kGoogleRedirectUrl @""

//QQ
#define KQQClientID @"100424468"
#define kQQClientSecret @"c7394704798a158208a74ab60104f0ba"
#define kQQRedirectUrl @"http://www.umeng.com/social"


//UMeng
#import <Foundation/Foundation.h>
#import "UMSocial.h"
#import "UMSocialSinaHandler.h"

#import "MXOAuthViewController.h"
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

@interface OAuthSignUtil : NSObject <MXGithubOrdGoogleOAuthDelegate,UMSocialUIDelegate>

@property (nonatomic,assign) id<OAuthSignUtilDelegate> oAuthDelegate;

+(OAuthSignUtil *)sharedOAuthSignUtil;

-(void)signInto:(SignInOptions)options viewController:(UIViewController *)viewContrller;

@end
