//
//  BBTNavigationController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/1.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTNavigationController.h"

@interface BBTNavigationController ()

@end

@implementation BBTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [bar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:0];
    [bar setShadowImage:[UIImage new]];
    [bar setTintColor:[UIColor whiteColor]];
}



@end
