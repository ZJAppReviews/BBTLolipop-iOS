//
//  BBTTask.m
//  帮帮堂
//
//  Created by 唐耀 on 16/2/21.
//  Copyright © 2016年 唐耀. All rights reserved.
//

#import "BBTTask.h"

@implementation BBTTask
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.detail = [dic objectForKey:@"detail"];
        self.taskSender = [dic objectForKey:@"taskSender"];
        self.taskReceiver = [dic objectForKey:@"taskReceiver"];
        self.taskState = [[dic objectForKey:@"taskState"]intValue];
        self.taskType = [dic objectForKey:@"taskType"];
        self.money = [dic objectForKey:@"money"];
        self.schoolName = [dic objectForKey:@"schoolName"];
        self.createdAt = [dic objectForKey:@"createdAt"];
        self.updatedAt = [dic objectForKey:@"updatedAt"];
        self.objectId = [dic objectForKey:@"objectId"];
    }
    return self;
    
}

+ (instancetype)taskWithDictionary:(NSDictionary *)dic {
    return [[self alloc] initWithDictionary:dic];
}

@end
