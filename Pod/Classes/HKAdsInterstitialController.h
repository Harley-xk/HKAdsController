//
//  HKAdsInterstitialController.h
//  HKAdsController
//
//  Created by Harley.xk on 15/11/2.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKAdsInterstitialController : NSObject

+ (instancetype)sharedController;

/**
 *  广告时间间隔，在间隔时间之内显示广告之后不会再次显示，默认300秒
 */
@property (assign, nonatomic) NSTimeInterval adsInterval;

/**
 *  显示和隐藏广告
 */
- (void)showInterstitialAds;
- (void)hideInterstitialAds;

@end
