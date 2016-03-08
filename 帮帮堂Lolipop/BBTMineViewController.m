//
//  BBTMineViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/5.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTMineViewController.h"
#import <AVUser.h>

@interface BBTMineViewController ()

@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@end

@implementation BBTMineViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneNumberLabel.text = [[AVUser currentUser] username];
    
    self.schoolNameLabel.text = [[AVUser currentUser] objectForKey:@"schoolName"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) {
        [AVUser logOut];
        UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        
        self.view.window.rootViewController = [loginStoryboard instantiateInitialViewController];
        
    }
}





@end
