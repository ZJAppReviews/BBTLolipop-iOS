//
//  BBTTaskViewCell.h
//  帮帮堂Lolipop
//
//  Created by 唐耀 on 16/3/4.
//  Copyright © 2016年 Donyaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBTTaskViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *backgoundView;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskTypeLabel;

@end
