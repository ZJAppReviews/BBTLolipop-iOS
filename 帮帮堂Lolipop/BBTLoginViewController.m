//
//  BBTLoginViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/3.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTLoginViewController.h"
#import <AVOSCloud.h>

@interface BBTLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *loginInfoView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loginButton;
@property (nonatomic, strong) NSTimer *timer;
@property NSInteger countDown;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
- (IBAction)loginClick:(id)sender;
@end

@implementation BBTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.enabled = NO;
    // 监听键盘的出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkInformation) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.loginInfoView.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkInformation {
    if (self.usernameTextField.text.length == 11 &&
        self.passwordField.text.length != 0) {
        self.loginButton.enabled = YES;
    } else {
        self.loginButton.enabled = NO;
    }
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.background = [UIImage imageNamed:@"textfield01"];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.background = [UIImage imageNamed:@"textfield02"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.usernameTextField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (void)keyboardWillShow {
    self.welcomeLabel.hidden = YES;
    
    self.view.frame = CGRectMake(0, -154, self.view.frame.size.width, self.view.frame.size.height);
    
}

- (void)keyboardWillHide {
    
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.welcomeLabel.hidden = NO;
}


- (IBAction)loginClick:(id)sender {
    [AVUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordField.text block:^(AVUser *user, NSError *error) {
        if (user) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            self.view.window.rootViewController = [mainStoryboard instantiateInitialViewController];
            
        } else {
            NSString *errorMessage = [error.userInfo objectForKey:@"error"];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:confirmAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    }

@end
