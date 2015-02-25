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
#define kGithubRedirectUrl @"http://segmentfault.com/user/oauth/github"

//google 公司
#define KGoogleClientID @"1036396677040.apps.googleusercontent.com"
#define kGoogleClientSecret @"bEbv0ErmM-5VdajbNTR0SOYl"
#define kGoogleRedirectUrl @"http://segmentfault.com/user/oauth/google"

//QQ 公司
#define KQQClientID @"100522525"
#define kQQClientSecret @"847a2742c2fe5d6c13e5fbb68967f128"
#define kQQRedirectUrl @"http://segmentfault.com/user/oauth/qq"

//sina
#define KSinaClientID @"1742025894"
#define KSinaClientSecret @"c18d2bbaf9a6cb9344e994292ebab29f"
#define KSinaRedirectUrl @"http://segmentfault.com/user/oauth/qq"

#import <Foundation/Foundation.h>
#import "MXOAuthViewController.h"
@protocol OAuthSignUtilDelegate<NSObject>

@required
-(void)didFinishOAuthSign:(NSString *)type accessToken:(NSString *) accessToken;

@end

typedef enum {
    SignIntoGithub,
    SignIntoGoogle,
    SignIntoSina,
    SignIntoQQ
} SignInOptions;

typedef void(^OAuthSignUtilCompletionHandler) (BOOL success, NSError *error);

@interface OAuthSignUtil : NSObject <MXOAuthViewDelegate>

@property (nonatomic,assign) id<OAuthSignUtilDelegate> oAuthDelegate;

+(OAuthSignUtil *)sharedOAuthSignUtil;

-(void)signInto:(SignInOptions)options viewController:(UIViewController *)viewContrller;

@end
