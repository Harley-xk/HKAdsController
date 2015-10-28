//
//  HKInterstitialAdsViewController.m
//  HKAdsController
//
//  Created by Harley.xk on 15/10/27.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import "HKInterstitialAdsViewController.h"
#import "HKAdsController.h"

@interface HKInterstitialAdsViewController ()
<GADInterstitialDelegate>
@property (weak,   nonatomic) HKAdsController *adsController;
@property (strong, nonatomic) GADInterstitial *admobAdsController;
@end

@implementation HKInterstitialAdsViewController

- (void)dealloc
{
    self.admobAdsController.delegate = nil;
    self.admobAdsController = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.adsController = [HKAdsController sharedController];
    [self showAdMobAds];
}

- (void)showAdMobAds
{
    self.admobAdsController = [[GADInterstitial alloc] initWithAdUnitID:self.adsController.admobInterstitialID];
    self.admobAdsController.delegate = self;
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[ kGADSimulatorID, @"5b5a10a7e85f83f807914a9d10c21494" ];
    [self.admobAdsController loadRequest:request];
}

#pragma mark - GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)adInterstitial
{
    [adInterstitial presentFromRootViewController:self];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
    [self.adsController hideInterstitials];
    
    NSLog(@"Admob Interstitial Failed : %@",error);
}


@end
