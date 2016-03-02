//
//  BBTSchoolListViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/2.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTSchoolListViewController.h"
#import <AVOSCloud.h>

@interface BBTSchoolListViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong)  NSArray *schoolList;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation BBTSchoolListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVQuery *query = [AVQuery queryWithClassName:@"School"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        _schoolList = objects;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.schoolList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"schoolCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    
    
    NSDictionary *school = self.schoolList[indexPath.row];
    cell.textLabel.text = school[@"name"];
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.backgroundColor = [UIColor colorWithRed:45 / 255.0 green:98 / 255.0 blue:118 / 255.0 alpha:1.0];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *school = self.schoolList[indexPath.row];
    NSString *schoolname = school[@"name"];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setSchoolNameNotification" object:schoolname];
    [self.navigationController popViewControllerAnimated:YES];
    
}






@end
