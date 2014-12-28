//
//  OAuthSignUtil.h
//  OAuthSignUtils
//
//  Created by MexiQQ on 14/12/8.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

//github
#define kGithubClientID @""
#define kGithubClientSecret @""
#define kGithubRedirectUrl @""

//google
#define KGoogleClientID @""
#define kGoogleClientSecret @""
#define kGoogleRedirectUrl @""

//QQ
#define KQQClientID @""
#define kQQClientSecret @""
#define kQQRedirectUrl @""


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
