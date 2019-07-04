//
//  AppDelegate.m
//  HelloSensorsAnalytics
//
//  Created by 曹犟 on 15/7/4.
//  Copyright © 2015－2018 Sensors Data Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "SensorsAnalyticsSDK.h"
#import "SAAppExtensionDataManager.h"

static NSString* Sa_Default_ServerURL = @"http://sdk-test.cloud.sensorsdata.cn:8006/sa?project=default&token=95c73ae661f85aa0";
static NSString* Ws_Default_ServerURL = @"http://39.98.54.111/v1/dcswcnkzxnfh0s7va5rka761k_7e9y/events.svc";

@interface AppDelegate ()

@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    [SensorsAnalyticsSDK sharedInstanceWithServerURL:Ws_Default_ServerURL
                                    andLaunchOptions:launchOptions
                                    andDebugMode:SensorsAnalyticsDebugAndTrack];
    // 设置公共属性
    // [[SensorsAnalyticsSDK sharedInstance] registerSuperProperties:@{@"appName": @"HelloSensorsAnalytics"}];
    // 追踪激活事件，详见：https://sensorsdata.cn/manual/app_channel_tracking.html
    [[SensorsAnalyticsSDK sharedInstance] trackInstallation:@"AppInstall" withProperties:@{@"testValue" : @"testKey"}];
    // 打开自动采集, 并指定追踪哪些 AutoTrack 事件
    [[SensorsAnalyticsSDK sharedInstance] enableAutoTrack:SensorsAnalyticsEventTypeAppStart|
     SensorsAnalyticsEventTypeAppEnd|
     SensorsAnalyticsEventTypeAppViewScreen|
     SensorsAnalyticsEventTypeAppClick];
    // 打通 App 与 H5，详见：https://sensorsdata.cn/manual/app_h5.html
    [[SensorsAnalyticsSDK sharedInstance] addWebViewUserAgentSensorsDataFlag];

    [[SensorsAnalyticsSDK sharedInstance] registerSuperProperties:@{@"someparam":@"somevalue"}];
    [[SensorsAnalyticsSDK sharedInstance] registerDynamicSuperProperties:^NSDictionary * _Nonnull{
        __block UIApplicationState appState;
        if (NSThread.isMainThread) {
            appState = UIApplication.sharedApplication.applicationState;
        }else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                appState = UIApplication.sharedApplication.applicationState;
            });
        }
        return @{@"__APPState__":@(appState)};
    }];
    [[SensorsAnalyticsSDK sharedInstance] enableLog:YES];
    [[SensorsAnalyticsSDK sharedInstance] enableAutoTrack:SensorsAnalyticsEventTypeAppStart |
     SensorsAnalyticsEventTypeAppEnd |
     SensorsAnalyticsEventTypeAppClick|SensorsAnalyticsEventTypeAppViewScreen];
    [[SensorsAnalyticsSDK sharedInstance] setMaxCacheSize:20000];
    [[SensorsAnalyticsSDK sharedInstance] enableHeatMap];
    [[SensorsAnalyticsSDK sharedInstance] addWebViewUserAgentSensorsDataFlag];
    //[[SensorsAnalyticsSDK sharedInstance] addHeatMapViewControllers:[NSArray arrayWithObject:@"DemoController"]];
    [[SensorsAnalyticsSDK sharedInstance] trackAppCrash];
    [[SensorsAnalyticsSDK sharedInstance] setFlushNetworkPolicy:SensorsAnalyticsNetworkTypeALL];
    [[SensorsAnalyticsSDK sharedInstance] enableTrackScreenOrientation:YES];
    [[SensorsAnalyticsSDK sharedInstance] enableTrackGPSLocation:YES];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([[SensorsAnalyticsSDK sharedInstance] handleSchemeUrl:url]) {
        return YES;
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //@"group.cn.com.sensorsAnalytics.share"
    [[SensorsAnalyticsSDK sharedInstance]trackEventFromExtensionWithGroupIdentifier:@"group.cn.com.sensorsAnalytics.share" completion:^(NSString *identifiy ,NSArray *events){
        
    }];
//   NSArray  *eventArray = [[SAAppExtensionDataManager sharedInstance] readAllEventsWithGroupIdentifier: @"group.cn.com.sensorsAnalytics.share"];
//    NSLog(@"applicationDidBecomeActive::::::%@",eventArray);
//    for (NSDictionary *dict in eventArray  ) {
//        [[SensorsAnalyticsSDK sharedInstance]track:dict[SA_EVENT_NAME] withProperties:dict[SA_EVENT_PROPERTIES]];
//    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //[[SAAppExtensionDataManager sharedInstance]deleteEventsWithGroupIdentifier:@"dd"];
    //[[SAAppExtensionDataManager sharedInstance]readAllEventsWithGroupIdentifier:NULL];
    //[[SAAppExtensionDataManager sharedInstance]writeEvent:@"eee" properties:@"" groupIdentifier:@"ff"];
    //[[SAAppExtensionDataManager sharedInstance]fileDataCountForGroupIdentifier:@"ff"];
    //[[SAAppExtensionDataManager sharedInstance]fileDataArrayWithPath:@"fff" limit:-1];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
