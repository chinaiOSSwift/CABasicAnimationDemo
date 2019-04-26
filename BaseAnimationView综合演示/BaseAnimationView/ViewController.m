//
//  ViewController.m
//  BaseAnimationView
//
//  Created by KOCHIAEE6 on 2019/4/26.
//  Copyright © 2019 KOCHIAEE6. All rights reserved.
//





#import "ViewController.h"
#import "BaseAnimationView.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BaseAnimationView *animationView = [[BaseAnimationView alloc]init];
    [self.view addSubview:animationView];
}


@end
