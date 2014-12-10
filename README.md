#OAuthSignUtil

Github Google Sina QQ OAuth 認證

##Install
###Cocoapod
暂不支持
###Without Cocoapod
見示例程序

##Dependencies
- AFNetworking
- UMSocail
- googleplus-ios-sdl

##Use

1. 在APP delegate 中添加如下回調處理：

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
```
(記得添加引用 import "OAuthSignUtilHeader.h")

2. 添加URL Types(在Info里)

可以使用我的配置，也可以換成你自己的配置，這些都需要到第三方平臺申請，我的配置見示例代碼

3. 在viewContoller.h中實現引用`import "OAuthSignUtil.h"`，併實現`OAuthSignUtilDelegate`代理

4. viewController.m的實現如下：
```
    //回调
    -(void)didFinishOAuthSign:(NSDictionary *)userInfo accessToken:(NSString *)accessToken{
        NSLog(@"accessToken =%@",accessToken);
        NSLog(@"userInfo =%@",userInfo);
    }

    //授权
    - (IBAction)loginAction:(id)sender {
        [[OAuthSignUtil sharedOAuthSignUtil] signInto:SignIntoSina viewController:self];
        [OAuthSignUtil sharedOAuthSignUtil].oAuthDelegate = self;
    }
```
(如上所示SignIntoSina是一個枚舉類型，還有SignIntoGithub SignIntoGoogle SignIntoQQ)

##License

MIT












`
