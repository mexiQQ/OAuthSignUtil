//
//  OAuthSignUtil.h
//  OAuthSignUtils
//
//  Created by MexiQQ on 14/12/8.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 

@protocol MBGithubOAuthDelegate <NSObject>
-(void)didFinishGithubOAuth:(NSString *)accessToken response:(id)responseObject;
@end

typedef void(^MBGithubOAuthClientCompletionHandler)(BOOL success, NSError *error);

typedef enum {
    
    kMBSaveOptionsUserDefaults,
    kMBSaveOptionsKeychain
    
} kMBSaveOptions;

@interface MBGithubOAuthClient : NSObject

@property (nonatomic, strong) NSString * githubClientID;
@property (nonatomic, strong) NSString * githubClientSecret;
@property (nonatomic, assign) id<MBGithubOAuthDelegate> mydelegate;

+ (instancetype)clientWithID:(NSString *)clientID andSecret:(NSString *)clientSecret;

+ (instancetype)sharedClient;

- (void)tokenRequestWithCallbackURL:(NSURL *)url
                        saveOptions:(kMBSaveOptions)options
                         completion:(MBGithubOAuthClientCompletionHandler)completionHandler;

- (BOOL)handleOpenURL:(NSURL *)url;

- (NSURL *)getOauthRequestURL;

@property (strong, nonatomic, readonly) NSString *accessToken;

@end
