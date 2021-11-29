//
//  CollectTableViewCell.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/12.
//

#import "CollectTableViewCell.h"
#import "Masonry.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

@implementation CollectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([reuseIdentifier isEqualToString:@"Empty"]) {
        self.label = [[UILabel alloc] init];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).mas_offset(H / 2 - 20);
            make.left.equalTo(self).mas_offset(W / 2 -50);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(40);
        }];
        self.label.text = @"你还没有收藏～";
        self.label.font = [UIFont systemFontOfSize:20];
    } else if ([reuseIdentifier isEqualToString:@"collect"]) {
        self.collectImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.collectImageView];
        [self.collectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.width.mas_equalTo(80);
        }];
        
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(20);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.right.equalTo(self.collectImageView.mas_left).offset(-20);
        }];
        self.label.numberOfLines = 0;
        self.label.font = [UIFont systemFontOfSize:20];
    } else {
        self.label = [[UILabel alloc] init];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).mas_offset(20);
            make.left.equalTo(self).mas_offset(W / 2 -50);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(40);
        }];
        self.label.text = @"没有更多内容";
        self.label.font = [UIFont systemFontOfSize:20];
        self.label.textColor = [UIColor grayColor];
    }
    return self;
}



@end
