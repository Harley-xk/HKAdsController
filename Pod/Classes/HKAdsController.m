//
//  HKAdsController.m
//  HKAdsController
//
//  Created by Harley.xk on 15/10/26.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import "HKAdsController.h"
#import <HKProjectBase.h>

NSString *kAdsDisabledKey = @"com.HKAdsController.AdsDisabled";

@interface HKAdsController ()
@property (assign, nonatomic) HKAdsLanguageType languageType;

@property (strong, nonatomic) UIWindow *adsWindow;
@property (assign, nonatomic) BOOL didHideAdsWindow;


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

@end
