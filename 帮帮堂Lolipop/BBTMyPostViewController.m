//
//  BBTMyPostViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/5.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTMyPostViewController.h"
#import "BBTTaskViewController.h"
#import <AVOSCloud.h>

@interface BBTMyPostViewController ()

@end

@implementation BBTMyPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BBTTaskViewController *taskViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TaskViewController"];
    [self addChildViewController:taskViewController];
    [self.view addSubview:taskViewController.tableView];
    
    AVUser *currentUser = [AVUser currentUser];
    
    AVQuery *query = [AVQuery queryWithClassName:@"Task"];
    
    [query whereKey:@"schoolName" equalTo:[currentUser objectForKey:@"schoolName"]];
    [query whereKey:@"taskSender" equalTo:currentUser.objectId];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        taskViewController.taskList = objects;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [taskViewController.tableView reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
