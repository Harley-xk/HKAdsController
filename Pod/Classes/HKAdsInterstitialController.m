//
//  HKAdsInterstitialController.m
//  HKAdsController
//
//  Created by Harley.xk on 15/11/2.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import "HKAdsInterstitialController.h"
#import "HKAdsController.h"

NSString *HKInterstitialDidHideNotificationName = @"HKInterstitialDidHideNotificationName";
NSString *HKInterstitialDidShowNotificationName = @"HKInterstitialDidShowNotificationName";
NSString *HKInterstitialDidLoadNotificationName = @"HKInterstitialDidLoadNotificationName";

@interface HKAdsInterstitialController ()
<GADInterstitialDelegate>
@property (strong, nonatomic) GADInterstitial *interstitial;
@property (strong, nonatomic) HKAdsController *adsController;

@property (assign, nonatomic) BOOL showAdsImmediately;
@property (strong, nonatomic) UIWindow *adsWindow;
@property (assign, nonatomic) BOOL didHideAds;

// 上次显示广告的时间
@property (strong, nonatomic) NSDate *lastInterstitial;

@end

@implementation HKAdsInterstitialController

+ (instancetype)sharedController
{
    static HKAdsInterstitialController *sharedHKAdsInterstitialController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHKAdsInterstitialController = [HKAdsInterstitialController new];
    });
    return sharedHKAdsInterstitialController;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.adsController = [HKAdsController sharedController];
        [self loadInterstitialAds];
    }
    return self;
}


- (void)loadInterstitialAds
{
    if (self.interstitial && self.interstitial.isReady) {
        return;
    }
    else {
        self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:self.adsController.admobInterstitialID];
        self.interstitial.delegate = self;
        
        GADRequest *request = [GADRequest request];
        //    request.testDevices = @[ kGADSimulatorID, @"5b5a10a7e85f83f807914a9d10c21494" ];
        
        request.gender = self.adsController.gender;
        request.birthday = self.adsController.birthday;
        [request setLocationWithLatitude:self.adsController.location.coordinate.latitude
                               longitude:self.adsController.location.coordinate.longitude
                                accuracy:self.adsController.locationAccuracyInMeters];

        [self.interstitial loadRequest:request];
    }
}

- (void)showInterstitialAds
{
    if (self.interstitial == nil || !self.interstitial.isReady) {
        self.showAdsImmediately = YES;
        [self loadInterstitialAds];
    }else {
        if (self.adsController.adsDisabled) {
            return;
        }
        
        if (self.lastInterstitial) {
            NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self.lastInterstitial];
            if (time <= 300) {
                return;
            }
        }
        
        CGRect screenFrame = [[UIScreen mainScreen] bounds];
        self.adsWindow = [[UIWindow alloc] initWithFrame:screenFrame];
        self.adsWindow.rootViewController = [UIViewController new];
        self.adsWindow.windowLevel = UIWindowLevelAlert - 1;
        [self.adsWindow makeKeyAndVisible];

        [self.interstitial presentFromRootViewController:self.adsWindow.rootViewController];
        self.lastInterstitial = [NSDate date];
        self.didHideAds = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:HKInterstitialDidShowNotificationName object:nil];
    }
}

- (void)hideInterstitialAds
{
    if (self.adsWindow == nil) {
        return;
    }
    
    if (!self.didHideAds) {
        [self.adsWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.adsWindow.alpha = 0;
    } completion:^(BOOL finished) {
        [self.adsWindow resignKeyWindow];
        self.adsWindow.rootViewController = nil;
        self.adsWindow = nil;
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HKInterstitialDidHideNotificationName object:nil];
    
    // 预加载下一条广告
    [self loadInterstitialAds];
}

#pragma mark - GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)adInterstitial
{
    [[NSNotificationCenter defaultCenter] postNotificationName:HKInterstitialDidLoadNotificationName object:nil];

    if (self.showAdsImmediately) {
        [self showInterstitialAds];
        self.showAdsImmediately = NO;
    }
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
    [self hideInterstitialAds];
    self.didHideAds = YES;
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{    
    NSLog(@"Admob Interstitial Failed : %@",error);
}



@end
