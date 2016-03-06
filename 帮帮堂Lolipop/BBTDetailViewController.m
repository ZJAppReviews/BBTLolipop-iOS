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

@interface BBTDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *senderLabel;
@property (weak, nonatomic) IBOutlet UILabel *receiverLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
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


- (void)setMoneyLabel:(UILabel *)moneyLabel {
    moneyLabel.text = [NSString stringWithFormat:@"¥%@", [self.task.money stringValue]];
}

- (void)setDetailLabel:(UILabel *)detailLabel {
   detailLabel.text = self.task.detail;
}

- (void)setTaskStateLabel:(UILabel *)taskStateLabel {
    taskStateLabel.layer.cornerRadius = 5;
    taskStateLabel.layer.masksToBounds = YES;
    switch (self.task.taskState) {
        case 0:
            taskStateLabel.text = @"待领取";
            break;
        case 1:
            taskStateLabel.text = @"已领取";
            break;
        case 2:
            taskStateLabel.text = @"已完成";
            break;
        case 3:
            taskStateLabel.text = @"已确认";
            break;
        default:
            taskStateLabel.text = @"已取消";
            break;
    }
}

- (void)setSenderLabel:(UILabel *)senderLabel {
    AVQuery *userQuery = [AVQuery queryWithClassName:@"_User"];
    [userQuery whereKey:@"objectId" equalTo:self.task.taskSender];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSString *originNumber = [objects.lastObject objectForKey:@"mobilePhoneNumber"];
        if (self.task.taskState == 0) {
            senderLabel.text = [originNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        } else {
            senderLabel.text = originNumber;
        }
        
    }];
    
}

- (void)setReceiverLabel:(UILabel *)receiverLabel {
    if (self.task.taskState == 0 || self.task.taskState == 4) {
        receiverLabel.text= @"暂无";
    } else {
        AVQuery *userQuery = [AVQuery queryWithClassName:@"_User"];
        [userQuery whereKey:@"objectId" equalTo:self.task.taskReceiver];
        [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            NSString *originNumber = [objects.lastObject objectForKey:@"mobilePhoneNumber"];
            NSString *receiver = [originNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            receiverLabel.text = receiver;
        }];
       
    }
    
}

- (void)setDateLabel:(UILabel *)dateLabel {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    formatter.locale = [NSLocale currentLocale];
    dateLabel.text = [formatter stringFromDate:self.task.createdAt];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cancelTaskButton.layer.cornerRadius = 5;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
