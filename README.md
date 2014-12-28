#OAuthSignUtil
Github Google Sina QQ OAuth Sign

##Install

####Cocoapod
	
	platform:'ios','7.0'
	pod 'MXOAuthSignUtil', '~> 0.0.6'

####Without Cocoapod
	just like the Demo

##Dependencies

 - UMSocail  ~4.2.1
 - STHTTPRequest 1.0.2'



##Use

1. add the callback function in Appdelegate.m

		//(remember to import "OAuthSignUtilHeader.h")
		- (BOOL)application: (UIApplication *)application openURL: (NSURL *)url sourceApplication: (NSString *)sourceApplication annotation: (id)annotation {
		    if([url.absoluteString containsString:@"gitauth"]){
		        return [[MBGithubOAuthClient sharedClient] handleOpenURL:url];
		    }else if([url.absoluteString containsString:@"com.ljw.test"]){
		        return [GPPURLHandler handleURL:url
		                      sourceApplication:sourceApplication
		                             annotation:annotation];
		    }else{
		        return [UMSocialSnsService handleOpenURL:url];
		    }
		}

2. add UMSocail Key  in Appdelegate.m

		- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
		    [UMSocialData setAppKey:@"5211818556240bc9ee01db2f"];
		    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
		    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
		    return YES;
		}

3. add URL Types(In project target Info)

   you can use my settings or your own settings,like the follow: 
	
	![](https://github.com/mexiQQ/OAuthSignUtil/blob/master/1.png)

4. viewController.h:


		#import <UIKit/UIKit.h>
		#import "OAuthSignUtil.h"
		
		@interface ViewController : UIViewController<OAuthSignUtilDelegate>
		
		@end


5. viewController.m：


		  //callback
		  - (void)didFinishOAuthSign:(NSDictionary *)userInfo accessToken:(NSString *)accessToken{
		   NSLog(@"accessToken =%@",accessToken);
		   NSLog(@"userInfo =%@",userInfo);
		  }
		
		  //OAuth
		  - (IBAction)loginAction:(id)sender  {
		     [[OAuthSignUtil sharedOAuthSignUtil] signInto:SignIntoSina viewController:self ];
		     [OAuthSignUtil sharedOAuthSignUtil].oAuthDelegate = sel f;
		  }

 
   
6. Enum:`SignIntoSina,SignIntoGithub,SignIntoGoogle,SignIntoQQ`

##License

MIT












`
