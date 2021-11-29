//
//  CommentTableViewCell.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/8.
//

#import "CommentTableViewCell.h"
#import "Masonry.h"
#import "TopLeftLabel.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

@implementation CommentTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _labelDate = [[UILabel alloc] init];
    _labelDate.font = [UIFont systemFontOfSize:13];
    _labelDate.textColor = [UIColor grayColor];
    
    _labelReply = [[UILabel alloc] init];
    _labelReply.font = [UIFont systemFontOfSize:15];
    _labelReply.textColor = [UIColor grayColor];
    
   
    
    if ([reuseIdentifier isEqualToString:@"Empty"]) {
        self.textLabel.text = @"还没有评论";
        self.textLabel.font = [UIFont systemFontOfSize:20];
        self.textLabel.textColor = [UIColor grayColor];
    } else if ([reuseIdentifier isEqualToString:@"LongCommentTitle"]) {
        _labelLongCommentTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_labelLongCommentTitle];
        [_labelLongCommentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(5);
                    make.left.mas_equalTo(20);
                    make.size.mas_equalTo(CGSizeMake(W/2, 30));
        }];
        _labelLongCommentTitle.font = [UIFont systemFontOfSize:22];
    } else if ([reuseIdentifier isEqualToString:@"ShortCommentTitle"]) {
        _labelShortCommentTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_labelShortCommentTitle];
        [_labelShortCommentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(5);
                    make.left.mas_equalTo(20);
                    make.size.mas_equalTo(CGSizeMake(W/2, 30));
        }];
        _labelShortCommentTitle.font = [UIFont systemFontOfSize:22];
    } else if ([reuseIdentifier isEqualToString:@"Last"]) {
        UILabel* label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).mas_offset(20);
            make.left.equalTo(self).mas_offset(W / 2 - 80);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(30);
        }];
        label.text = @"已加载完所有评论";
        label.font = [UIFont systemFontOfSize:18];
    } else {
        _CommentImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_CommentImageView];
        [_CommentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10).priority(500);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        _CommentImageView.layer.cornerRadius = 25;
        _CommentImageView.layer.masksToBounds = YES;
        
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView.mas_top).offset(10);
                    make.left.equalTo(self.CommentImageView.mas_right).offset(20);
                    make.size.mas_equalTo(CGSizeMake(200, 30));
        }];
        NSLog(@"%@", self.CommentImageView.mas_right);
        self.labelName.font = [UIFont systemFontOfSize:18];
        self.labelContent = [[UILabel alloc] init];
        
        self.labelContent.numberOfLines = 0;
        self.labelContent.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.labelContent];
        [self.labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labelName.mas_bottom).offset(10);
            make.left.equalTo(self.labelName.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];
        
        UIButton* buttonEllipsis = [[UIButton alloc] initWithFrame:CGRectMake(W - 50, 20, 30, 30)];
        [buttonEllipsis setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/shenglvehao.png"] forState:UIControlStateNormal];
        buttonEllipsis.tintColor = [UIColor grayColor];
        [self.contentView addSubview:buttonEllipsis];
        
         self.labelReply = [[UILabel alloc] init];
         [self.contentView addSubview:self.labelReply];
         [self.labelReply mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(self.labelContent.mas_bottom).offset(10);
             make.left.equalTo(self.labelContent.mas_left);
             make.right.equalTo(self.contentView.mas_right).offset(-20);
             
             
         }];
        self.labelReply.numberOfLines = 2;
        self.labelReply.font = [UIFont systemFontOfSize:15];
        self.labelReply.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_labelDate];
        [_labelDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.left.equalTo(self.labelName.mas_left);
            make.top.equalTo(self.labelReply.mas_bottom).mas_equalTo(20);
        }];
       
        self.buttonFold = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.buttonFold setTitle:@"展开全文" forState:UIControlStateNormal];
        [self.buttonFold setTitle:@"收起" forState:UIControlStateSelected];
        self.buttonFold.tintColor = [UIColor whiteColor];
        [self.buttonFold setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [self.buttonFold setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.buttonFold.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.buttonFold];
        [self.buttonFold mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(15);
            make.left.equalTo(self.labelDate.mas_right).offset(10);
            make.top.equalTo(self.labelDate.mas_top);
        }];
        self.buttonFold.hidden = YES;
    }
    return self;
}


- (void) layoutSubviews {
    self.textLabel.frame = CGRectMake(W / 2 - 70, H / 2 - 100, 200, 50);
}



@end
