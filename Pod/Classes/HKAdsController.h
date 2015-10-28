//
//  HKAdsController.h
//  HKAdsController
//
//  Created by Harley.xk on 15/10/26.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <DMAdView.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

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
 *  显示和隐藏开屏广告
 */
- (void)presentInterstitials;
- (void)hideInterstitials;

///**
// * 多盟广告位ID
// *///////////
//@property (copy,   nonatomic) NSString *domobPublisherID;
//// 插屏广告ID
//@property (copy,   nonatomic) NSString *domobInterstitialID;
//// 广告条ID
//@property (copy,   nonatomic) NSString *domobBannerID;

/**
 * AdMob广告位ID
 *///////////
@property (copy,   nonatomic) NSString *admobPublisherID;
// 插屏广告ID
@property (copy,   nonatomic) NSString *admobInterstitialID;
// 广告条ID
@property (copy,   nonatomic) NSString *admobBannerID;

@end
