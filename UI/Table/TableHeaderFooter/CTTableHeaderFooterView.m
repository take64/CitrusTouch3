//
//  CTTableHeaderFooterView.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/15.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTableHeaderFooterView.h"

@implementation CTTableHeaderFooterView

//
// synthesize
//
@synthesize label;
@synthesize control;
@synthesize margin;

// init
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self)
    {
        // parts
        CTLabel *_label;
        
        // label
        _label = [[CTLabel alloc] initWithText:@""];
        [[_label callStyle] addStyles:@{
                                        @"height"       :@"18",
                                        @"font-size"    :@"14",
                                        @"text-align"   :@"left",
//                                        @"color"        :[CTColor hexStringWithColor:[[CitrusTouchApplication callTheme] callTableCellHeadTextColor]],
                                        @"padding"       :@"2 8"
                                        }];
        [self setLabel:_label];
        
        // view
        [self setControl:[[UIView alloc] initWithFrame:CGRectZero]];
        
        // theme
        [[self contentView] setBackgroundColor:[CTColor colorTableBackground]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[[self label] callStyle] setFrame:rect];
}

#pragma mark - method

//
// method
//

// bind title
- (void)bindTitle:(NSString *)titleString
{
    [[self label] setText:titleString];
    
    // remove
    [[self control] removeFromSuperview];
    
    // add
    [[self contentView] addSubview:[self label]];

    // サイズ調整
    CGRect rect = [self frame];
    rect.size.height = [[self label] frame].origin.y + [[self label] frame].size.height + CT8(1);
    [self setFrame:rect];
    [[self contentView] setFrame:rect];
}

// bind view
- (void)bindView:(UIControl *)viewValue
{
    [[self label] setText:@""];
    
    // remove
    [[self label] removeFromSuperview];
    
    // add
    [self setControl:viewValue];
    [[self contentView] addSubview:[self control]];
    
    // サイズ調整
    CGRect rect = [self frame];
    rect.size.height = [viewValue frame].size.height;
    // margin
    if([self isKindOfClass:[CTTableFooterView class]] == YES)
    {
        rect.size.height += [self margin];
    }
    [self setFrame:rect];
}

// call reuse id
+ (NSString *)reuseIdentifierWithSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"CTTableHeaderFooterView_%03ld", (long)section];
}


@end
