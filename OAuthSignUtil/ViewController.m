//
//  ViewController.m
//  OAuthSignUtil
//
//  Created by MexiQQ on 14/12/9.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "ViewController.h"
#import "MXOAuthViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//回调
-(void)didFinishOAuthSign:(NSDictionary *)userInfo accessToken:(NSString *)accessToken{
    NSLog(@"accessToken = %@",accessToken);
}

//授权
- (IBAction)loginAction:(id)sender {
    [[OAuthSignUtil sharedOAuthSignUtil] signInto:SignIntoGithub viewController:self];
    [OAuthSignUtil sharedOAuthSignUtil].oAuthDelegate = self;
}

@end
