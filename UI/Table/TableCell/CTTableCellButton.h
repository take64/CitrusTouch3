//
//  CTTableCellButton.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/01.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTableCell.h"

@class CTButton;

@interface CTTableCellButton : CTTableCell
{
    // ボタン
    CTButton *button;
}

//
// property
//
@property (nonatomic, retain) CTButton *button;



//
// method
//

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSString *)textString reuseIdentifier:(NSString *)reuseIdentifier;

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// テキスト取得
- (NSString *)contentText;

// テキスト設定
- (void)setContentText:(NSString *)stringValue;

@end
