//
//  MXOAuthViewController.h
//  OAuthSignUtil
//
//  Created by MexiQQ on 14/12/26.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "MBGithubOAuthClient.h"
#import "MXGoogleOAuthClient.h"
#import "MXQQOAuthClient.h"

@protocol MXGithubOrdGoogleOAuthDelegate <NSObject>
-(void)didFinishGithubOrGoogleOAuth:(NSString *)accessToken response:(id)responseObject;
@end

@interface MXOAuthViewController : UIViewController<UIWebViewDelegate,MBGithubOAuthDelegate,MXGoogleOAuthDelegate,MXQQOAuthDelegate>

@property (nonatomic, assign) id<MXGithubOrdGoogleOAuthDelegate> mydelegate;

@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * ClientID;
@property (nonatomic, strong) NSString * ClientSecret;
@property (nonatomic, strong) NSString * RedirectUrl;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Indicator;
@end
