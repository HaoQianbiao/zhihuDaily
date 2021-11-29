//
//  CommentTableViewCell.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentTableViewCell : UITableViewCell
@property(nonatomic, strong) UILabel* labelLongCommentTitle;
@property(nonatomic, strong) UILabel* labelShortCommentTitle;
@property(nonatomic, strong) UILabel* labelName;
@property(nonatomic, strong) UILabel* labelContent;
@property(nonatomic, strong) UILabel* labelDate;
@property(nonatomic, strong) UILabel* labelReply;
@property(nonatomic, strong) UIImageView* CommentImageView;
@property(nonatomic, strong) UIButton* buttonFold;

@end

NS_ASSUME_NONNULL_END
