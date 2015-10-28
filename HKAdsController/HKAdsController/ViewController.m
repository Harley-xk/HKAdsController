//
//  ViewController.m
//  HKAdsController
//
//  Created by Harley.xk on 15/10/26.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import "ViewController.h"
#import "HKAdsController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    if ([[HKAdsController sharedController] currentLangeType] == HKAdsLanguageType_Chinese) {
        NSLog(@"Domob!");
    }else {
        NSLog(@"AdMob!");
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
