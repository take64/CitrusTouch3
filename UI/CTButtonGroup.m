//
//  CTButtonGroup.m
//  CitrusTouch3
//
//  Created by take64 on 2017/11/20.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTButtonGroup.h"

@implementation CTButtonGroup



//
// synthesize
//
@synthesize buttons;



#pragma mark - extends
//
// extends
//

// init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[[self widthAnchor] constraintEqualToConstant:0] setActive:NO];
        [[[self heightAnchor] constraintEqualToConstant:0] setActive:NO];
    }
    return self;
}



#pragma mark - method
//
// method
//

// ボタングループの生成
+ (instancetype)bottunGroup
{
    return [[[self class] alloc] initWithFrame:CGRectZero];
}

// ボタンの追加
- (void)addButton:(CTButton *)buttonValue
{
    if ([self buttons] == nil)
    {
        [self setButtons:[NSMutableArray array]];
    }

    [[self buttons] addObject:buttonValue];
    [self addSubview:buttonValue];
}

// ボタンの追加(文字列から)
- (CTButton *)addButtonWithTitle:(NSString *)titleString complete:(CTButtonTappedBlock)completeBlock
{
    CTButton *button = [[CTButton alloc] initWithText:titleString];
    [button setOnTappedComplete:completeBlock];
    [[button callStyle] addStyles:@{
                                    @"width"            :@"32",
                                    @"height"           :@"16",
                                    @"font-size"        :@"14",
                                    @"padding"          :@"4 8 4 8",
                                    @"color"            :[CTColor hexStringWithColor:[[CitrusTouchApplication callTheme] callNavigationBarTextColor]],
                                    @"background-color" :[CTColor hexStringWithColor:[[CitrusTouchApplication callTheme] callNavigationBarTintColor]],
                                    }];
    [self addButton:button];

    return button;
}

// CTBarButtonItemへ変換
- (CTBarButtonItem *)toBarButtonItem
{
    return [[CTBarButtonItem alloc] initWithCustomView:self];
}


#pragma mark - private
//
// private
//

- (void)layoutSubviews
{
    CGFloat width = 0;
    CGFloat height = 0;
    CTButton *firstButton = nil;
    CTButton *lastButton = nil;

    for (CTButton *button in [self buttons])
    {
        // 非表示のアイテムはスルーする
        if ([button isHidden] == YES)
        {
            continue;
        }

        // 自動ボタンサイズ
        CGSize buttonSize = [button calcTextAutoSizeWithPadding];

        // ボタンの横位置調整
        [[button callStyle] addStyles:@{
                                        @"left"     :CTStr(width),
                                        @"width"    :CTStr(buttonSize.width),
                                        @"height"   :CTStr(buttonSize.height),
                                        }];
        // ボタングループ用のサイズスタック
        width += buttonSize.width;
        height = MAX(height, buttonSize.height);
        // ボタン角丸め用のスタック
        if (firstButton == nil)
        {
            firstButton = button;
        }
        lastButton = button;
    }
    // ボタングループのサイズ調整
    [[self callStyle] addStyles:@{
                                 @"width"   :CTStr(width),
                                 @"height"  :CTStr(height),
                                 }];
    // ボタンの角丸め
    if (firstButton == lastButton)
    {
        [[firstButton callStyle] addStyleKey:@"border-radius" value:@"4"];
    }
    else
    {
        [[firstButton callStyle] addStyleKey:@"border-radius" value:@"4 0 0 4"];
        [[lastButton callStyle]  addStyleKey:@"border-radius" value:@"0 4 4 0"];
    }
}

@end
