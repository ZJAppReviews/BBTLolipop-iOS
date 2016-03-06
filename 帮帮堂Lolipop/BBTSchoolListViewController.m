//
//  BBTSchoolListViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/2.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "BBTSchoolListViewController.h"
#import <AVOSCloud.h>

@interface BBTSchoolListViewController () <UISearchResultsUpdating>
@property (nonatomic, strong) NSArray *schoolList;
@property (nonatomic, strong) NSMutableArray *filterSchool;
@property (nonatomic, strong) UISearchController *resultSearchController;


@end

@implementation BBTSchoolListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVQuery *query = [AVQuery queryWithClassName:@"School"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        self.schoolList = objects;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    self.resultSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.resultSearchController.searchResultsUpdater = self;
    self.resultSearchController.dimsBackgroundDuringPresentation = NO;
    [self.resultSearchController.searchBar sizeToFit];
    self.resultSearchController.searchBar.barTintColor = [UIColor colorWithRed:56 / 255.0 green:117 / 255.0 blue:137 / 255.0 alpha:1];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor whiteColor]];

    self.tableView.tableHeaderView = self.resultSearchController.searchBar;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    if (self.resultSearchController.active) {
        return self.filterSchool.count;
    }
    return self.schoolList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"schoolCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (self.resultSearchController.active) {
        NSDictionary *school = self.filterSchool[indexPath.row];
        cell.textLabel.text = school[@"name"];
        return cell;
    }
    
    NSDictionary *school = self.schoolList[indexPath.row];
    cell.textLabel.text = school[@"name"];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *schoolname = [[NSString alloc] init];
    if (self.resultSearchController.active) {
        NSDictionary *school = self.filterSchool[indexPath.row];
        schoolname = school[@"name"];
        self.resultSearchController.active = NO;
    } else {
        NSDictionary *school = self.schoolList[indexPath.row];
        schoolname = school[@"name"];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setSchoolNameNotification" object:schoolname];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.filterSchool removeAllObjects];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"name contains [c] %@", searchController.searchBar.text];
    self.filterSchool = [NSMutableArray arrayWithArray:[self.schoolList filteredArrayUsingPredicate:searchPredicate]];
    
    [self.tableView reloadData];
}

-(void)dealloc {
    [self.resultSearchController.view removeFromSuperview];
}@end
