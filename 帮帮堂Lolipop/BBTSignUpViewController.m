//
//  BBTSignUpViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/1.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTSignUpViewController.h"
#import <AVOSCloud.h>

@interface BBTSignUpViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *signupInfoView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (nonatomic, strong) NSTimer *timer;
@property NSInteger countDown;
- (IBAction)getCodeClick:(id)sender;
- (IBAction)signUpClick:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *schoolButton;


@end

@implementation BBTSignUpViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setSchoolName:) name:@"setSchoolNameNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneNumberTextChange) name:UITextFieldTextDidChangeNotification object:self.phoneNumberTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkInformation) name:UITextFieldTextDidChangeNotification object:self.codeTextField];
    self.schoolButton.layer.cornerRadius = 5;
    self.signupInfoView.layer.cornerRadius = 5;
    
}

#pragma - 注册前确认信息
- (void)checkInformation {
    if (self.phoneNumberTextField.text.length == 11 &&
        self.codeTextField.text.length == 6 &&
        ![[self.schoolButton titleForState:UIControlStateNormal] isEqualToString:@"请选择学校"]) {
        self.signUpButton.enabled = YES;
    } else {
        self.signUpButton.enabled = NO;
    }
}

- (void)phoneNumberTextChange {
    [self checkInformation];
    if (self.phoneNumberTextField.text.length == 11 ) {
        self.getCodeButton.enabled = YES;
    } else {
        self.getCodeButton.enabled = NO;
    }
    
}

#pragma mark - 设置输入框的选中效果
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.background = [UIImage imageNamed:@"textfield01"];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.background = [UIImage imageNamed:@"textfield02"];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneNumberTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    

}

#pragma mark - 设置学校
- (void)setSchoolName:(NSNotification *)noti {
    [self.schoolButton setTitle:noti.object forState:UIControlStateNormal];
    [self checkInformation];
}

#pragma mark - 键盘的出现和消失
- (void)keyboardWillShow {
    self.schoolButton.hidden = YES;

    self.view.frame = CGRectMake(0, -154, self.view.frame.size.width, self.view.frame.size.height);

}

- (void)keyboardWillHide {
    
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.schoolButton.hidden = NO;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 获取验证码
- (IBAction)getCodeClick:(id)sender {
   [AVOSCloud requestSmsCodeWithPhoneNumber:self.phoneNumberTextField.text callback:^(BOOL succeeded, NSError *error) {
       if (!succeeded) {
           NSString *errorMessage = [error.userInfo objectForKey:@"error"];
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取失败" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
           [alertController addAction:confirmAction];
           [self presentViewController:alertController animated:YES completion:nil];
       }
   }];
    self.countDown = 60;
    [self startTimer];
    
}

#pragma mark - 按钮的倒计时
- (void)startTimer {
    [self.getCodeButton setEnabled:NO];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void)onTimer {
    
    if (_countDown > 0) {
        [self.getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒重新获取", (long)_countDown] forState:UIControlStateDisabled];
        _countDown--;
    } else {
        _countDown = 60;
        [_timer invalidate];
        _timer = nil;
        [self.getCodeButton setTitle:@"60秒重新获取" forState:UIControlStateDisabled];
        [self.getCodeButton setTitle:@"重发验证码" forState:UIControlStateNormal];
        [self.getCodeButton setEnabled:YES];
    }
}

#pragma mark - 注册
- (IBAction)signUpClick:(id)sender {
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:self.phoneNumberTextField.text smsCode:self.codeTextField.text block:^(AVUser *user, NSError *error) {
        if (!error) {
            [user setObject:self.schoolButton.titleLabel.text forKey:@"schoolName"];
            [user saveInBackground];
        } else {
            NSString *errorMessage = [error.userInfo objectForKey:@"error"];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:confirmAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
