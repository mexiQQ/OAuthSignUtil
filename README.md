#OAuthSignUtil
Github Google Sina QQ OAuth Sign

##Install

####Cocoapod
	
	platform:'ios','7.0'
	pod 'MXOAuthSignUtil', '~> 0.1.2'

####Without Cocoapod
	just like the Demo

##Dependencies

 - STHTTPRequest ~1.0.2

##Use
1. find the OAuthSianUtil.h and add ID,secret for 4 platforms
	
		//github
		#define kGithubClientID @""
		#define kGithubClientSecret @""
		#define kGithubRedirectUrl @""
		
		//google
		#define KGoogleClientID @""
		#define kGoogleClientSecret @""
		#define kGoogleRedirectUrl @""
		
		//QQ
		#define KQQClientID @""
		#define kQQClientSecret @""
		#define kQQRedirectUrl @""
		
		//sina
		#define KSinaClientID @""
		#define KSinaClientSecret @""
		#define KSinaRedirectUrl @""
	
2. viewController.h:


		#import <UIKit/UIKit.h>
		#import "OAuthSignUtil.h"
		
		@interface ViewController : UIViewController<OAuthSignUtilDelegate>
		
		@end


3. viewController.m：


		  //callback
<<<<<<< HEAD
		  -(void)didFinishOAuthSign:(NSString *)type accessToken:(NSString *)accessToken{
		     NSLog(@"type is %@ \n accessToken = %@",type,accessToken);
=======
		  - (void)didFinishOAuthSign:(NSString *)type accessToken:(NSString *) accessToken{
		      NSLog(@"type is %@ accessToken =%@",type,accessToken);
>>>>>>> f79255375c4e4dd25e8a1b448e1a1006f0516510
		  }

		
		  //OAuth
		  - (IBAction)loginAction:(id)sender  {
		      [[OAuthSignUtil sharedOAuthSignUtil] signInto:SignIntoSina viewController:self ];
		      [OAuthSignUtil sharedOAuthSignUtil].oAuthDelegate = self;
		  }

 
   
6. Enum:`SignIntoSina,SignIntoGithub,SignIntoGoogle,SignIntoQQ`

##License

MIT












`
