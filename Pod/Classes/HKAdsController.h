//
//  HKAdsController.h
//  HKAdsController
//
//  Created by Harley.xk on 15/10/26.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <CoreLocation/CoreLocation.h>

#import "HKAdsInterstitialController.h"
#import "HKAdsBannerView.h"

typedef NS_ENUM(NSUInteger, HKAdsLanguageType)
{
    HKAdsLanguageType_Chinese,
    HKAdsLanguageType_English
};

extern NSString *HKAdsAbilityChangedNotificationName;

@interface HKAdsController : NSObject

+ (instancetype)sharedController;

/**
 *  是否禁用广告
 */
@property (assign, nonatomic) BOOL adsDisabled;;

/**
 *  当前语言状态
 */
- (HKAdsLanguageType)currentLangeType;

/// Provide the user's gender to increase ad relevancy.
@property(nonatomic, assign) GADGender gender;

/// Provide the user's birthday to increase ad relevancy.
@property(nonatomic, copy) NSDate *birthday;

/// The user's current location may be used to deliver more relevant ads. However do not use Core
/// Location just for advertising, make sure it is used for more beneficial reasons as well. It is
/// both a good idea and part of Apple's guidelines.
@property (copy,   nonatomic) CLLocation *location;
@property (assign, nonatomic) CLLocationAccuracy locationAccuracyInMeters;


/**
 * 广告位ID
 *///////////
@property (copy,   nonatomic) NSString *admobPublisherID;
// 插屏广告ID
@property (copy,   nonatomic) NSString *admobInterstitialID;
// 广告条ID
@property (copy,   nonatomic) NSString *admobBannerID;

@end
