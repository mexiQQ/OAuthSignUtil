#OAuthSignUtil

Github Google Sina QQ OAuth Sign

##Install

####Cocoapod
	
	platform:'ios','7.0'
	pod 'MXOAuthSignUtil', '~> 0.0.6'

####Without Cocoapod
	just like example

##Dependencies

- AFNetworking  2.5.0
- UMSocail  4.2.1
- googleplus-ios-sdl  1.7.1

##Use

1. add the callback function in Appdelegate.m

```    
   -(BOOL)application: (UIApplication *)application openURL: (NSURL *)url sourceApplication: (NSString *)sourceApplication annotation: (id)annotation {
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

   //(remember to import "OAuthSignUtilHeader.h")
```
2. add URL Types(In project target Info)

   you can use my setting or use your own setting,just like my demo.

3. viewController.h:

``` 
#import <UIKit/UIKit.h>
#import "OAuthSignUtil.h"

@interface ViewController : UIViewController<OAuthSignUtilDelegate>

@end
```

4. viewController.m：

```
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

```  
   
5. Enum:`SignIntoSina,SignIntoGithub,SignIntoGoogle,SignIntoQQ`

##License

MIT












`
