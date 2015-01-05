//
//  MXSinaOAuthClient.h
//  OAuthSignUtil
//
//  Created by MexiQQ on 15/1/5.
//  Copyright (c) 2015年 MexiQQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STHTTPRequest.h"

@protocol MXSinaOAuthDelegate <NSObject>
-(void)didFinishSinaOAuth:(NSString *)accessToken response:(id)responseObject;
@end

typedef void(^MXSinaOAuthClientCompletionHandler)(BOOL success, NSError *error);

@interface MXSinaOAuthClient : NSObject

@property (nonatomic, strong) NSString * sinaClientID;
@property (nonatomic, strong) NSString * sinaClientSecret;
@property (nonatomic, strong) NSString * sinaRedirectUrl;
@property (nonatomic, assign) id<MXSinaOAuthDelegate> mydelegate;

+ (instancetype)clientWithID:(NSString *)clientID andSecret:(NSString *)clientSecret addRedirectUrl:(NSString *)clientRedirectUrl;;

+ (instancetype)sharedClient;

- (void)tokenRequestWithCallbackURL:(NSURL *)url
                         completion:(MXSinaOAuthClientCompletionHandler)completionHandler;

- (BOOL)handleOpenURL:(NSURL *)url;

- (NSURL *)getOauthRequestURL;

@property (strong, nonatomic, readonly) NSString *accessToken;

@end
