//
//  MXGoogleOAuthClient.m
//  OAuthSignUtil
//
//  Created by MexiQQ on 14/12/26.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "MXGoogleOAuthClient.h"

static NSString * const kOAuthBaseURLString = @"https://accounts.google.com/o/oauth2/auth?";
static NSString * const kOAuthTokenURLString = @"https://www.googleapis.com/oauth2/v3/token";
static NSString * const kMBAccessTokenRegexPattern = @"access_token=([^&]+)";

@implementation MXGoogleOAuthClient

+ (instancetype)clientWithID:(NSString *)clientID andSecret:(NSString *)clientSecret;
{
    MXGoogleOAuthClient *sharedClient = [MXGoogleOAuthClient sharedClient];
    sharedClient.googleClientID = clientID;
    sharedClient.googleClientSecret = clientSecret;
    
    return sharedClient;
}

+ (instancetype)sharedClient;
{
    static MXGoogleOAuthClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[MXGoogleOAuthClient alloc] init];
    });
    
    return sharedClient;
}

- (void)tokenRequestWithCallbackURL:(NSURL *)url completion:(MXGoogleOAuthClientCompletionHandler)completionHandler
{
    
    NSString *requestString = @"https://www.googleapis.com/oauth2/v3/token";
    
    STHTTPRequest *r = [STHTTPRequest requestWithURLString:[NSString stringWithFormat:@"%@",requestString]];
    r.POSTDictionary = @{@"code":[self temporaryCodeFromCallbackURL:url], @"client_id":@"1036396677040.apps.googleusercontent.com", @"client_secret":@"bEbv0ErmM-5VdajbNTR0SOYl",@"redirect_uri":@"http://segmentfault.com/user/oauth/google",@"grant_type":@"authorization_code"};
    [r setHeaderWithName:@"Content-Type" value:@"application/x-www-form-urlencoded;charset=utf-8"];
    r.completionDataBlock = ^(NSDictionary *headers, NSData *data) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        [self finishOAuth:[response objectForKey:@"access_token"] response:nil];
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
    [_mydelegate didFinishGoogleOAuth:accessToken response:responseObject];
}

#pragma mark - UIWebViewURL

- (NSURL *)getOauthRequestURL
{
    return [NSURL URLWithString:@"https://accounts.google.com/o/oauth2/auth?scope=email%20profile&state=security_token&redirect_uri=http://segmentfault.com/user/oauth/google&response_type=code&client_id=1036396677040.apps.googleusercontent.com&approval_prompt=force"];
}

@end
