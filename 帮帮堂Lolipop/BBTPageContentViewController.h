//
//  PageContentViewController.h
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/1.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBTPageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property  NSUInteger pageIndex;
@property  NSString *titleText;
@property  NSString *imageFile;
@end
