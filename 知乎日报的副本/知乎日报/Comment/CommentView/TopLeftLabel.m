//
//  TopLeftLabel.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/9.
//

#import "TopLeftLabel.h"

@implementation TopLeftLabel

- (id)initWithFrame:(CGRect)frame {
    return [super initWithFrame:frame];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.y = bounds.origin.y;
    return textRect;
}

- (void) drawTextInRect:(CGRect) requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:requestedRect];
}

@end
