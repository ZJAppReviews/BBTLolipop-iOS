//
//  BBTSignUpViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/1.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTSignUpViewController.h"

@interface BBTSignUpViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *signupInfoView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *schoolButton;


@end

@implementation BBTSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setSchoolName:) name:@"setSchoolNameNotification" object:nil];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.background = [UIImage imageNamed:@"textfield01"];
    
   }

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.background = [UIImage imageNamed:@"textfield02"];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];

}

- (void)setSchoolName:(NSNotification *)noti {
    NSLog(@"%@", noti.object);
    
    [self.schoolButton setTitle:noti.object forState:UIControlStateNormal];

   
}
- (void)keyboardWillShow {
    self.schoolButton.hidden = YES;

    self.view.frame = CGRectMake(0, -154, self.view.frame.size.width, self.view.frame.size.height);

}

- (void)keyboardWillHide {
    
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.schoolButton.hidden = NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
