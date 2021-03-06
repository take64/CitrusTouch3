//
//  CTTackItem.m
//  CitrusTouch3
//
//  Created by take64 on 2017/04/02.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTaskItem.h"

@implementation CTTaskItem

//
// synthesize
//
@synthesize state;
@synthesize taskBlock;
@synthesize nextTaskAutoStart;


#pragma mark - method
//
// method
//

// 初期化
- (id)initWithBlock:(CitrusTouchTaskBlock)block
{
    return [self initWithBlock:block nextTaskAutoStart:YES];
}

// 初期化
- (id)initWithBlock:(CitrusTouchTaskBlock)block nextTaskAutoStart:(BOOL)autoStart
{
    self = [super init];
    if(self)
    {
        // 状態
        [self setState:CitrusTouchTaskStateWait];
        
        // タスク
        [self setTaskBlock:block];
        
        // 次のタスクを自動スタート
        [self setNextTaskAutoStart:autoStart];
    }
    return self;
}

// タスク実行
- (void)start
{
    // タスクを実行中に変更
    [self setState:CitrusTouchTaskStateProcessing];
    
    // タスク開始
    if(self.taskBlock != nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.taskBlock();
        });
    }
}

// 初期化
+ (instancetype)taskWithBlock:(CitrusTouchTaskBlock)block
{
    return [[CTTaskItem alloc] initWithBlock:block];
}

// 初期化
+ (instancetype)taskWithBlock:(CitrusTouchTaskBlock)block nextTaskAutoStart:(BOOL)autoStart
{
    return [[CTTaskItem alloc] initWithBlock:block nextTaskAutoStart:autoStart];
}

@end
