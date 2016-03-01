//
//  ViewController.h
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/1.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *pageTitles;
@property (nonatomic, strong) NSArray *pageImages;

@end

