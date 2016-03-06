//
//  BBTPostViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/4.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTPostViewController.h"
#import <AVOSCloud.h>

@interface BBTPostViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *taskTypeControl;

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyHintLabel;
@property (weak, nonatomic) IBOutlet UITextView *moneyTextView;
@property (weak, nonatomic) IBOutlet UIView *moneyView;
- (IBAction)closeClick:(id)sender;
- (IBAction)postClick:(id)sender;

@end

@implementation BBTPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailTextView.layer.cornerRadius = 5;
    self.moneyTextView.layer.cornerRadius = 5;
    self.moneyView.layer.cornerRadius = 5;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView == self.detailTextView) {
        self.hintLabel.hidden = YES;
    }
    if (textView == self.moneyTextView){
        self.moneyHintLabel.hidden = YES;
    }
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.detailTextView resignFirstResponder];
    [self.moneyTextView resignFirstResponder];
    if (self.detailTextView.text.length == 0) {
        self.hintLabel.hidden = NO;
        self.postButton.enabled = NO;
    } else {
        self.postButton.enabled = YES;
    }
    if (self.moneyTextView.text.length == 0) {
        self.moneyHintLabel.hidden = NO;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)postClick:(id)sender {
        NSString *detail = self.detailTextView.text;
        AVUser *user = [AVUser currentUser];
        NSString *taskSender = user.objectId;
        NSString *schoolName = [user objectForKey:@"schoolName"];
        NSString *taskType = [self.taskTypeControl titleForSegmentAtIndex:self.taskTypeControl.selectedSegmentIndex];
        NSNumber *money = [NSNumber numberWithInt:self.moneyTextView.text.intValue];
        AVObject *task = [AVObject objectWithClassName:@"Task"];
        [task setObject:detail forKey:@"detail"];
        [task setObject:taskSender forKey:@"taskSender"];
        [task setObject:@"nil" forKey:@"taskReceiver"];
        [task setObject:[NSNumber numberWithInt:0] forKey:@"taskState"];
        [task setObject:money forKey:@"money"];
        [task setObject:taskType forKey:@"taskType"];
        [task setObject:schoolName forKey:@"schoolName"];
        [task saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTableViewNotification" object:nil];
                
            } else {
                NSString *errorMessage = [error.userInfo objectForKey:@"error"];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发布失败" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:confirmAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    
    
    
}


@end
