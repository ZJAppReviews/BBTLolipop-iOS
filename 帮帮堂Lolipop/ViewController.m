//
//  ViewController.m
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/1.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import "ViewController.h"
#import "PageContentViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置首页Button的圆角
    self.loginButton.layer.cornerRadius = 4.5;
    self.signupButton.layer.cornerRadius = 4.5;
    
    self.loginButton.backgroundColor = [UIColor colorWithRed:158 / 255.0 green:158 / 255.0 blue:158 / 255.0 alpha:68 / 255.0];

    self.pageTitles = @[@"轻轻的，改变你的生活。", @"取快递，打水，无所不能。",@"欢迎来到新的世界！"];
    self.pageImages = @[@"1.jpg", @"2.jpg", @"3.jpg"];
    
    // 初始化一个pageViewController
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    // 初始第一个页面
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.pageController.numberOfPages = [self.pageImages count];
    

    [self.view addSubview:self.pageViewController.view];
   
//    [self.pageViewController didMoveToParentViewController:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = ((PageContentViewController *)viewController).pageIndex;
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = ((PageContentViewController *) viewController).pageIndex;
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [self.pageTitles count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}


- (PageContentViewController *)viewControllerAtIndex:(NSInteger)index {
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];

    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;

}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (!completed) {
        return;
    }
    PageContentViewController *pageContentViewController= (PageContentViewController *)[self.pageViewController.viewControllers lastObject] ;
    self.pageController.currentPage = [pageContentViewController pageIndex];
}



@end
