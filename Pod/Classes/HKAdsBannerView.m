//
//  HKAdsBannerView.m
//  HKAdsController
//
//  Created by Harley.xk on 15/10/28.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import "HKAdsBannerView.h"

@implementation HKAdsBannerView

- (void)awakeFromNib
{
    HKAdsController *adsController = [HKAdsController sharedController];
    
    if ([adsController adsDisabled]) {
        self.hidden = YES;
    }
    
    [self setAdUnitID:adsController.admobBannerID];
}

@end
