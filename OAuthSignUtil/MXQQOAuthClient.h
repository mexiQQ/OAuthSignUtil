//
//  MXQQOAuthClient.h
//  OAuthSignUtil
//
//  Created by MexiQQ on 14/12/28.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STHTTPRequest.h"
#import <UIKit/UIKit.h>

@protocol MXQQOAuthDelegate <NSObject>
-(void)didFinishQQOAuth:(NSString *)accessToken response:(id)responseObject;
@end

typedef void(^MXQQOAuthClientCompletionHandler)(BOOL success, NSError *error);

@interface MXQQOAuthClient : NSObject

@property (nonatomic, strong) NSString * qqClientID;
@property (nonatomic, strong) NSString * qqClientSecret;
@property (nonatomic, assign) id<MXQQOAuthDelegate> mydelegate;

+ (instancetype)clientWithID:(NSString *)clientID andSecret:(NSString *)clientSecret;

+ (instancetype)sharedClient;

- (void)tokenRequestWithCallbackURL:(NSURL *)url
                         completion:(MXQQOAuthClientCompletionHandler)completionHandler;

- (BOOL)handleOpenURL:(NSURL *)url;

- (NSURL *)getOauthRequestURL;

@property (strong, nonatomic, readonly) NSString *accessToken;

@end
