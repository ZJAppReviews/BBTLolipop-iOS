//
//  BBTDetailViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/5.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTDetailViewController.h"
#import "BBTTask.h"
#import <AVOSCloud.h>
#import "BBTDetailTableController.h"

@interface BBTDetailViewController ()


@property (weak, nonatomic) IBOutlet UIButton *takeTaskButton;
@property (weak, nonatomic) IBOutlet UIButton *finishTaskButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmTaskButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelTaskButton;
- (IBAction)cancelTaskClick:(id)sender;
- (IBAction)takeTaskClick:(id)sender;
- (IBAction)finishTaskClick:(id)sender;
- (IBAction)confirmTaskClick:(id)sender;


@end



@implementation BBTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BBTDetailTableController *detailTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailTableController"];
    detailTableView.task = self.task;
    [self addChildViewController:detailTableView];
    [self.view addSubview:detailTableView.view];
    if ([self.task.taskSender isEqualToString:[[AVUser currentUser] objectId]]) {
        switch (self.task.taskState) {
            case 0:
                self.cancelTaskButton.hidden = NO;
                break;
            case 1:
                break;
            case 2:
                self.confirmTaskButton.hidden = NO;
                break;
            default:
                break;
        }
        
    } else {
        // 查看他人的任务
        switch (self.task.taskState) {
            case 0:
                self.takeTaskButton.hidden = NO;
                break;
            case 1:
                self.cancelTaskButton.hidden = NO;
                self.finishTaskButton.hidden = NO;
                break;
            case 2:
                break;
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelTaskClick:(id)sender {
    [self changeTaskState:4];
}

- (IBAction)takeTaskClick:(id)sender {
    [self changeTaskState:1 andTaskRecevier:[AVUser currentUser].objectId];
}

- (IBAction)finishTaskClick:(id)sender {
    [self changeTaskState:2];
}

- (IBAction)confirmTaskClick:(id)sender {
    [self changeTaskState:3];
}

- (void)changeTaskState:(int)state {
    AVQuery *query = [AVQuery queryWithClassName:@"Task"];
    [query getObjectInBackgroundWithId:self.task.objectId block:^(AVObject *object, NSError *error) {
        [object setObject:[NSNumber numberWithInt:state] forKey:@"taskState"];
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self.navigationController popToRootViewControllerAnimated:YES ];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTableViewNotification" object:nil];
            }
        }];
        
        
    }];
    
    
}

- (void)changeTaskState:(int)state andTaskRecevier:(NSString *)receiver {
    
    AVQuery *query = [AVQuery queryWithClassName:@"Task"];
    [query getObjectInBackgroundWithId:self.task.objectId block:^(AVObject *object, NSError *error) {
        [object setObject:[NSNumber numberWithInt:state] forKey:@"taskState"];
        [object setObject:receiver forKey:@"taskReceiver"];
        [object saveInBackground];
        [self.navigationController popToRootViewControllerAnimated:YES ];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTableViewNotification" object:nil];
    }];
}
@end
