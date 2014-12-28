//
//  MXQQOAuthClient.m
//  OAuthSignUtil
//
//  Created by MexiQQ on 14/12/28.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//


#import "MXQQOAuthClient.h"

static NSString * const kMBAccessTokenRegexPattern = @"access_token=([^&]+)";

@implementation MXQQOAuthClient

+ (instancetype)clientWithID:(NSString *)clientID andSecret:(NSString *)clientSecret;
{
    MXQQOAuthClient *sharedClient = [MXQQOAuthClient sharedClient];
    sharedClient.qqClientID = clientID;
    sharedClient.qqClientSecret = clientSecret;
    
    return sharedClient;
}

+ (instancetype)sharedClient;
{
    static MXQQOAuthClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[MXQQOAuthClient alloc] init];
    });
    
    return sharedClient;
}

- (void)tokenRequestWithCallbackURL:(NSURL *)url completion:(MXQQOAuthClientCompletionHandler)completionHandler
{
    
    NSString *requestString = [NSString stringWithFormat:@"https://graph.qq.com/oauth2.0/token?code=%@&client_id=100522525&client_secret=847a2742c2fe5d6c13e5fbb68967f128&redirect_uri=http://segmentfault.com/user/oauth/qq&grant_type=authorization_code", [self temporaryCodeFromCallbackURL:url]];
    
    STHTTPRequest *r = [STHTTPRequest requestWithURLString:requestString];
    
    r.completionBlock = ^(NSDictionary *headers, NSString *string) {
        NSRange range = NSMakeRange(13, 32);
        [self finishOAuth:[string substringWithRange:range] response:nil];
    };
    r.errorBlock = ^(NSError *error) {
        NSLog(@"访问异常");
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
    [_mydelegate didFinishQQOAuth:accessToken response:responseObject];
}

#pragma mark - UIWebViewURL

- (NSURL *)getOauthRequestURL
{
    return [NSURL URLWithString:@"https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=100522525&redirect_uri=http://segmentfault.com/user/oauth/qq"];
}



@end
