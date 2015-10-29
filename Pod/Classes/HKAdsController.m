//
//  HKAdsController.m
//  HKAdsController
//
//  Created by Harley.xk on 15/10/26.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import "HKAdsController.h"
#import "HKInterstitialAdsViewController.h"
#import <HKProjectBase.h>

NSString *kAdsDisabledKey = @"com.HKAdsController.AdsDisabled";

@interface HKAdsController ()
@property (assign, nonatomic) HKAdsLanguageType languageType;

@property (strong, nonatomic) UIWindow *adsWindow;
@property (assign, nonatomic) BOOL didHideAdsWindow;

@property (strong, nonatomic) NSDate *lastInterstitial;

@end

@implementation HKAdsController

+ (instancetype)sharedController
{
    static HKAdsController *sharedHKAdsController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHKAdsController = [HKAdsController new];
    });
    return sharedHKAdsController;
}

- (instancetype)init
{
    self = [super init];
    NSArray *preferredLocalizations = [[NSBundle mainBundle] preferredLocalizations];
    NSString *currentLanguage = preferredLocalizations[0];
    if ([currentLanguage isEqualToString:@"zh-Hans"]) {
        self.languageType = HKAdsLanguageType_Chinese;
    }else {
        self.languageType = HKAdsLanguageType_English;
    }
    
    _adsDisabled = [HKUserDefaults boolForKey:kAdsDisabledKey];

    return self;
}

- (void)setAdsDisabled:(BOOL)adsDisabled
{
    _adsDisabled = adsDisabled;
    [HKUserDefaults setBool:adsDisabled forKey:kAdsDisabledKey];
}

- (HKAdsLanguageType)currentLangeType
{
    return self.languageType;
}


- (void)presentInterstitials
{
    if (self.adsDisabled) {
        return;
    }
    
    NSDate *now = [NSDate date];
    if (self.lastInterstitial) {
        NSTimeInterval time = [now timeIntervalSinceDate:self.lastInterstitial];
        if (time <= 300) {
            return;
        }
    }
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    self.adsWindow = [[UIWindow alloc] initWithFrame:screenFrame];
    self.adsWindow.windowLevel = UIWindowLevelAlert;
    
    HKInterstitialAdsViewController *interstitialVC = [HKInterstitialAdsViewController new];
    interstitialVC.window = self.adsWindow;
    self.adsWindow.rootViewController = interstitialVC;
    [self.adsWindow makeKeyAndVisible];
    
    self.didHideAdsWindow = NO;
    self.lastInterstitial = now;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideInterstitials];
    });
}

- (void)hideInterstitials
{
    if (self.didHideAdsWindow) {
        return;
    }
    self.didHideAdsWindow = YES;
    
    [self.adsWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];    
    [UIView animateWithDuration:0.25 animations:^{
        self.adsWindow.alpha = 0;
    } completion:^(BOOL finished) {
        [self.adsWindow resignKeyWindow];
        self.adsWindow.rootViewController = nil;
        self.adsWindow = nil;        
    }];
}

@end
