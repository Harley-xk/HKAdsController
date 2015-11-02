//
//  HKAdsController.h
//  HKAdsController
//
//  Created by Harley.xk on 15/10/26.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

#import "HKAdsInterstitialController.h"
#import "HKAdsBannerView.h"

typedef NS_ENUM(NSUInteger, HKAdsLanguageType)
{
    HKAdsLanguageType_Chinese,
    HKAdsLanguageType_English
};


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

/**
 * 广告位ID
 *///////////
@property (copy,   nonatomic) NSString *admobPublisherID;
// 插屏广告ID
@property (copy,   nonatomic) NSString *admobInterstitialID;
// 广告条ID
@property (copy,   nonatomic) NSString *admobBannerID;

@end
