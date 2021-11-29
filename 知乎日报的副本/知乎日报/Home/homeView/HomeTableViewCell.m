//
//  HomeTableViewCell.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/22.
//

#import "HomeTableViewCell.h"
#import "Masonry.h"
#import "homeViewController.h"
#import "UIImageView+WebCache.h"

#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
@implementation HomeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    
    
    if ([reuseIdentifier isEqualToString:@"0"]) {
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, W);
    } else if ([reuseIdentifier isEqualToString:@"1"]){

        self.labelTitle = [[UILabel alloc] init];
        [self addSubview:self.labelTitle];
        [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self).offset(30);
                    make.left.equalTo(self).offset(10);
                    make.width.equalTo(@(300));
                    make.height.equalTo(@(60));
        }];
        self.labelTitle.font = [UIFont systemFontOfSize:20];
        self.labelTitle.textColor = [UIColor blackColor];
        self.labelTitle.numberOfLines = 2;
        self.labelTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.labelSubtitle = [[UILabel alloc] init];
        [self addSubview:self.labelSubtitle];
        [self.labelSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self).offset(90);
                    make.left.equalTo(self).offset(10);
                    make.width.equalTo(@(250));
                    make.height.equalTo(@(30));
        }];
        self.labelSubtitle.font = [UIFont systemFontOfSize:15];
        self.labelSubtitle.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8];
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, W);
        self.storiesImageView = [[UIImageView alloc] init];
        [self addSubview:self.storiesImageView];
        [self.storiesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self).offset(25);
                    make.right.equalTo(self).offset(-20);
                    make.width.equalTo(@(100));
                    make.height.equalTo(@(100));
        }];
    } else if ([reuseIdentifier isEqualToString:@"3"]) {
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, W);

    } else {
        UIView* seperatorView = [[UIView alloc] initWithFrame:CGRectMake(120, 25, W - 120, 2)];
        seperatorView.backgroundColor = [UIColor grayColor];
        [self addSubview:seperatorView];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 40)];
        _label.textColor = [UIColor grayColor];
        _label.font = [UIFont systemFontOfSize:20];
        [self addSubview:_label];
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, W);

    }
    return self;
    
}




@end
