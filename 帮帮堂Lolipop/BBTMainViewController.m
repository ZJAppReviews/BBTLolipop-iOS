//
//  BBTMainViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/4.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTMainViewController.h"
#import "BBTTaskViewController.h"
#import <AVOSCloud.h>

@interface BBTMainViewController ()
@property (nonatomic, weak)BBTTaskViewController *taskViewController;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;

@end

@implementation BBTMainViewController

- (void)loadTaskList {
    AVUser *currentUser = [AVUser currentUser];
    
    AVQuery *query = [AVQuery queryWithClassName:@"Task"];
    [query whereKey:@"taskState" equalTo:[NSNumber numberWithInt:0]];
    [query whereKey:@"schoolName" equalTo:[currentUser objectForKey:@"schoolName"]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.taskViewController.taskList = objects;
        if (objects.count == 0) {
            self.tipImageView.hidden = NO;
        } else {
            self.tipImageView.hidden = YES;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.taskViewController.tableView reloadData];
        });
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.taskViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TaskViewController"];
    [self addChildViewController:self.taskViewController];
    [self.view addSubview:self.taskViewController.tableView];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lolipop2"]];
    [self loadTaskList];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTaskList) name:@"refreshTableViewNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
