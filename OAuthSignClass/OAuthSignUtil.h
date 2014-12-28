//
//  OAuthSignUtil.h
//  OAuthSignUtils
//
//  Created by MexiQQ on 14/12/8.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

//github 公司
#define kGithubClientID @"b15cfa4c38d52ce679bd"
#define kGithubClientSecret @"d4d3577156895553a2ebc5337038fe425886e074"

//github 个人
//#define kGithubClientID @"f0ef3164bde57f49c9b1"
//#define kGithubClientSecret @"e8a747d116e8d56535103f3b67eab18b7004399b"

//google 个人
#define KGoogleClientID @"602865423207-a0hsl9nq65ddsc5fc1t7vb7pu0m36fv5.apps.googleusercontent.com"
#define kGoogleClientSecret @"lbkdtIUyN-gB-3CwhhZzn5jR"

//google 公司
//#define KGoogleClientID @"1036396677040.apps.googleusercontent.com"
//#define kGoogleClientSecret @"bEbv0ErmM-5VdajbNTR0SOYl"

//QQ 公司
#define KQQClientID @"100522525"
#define kQQClientSecret @"847a2742c2fe5d6c13e5fbb68967f128"


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
