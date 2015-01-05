//
//  MXSinaOAuthClient.m
//  OAuthSignUtil
//
//  Created by MexiQQ on 15/1/5.
//  Copyright (c) 2015年 MexiQQ. All rights reserved.
//

#import "MXSinaOAuthClient.h"

static NSString * const kMBAccessTokenRegexPattern = @"access_token=([^&]+)";

@implementation MXSinaOAuthClient

+ (instancetype)clientWithID:(NSString *)clientID andSecret:(NSString *)clientSecret addRedirectUrl:(NSString *)clientRedirectUrl;
{
    MXSinaOAuthClient *sharedClient = [MXSinaOAuthClient sharedClient];
    sharedClient.sinaClientID = clientID;
    sharedClient.sinaClientSecret = clientSecret;
    sharedClient.sinaRedirectUrl = clientRedirectUrl;
    return sharedClient;
}

+ (instancetype)sharedClient;
{
    static MXSinaOAuthClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[MXSinaOAuthClient alloc] init];
    });
    
    return sharedClient;
}

- (void)tokenRequestWithCallbackURL:(NSURL *)url completion:(MXSinaOAuthClientCompletionHandler)completionHandler
{
    
    NSString *requestString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token"];
    
    STHTTPRequest *r = [STHTTPRequest requestWithURLString:requestString];
    r.POSTDictionary = @{@"code":[self temporaryCodeFromCallbackURL:url], @"client_id":_sinaClientID, @"client_secret":_sinaClientSecret,@"redirect_uri":_sinaRedirectUrl,@"grant_type":@"authorization_code"};
    r.completionDataBlock = ^(NSDictionary *headers, NSData *data) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        [self finishOAuth:[response objectForKey:@"access_token"] response:nil];
    };
    r.errorBlock = ^(NSError *error) {
        NSLog(@"访问异常:%@",error);
    };
    [r startAsynchronous];
}

#pragma mark - Saving

- (NSString *)accessTokenFromString:(NSString *)string
{
    __block NSString *accessToken = nil;
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kMBAccessTokenRegexPattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    if (!error && [matches count] > 0) {
        [matches enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSRange matchRange = [(NSTextCheckingResult *)obj rangeAtIndex:1];
            accessToken = [string substringWithRange:matchRange];
        }];
    }
    
    return accessToken;
}

- (NSString *)temporaryCodeFromCallbackURL:(NSURL *)callbackURL
{
    return [[[callbackURL absoluteString] componentsSeparatedByString:@"="] lastObject];
}

- (void)throwException
{
    [NSException raise:@"EXCEPTION: INVALID OBJECT TYPE" format:@"Please make sure your parameters dictionary contains strings only. Thanks!"];
}

- (BOOL)handleOpenURL:(NSURL *)url{
    [self tokenRequestWithCallbackURL:url completion:^(BOOL success, NSError *error) {
    }];
    return YES;
}

- (void)finishOAuth:(NSString *)accessToken response:(id)responseObject{
    [_mydelegate didFinishSinaOAuth:accessToken response:responseObject];
}

#pragma mark - UIWebViewURL

- (NSURL *)getOauthRequestURL
{
    NSLog(@"https://api.weibo.com/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=%@",_sinaClientID,_sinaRedirectUrl);
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=%@",_sinaClientID,_sinaRedirectUrl]];
}

@end
