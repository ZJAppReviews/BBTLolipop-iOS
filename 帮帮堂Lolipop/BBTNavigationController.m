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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
