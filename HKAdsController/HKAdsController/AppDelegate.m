//
//  AppDelegate.m
//  HKAdsController
//
//  Created by Harley.xk on 15/10/26.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import "AppDelegate.h"
#import "HKAdsController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initAdsAndshowIntersitial];
    
    return YES;
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HKAdsInterstitialController sharedController] showInterstitialAds];
    });
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Tasks
- (void)initAdsAndshowIntersitial
{
    HKAdsController *adsController = [HKAdsController sharedController];
//    adsController.domobPublisherID = @"56OJw7pIuNKejQ20ua";
//    adsController.domobInterstitialID = @"16TLucGoAp-7PNUv8uWq46wk";
    
    adsController.admobPublisherID = @"pub-2630844222801153";
    adsController.admobInterstitialID = @"ca-app-pub-2630844222801153/7351679029";
    adsController.admobBannerID = @"ca-app-pub-2630844222801153/8374807423";
    
//    [[HKAdsInterstitialController sharedController] showInterstitialAds];
}


@end
