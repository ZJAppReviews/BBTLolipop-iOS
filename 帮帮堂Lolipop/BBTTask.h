//
//  BBTTask.h
//  帮帮堂
//
//  Created by 唐耀 on 16/2/21.
//  Copyright © 2016年 唐耀. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    TaskStateDo = 0,
    TaskStateDoing = 1,
    TaskStateDone = 2,
    TaskStateConfirm = 3,
    TaskStateCancel = 4
} TaskState;


@interface BBTTask : NSObject

@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *taskSender;
@property (nonatomic, copy) NSString *taskReceiver;
@property (nonatomic,assign) TaskState taskState;
@property (nonatomic, copy) NSString *taskType;
@property (nonatomic) NSNumber *money;
@property (nonatomic, copy) NSString *schoolName;
@property (nonatomic) NSDate *createdAt;
@property (nonatomic) NSDate *updatedAt;
@property (nonatomic, copy) NSString *objectId;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)taskWithDictionary:(NSDictionary *)dic;
@end

