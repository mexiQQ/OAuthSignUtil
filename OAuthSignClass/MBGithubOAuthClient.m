//
//  OAuthSignUtil.h
//  OAuthSignUtils
//
//  Created by MexiQQ on 14/12/8.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "MBGithubOAuthClient.h"

static NSString * const kOAuthBaseURLString = @"https://github.com/login/oauth/";
static NSString * const kMBAccessTokenRegexPattern = @"access_token=([^&]+)";

@implementation MBGithubOAuthClient

+ (instancetype)clientWithID:(NSString *)clientID andSecret:(NSString *)clientSecret;
{
    MBGithubOAuthClient *sharedClient = [MBGithubOAuthClient sharedClient];
    sharedClient.githubClientID = clientID;
    sharedClient.githubClientSecret = clientSecret;
    
    return sharedClient;
}

+ (instancetype)sharedClient;
{
    static MBGithubOAuthClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[MBGithubOAuthClient alloc] init];
    });
    
    return sharedClient;
}

- (void)oauthRequestWithParameters:(NSDictionary *)parameters
{
    __weak typeof(self) weakSelf = self;
    __block NSString *parametersString = nil;
    
    if (parameters) {
        
        [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            if ([obj isKindOfClass:[NSString class]]) {
                
                parametersString = [[NSString alloc]init];
                NSString *parameter = (NSString *)obj;
                parametersString = [parametersString stringByAppendingString:parameter];
                
            } else {
                [weakSelf throwException];
                
            }
        }];
        
    }
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@authorize?client_id=%@&scope=%@",
                                                                    kOAuthBaseURLString,
                                                                    _githubClientID,
                                                                    parametersString]]];
}

- (void)tokenRequestWithCallbackURL:(NSURL *)url saveOptions:(kMBSaveOptions)options completion:(MBGithubOAuthClientCompletionHandler)completionHandler
{
    NSString *requestString = [NSString stringWithFormat:@"%@access_token?client_id=%@&client_secret=%@&code=%@",
                               kOAuthBaseURLString,
                               _githubClientID,
                               _githubClientSecret,
                               [self temporaryCodeFromCallbackURL:url]];
    
    __block NSString *accessTokenData = nil;
    
    NSURLSessionConfiguration *sessionConficuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConficuration];
    
    [[session dataTaskWithURL:[NSURL URLWithString:requestString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (!error) {
                    accessTokenData = [self accessTokenFromString:[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding]];
                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                    [manager GET:[NSString stringWithFormat:@"https://api.github.com/user?access_token=%@",accessTokenData] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        [self finishOAuth:accessTokenData response:responseObject];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"Error: %@", error);
                    }];
                    completionHandler(YES, nil);
                } else {
                    completionHandler(NO, error);
                }
                
    }]resume];
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
    [self tokenRequestWithCallbackURL:url saveOptions:kMBSaveOptionsKeychain completion:^(BOOL success, NSError *error) {
    }];
    return YES;
}

- (void)finishOAuth:(NSString *)accessToken response:(id)responseObject{
    [_mydelegate didFinishGithubOAuth:accessToken response:responseObject];
}

@end
