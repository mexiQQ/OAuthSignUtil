//
//  MXGoogleOAuthClient.h
//  OAuthSignUtil
//
//  Created by MexiQQ on 14/12/26.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STHTTPRequest.h"
#import <UIKit/UIKit.h>

@protocol MXGoogleOAuthDelegate <NSObject>
-(void)didFinishGoogleOAuth:(NSString *)accessToken response:(id)responseObject;
@end

typedef void(^MXGoogleOAuthClientCompletionHandler)(BOOL success, NSError *error);

@interface MXGoogleOAuthClient : NSObject
@property (nonatomic, strong) NSString * googleClientID;
@property (nonatomic, strong) NSString * googleClientSecret;
@property (nonatomic, assign) id<MXGoogleOAuthDelegate> mydelegate;

+ (instancetype)clientWithID:(NSString *)clientID andSecret:(NSString *)clientSecret;

+ (instancetype)sharedClient;

- (void)tokenRequestWithCallbackURL:(NSURL *)url
                         completion:(MXGoogleOAuthClientCompletionHandler)completionHandler;

- (BOOL)handleOpenURL:(NSURL *)url;

- (NSURL *)getOauthRequestURL;

@property (strong, nonatomic, readonly) NSString *accessToken;
@end
