//
//  MyTableViewCell.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/5.
//

#import "MyTableViewCell.h"
#import "Masonry.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    
    
    
    if ([reuseIdentifier isEqualToString:@"0"]) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(W / 2 - 40, 70, 80, 80)];
        imageView.layer.cornerRadius = 40;
        imageView.layer.masksToBounds = YES;
        imageView.image = [UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/头像.jpg"];
        [self addSubview:imageView];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(W / 2 - 55, 180, 100, 50)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"轩墨";
        label.font = [UIFont systemFontOfSize:25];
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    } else if ([reuseIdentifier isEqualToString:@"1"]) {
        self.textLabel.font = [UIFont systemFontOfSize:20];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        UIButton* buttonSetUp = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSetUp.frame = CGRectMake(240, H / 4, 50, 50);
        [buttonSetUp setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/shezhi.png"] forState:UIControlStateNormal];
        [buttonSetUp setTintColor:[UIColor blackColor]];
        [self addSubview:buttonSetUp];
        UILabel* labelSetup = [[UILabel alloc] init];
        [self addSubview:labelSetup];
        [labelSetup mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(buttonSetUp.mas_bottom).offset(10);
            make.left.equalTo(buttonSetUp.mas_left).offset(5);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
        labelSetup.text = @"设置";
        [labelSetup setTintColor:[UIColor blackColor] ];
        labelSetup.font = [UIFont systemFontOfSize:20];
        
        
        UIButton* buttonNight = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonNight.frame = CGRectMake(100, H / 4, 50, 50);
        buttonNight.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [buttonNight setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/icon_yejianmoshi.png"] forState:UIControlStateNormal];
        [buttonNight setTintColor:[UIColor blackColor]];
        [self addSubview:buttonNight];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel* labelNight = [[UILabel alloc] init];
        [self addSubview:labelNight];
        [labelNight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(buttonNight.mas_bottom).offset(10);
            make.left.equalTo(buttonNight.mas_left).offset(-15);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
        labelNight.text = @"夜间模式";
        [labelNight setTintColor:[UIColor blackColor]];
        labelNight.font = [UIFont systemFontOfSize:20];
        
    }
    return self;
}

@end
