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
-(void)didFinishOAuthSign:(NSString *)type accessToken:(NSString *)accessToken{
     NSLog(@"type is %@ \n accessToken = %@",type,accessToken);
}

//授权
- (IBAction)loginAction:(id)sender {
    [[OAuthSignUtil sharedOAuthSignUtil] signInto:SignIntoSina viewController:self];
    [OAuthSignUtil sharedOAuthSignUtil].oAuthDelegate = self;
}

@end
