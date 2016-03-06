//
//  BBTTaskViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/4.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTTaskViewController.h"
#import "BBTTaskViewCell.h"
#import "BBTTask.h"
#import "BBTDetailViewController.h"
#import <AVOSCloud.h>

@interface BBTTaskViewController ()


@end

@implementation BBTTaskViewController

- (void)viewDidLoad {
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.taskList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBTTaskViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    BBTTask *task = [BBTTask taskWithDictionary:self.taskList[indexPath.row]];
    cell.detailLabel.text = task.detail;
    cell.backgroundImage.layer.cornerRadius = 7;
    cell.backgroundImage.layer.masksToBounds = YES;
    cell.backgoundView.layer.cornerRadius = 7;
    
    cell.payLabel.text = [NSString stringWithFormat:@"¥%@", [task.money stringValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd HH:mm";
    formatter.locale = [NSLocale currentLocale];
    cell.dateLabel.text = [formatter stringFromDate:task.createdAt];
    cell.taskTypeLabel.text = [NSString stringWithFormat:@"求%@", task.taskType];
    NSArray *taskTypeArray = @[@"打水", @"取件", @"占座", @"带饭", @"其他"];
    
    switch ([taskTypeArray indexOfObject:task.taskType]) {
        case 0:
            cell.backgroundImage.image = [UIImage imageNamed:@"water"];
            break;
        case 1:
            cell.backgroundImage.image = [UIImage imageNamed:@"express"];
            break;
        case 2:
            cell.backgroundImage.image = [UIImage imageNamed:@"seat"];
            break;
        case 3:
            cell.backgroundImage.image = [UIImage imageNamed:@"food"];
            break;
        default:
            cell.backgroundImage.image = [UIImage imageNamed:@"other"];
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BBTTask *task = [BBTTask taskWithDictionary:self.taskList[indexPath.row]];
    BBTDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailViewController.task = task;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)reload {
    [self.refreshControl endRefreshing];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTableViewNotification" object:nil];
    
}




@end
