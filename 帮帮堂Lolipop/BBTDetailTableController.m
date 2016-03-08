//
//  BBTDetailTableController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/8.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTDetailTableController.h"
#import "BBTTask.h"
#import <AVOSCloud.h>

@interface BBTDetailTableController ()
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *senderLabel;
@property (weak, nonatomic) IBOutlet UILabel *receiverLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation BBTDetailTableController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDetailLabel:(UILabel *)detailLabel {
    detailLabel.text = self.task.detail;
}

- (void)setMoneyLabel:(UILabel *)moneyLabel {
    moneyLabel.text = [NSString stringWithFormat:@"¥%@", [self.task.money stringValue]];
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
            NSString *receiver = [objects.lastObject objectForKey:@"mobilePhoneNumber"];
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





@end
