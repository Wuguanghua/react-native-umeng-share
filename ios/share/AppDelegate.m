/**
 * Copyright (c) 2015-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"
#import "RNUMConfigure.h"
#import <UMShare/UMShare.h>

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  
  [UMConfigure setLogEnabled:YES];
  
  /* Umeng init */
  [MobClick setScenarioType:E_UM_GAME|E_UM_DPLUS];
  [RNUMConfigure initWithAppkey:@"599d6d81c62dca07c5001db6" channel:@"App Store"];
  
  /* Share init */
  [self setupUSharePlatforms];   // required: setting platforms on demand
  [self setupUShareSettings];
  
  NSURL *jsCodeLocation;

  #ifdef DEBUG
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
  #else
    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  #endif

  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"share"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  
  /**********************************************************************************************************************/
  /* 打开调试日志 */
  [UMConfigure setLogEnabled:YES];
  
  /* 设置友盟appkey */
  [RNUMConfigure initWithAppkey:@"5asd23323222se0001cc" channel:@"App Store"];
  
  /*
   * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
   */
  [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
  
  /*
   设置微信的appKey和appSecret
   */
  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx179afsafasw23b54ae" appSecret:@"5a4142fsdsfswe9a40e93fc" redirectURL:nil];
  
  /*
   设置分享到QQ互联的appID
   */
  
  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"110233248545"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
  
  /*
   设置新浪的appKey和appSecret
   */
  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"27239964"  appSecret:@"fac50980a44sdsdsssdsc968ea572887" redirectURL:@"http://sns.whalecloud.com"];
  /**********************************************************************************************************************/

  
  return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
  BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
  if (!result) {
    // 其他如支付等SDK的回调
  }
  return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
  BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
  if (!result) {
    // 其他如支付等SDK的回调
  }
  return result;
}

@end
