//
//  StoriesView.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/2.
//

#import "StoriesView.h"
#import "Masonry.h"

@implementation StoriesView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.buttonBack = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonBack.tintColor = [UIColor blackColor];
    [self addSubview:_buttonBack];
    [self.buttonBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(20);
        make.width.equalTo(@(25));
        make.height.equalTo(@(25));
    }];
    
    [self.buttonBack setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/fanhui.png"] forState:UIControlStateNormal];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/fengexian-3.png"]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self.buttonBack).offset(50);
            make.width.equalTo(@(5));
            make.height.equalTo(@(40));
    }];
    
    self.buttonComment = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:_buttonComment];
    self.buttonComment.tintColor = [UIColor blackColor];
    [_buttonComment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(imageView).offset(40);
            make.width.equalTo(@(25));
            make.height.equalTo(@(25));
    }];
    [_buttonComment setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/pinglun.png"] forState:UIControlStateNormal];
    _labelComment = [[UILabel alloc] init];
    [self addSubview:_labelComment];
    [_labelComment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(_buttonComment).offset(30);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
    }];
    _labelComment.font = [UIFont systemFontOfSize:15];
    
    
    self.buttonLike = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_buttonLike];
    self.buttonLike.tintColor = [UIColor blackColor];
    [_buttonLike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self.labelComment).offset(60);
            make.width.equalTo(@(33));
            make.height.equalTo(@(33));
    }];
    [_buttonLike setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/zan.png"] forState:UIControlStateNormal];
    _labelLike = [[UILabel alloc] init];
    [self addSubview:_labelLike];
    [_labelLike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(_buttonLike).offset(30);
            make.width.equalTo(@(40));
            make.height.equalTo(@(20));
    }];
    _labelLike.font = [UIFont systemFontOfSize:15];

    
    
    
    self.buttonCollect = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_buttonCollect];
    self.buttonCollect.tintColor = [UIColor blackColor];
    [_buttonCollect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self.labelLike).offset(60);
            make.width.equalTo(@(30));
            make.height.equalTo(@(30));
    }];
    self.buttonCollect.selected = NO;
    [_buttonCollect setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/collect.png"] forState:UIControlStateNormal];
    
    self.buttonShare = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:_buttonShare];
    self.buttonShare.tintColor = [UIColor blackColor];
    [_buttonShare mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self.buttonCollect).offset(70);
            make.width.equalTo(@(35));
            make.height.equalTo(@(35));
    }];
    [_buttonShare setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/fenxiang.png"] forState:UIControlStateNormal];
    
    return self;
}




@end
