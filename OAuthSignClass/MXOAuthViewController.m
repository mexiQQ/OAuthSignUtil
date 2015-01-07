//
//  MXOAuthViewController.m
//  OAuthSignUtil
//
//  Created by MexiQQ on 14/12/26.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "MXOAuthViewController.h"
@interface MXOAuthViewController ()

@end

@implementation MXOAuthViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _myWebView.delegate = self;
    [_Indicator startAnimating];
    if([_type isEqualToString:@"github"]){
        MBGithubOAuthClient *githubClient = [MBGithubOAuthClient clientWithID:_ClientID
                                                                    andSecret:_ClientSecret
                                                                    addRedirectUrl:_RedirectUrl];
        NSURL *url = [githubClient getOauthRequestURL];
        githubClient.mydelegate = self;
        [_myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    }else if([_type isEqualToString:@"google"]){
        MXGoogleOAuthClient *googleClient = [MXGoogleOAuthClient clientWithID:_ClientID
                                                                    andSecret:_ClientSecret
                                                               addRedirectUrl:_RedirectUrl];
        NSURL *url = [googleClient getOauthRequestURL];
        googleClient.mydelegate = self;
        [_myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    }else if([_type isEqualToString:@"qq"]){
        MXQQOAuthClient *qqClient = [MXQQOAuthClient clientWithID:_ClientID
                                                        andSecret:_ClientSecret
                                                   addRedirectUrl:_RedirectUrl];
        NSURL *url = [qqClient getOauthRequestURL];
        qqClient.mydelegate = self;
        [_myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    }else if([_type isEqualToString:@"sina"]){
        MXSinaOAuthClient *sinaClient = [MXSinaOAuthClient clientWithID:_ClientID
                                                        andSecret:_ClientSecret
                                                   addRedirectUrl:_RedirectUrl];
        NSURL *url = [sinaClient getOauthRequestURL];
        sinaClient.mydelegate = self;
        [_myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - WebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    if([_type isEqualToString:@"github"]){
        if([request.URL.absoluteString containsString:@"code"]){
            [[MBGithubOAuthClient sharedClient] handleOpenURL:request.URL];
            return NO;
        }
        else{
            return YES;
        }
    }else if([_type isEqualToString:@"google"]){
        if([request.URL.absoluteString containsString:@"code="]){
            [[MXGoogleOAuthClient sharedClient] handleOpenURL:request.URL];
            return NO;
        }
        else{
            return YES;
        }
    }else if([_type isEqualToString:@"qq"]){
        if([request.URL.absoluteString containsString:@"code="]){
            [[MXQQOAuthClient sharedClient] handleOpenURL:request.URL];
            return NO;
        }
        else{
            return YES;
        }
    }else if([_type isEqualToString:@"sina"]){
        if([request.URL.absoluteString containsString:@"code="]){
            [[MXSinaOAuthClient sharedClient] handleOpenURL:request.URL];
            return NO;
        }
        else{
            return YES;
        }
    }

    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_Indicator setHidden:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_Indicator setHidden:YES];
}

-(void)didFinishGithubOAuth:(NSString *)accessToken response:(id)responseObject
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        [self finishOAuth:accessToken type:@"Github"];
    }];
}

- (void)didFinishGoogleOAuth:(NSString *)accessToken response:(id)responseObject{
    [self dismissViewControllerAnimated:YES completion:^(void){
        [self finishOAuth:accessToken type:@"Google"];
    }];
}

- (void)didFinishQQOAuth:(NSString *)accessToken response:(id)responseObject{
    [self dismissViewControllerAnimated:YES completion:^(void){
        [self finishOAuth:accessToken type:@"QQ"];
    }];
}

- (void)didFinishSinaOAuth:(NSString *)accessToken response:(id)responseObject{
    [self dismissViewControllerAnimated:YES completion:^(void){
        [self finishOAuth:accessToken type:@"Sina"];
    }];
}

- (void)finishOAuth:(NSString *)accessToken type:(NSString *)type{
    [_mydelegate didFinishOAuthViewSign:accessToken type:type];
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^(void){
        NSLog(@"取消");
    }];
}

@end
