//
//  StoriesView.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoriesView : UIView
@property (nonatomic, strong) UIButton* buttonBack;
@property (nonatomic, strong) UIButton* buttonLike;
@property (nonatomic, strong) UIButton* buttonComment;
@property (nonatomic, strong) UIButton* buttonCollect;
@property (nonatomic, strong) UIButton* buttonShare;
@property (nonatomic, strong) UILabel* labelLike;
@property (nonatomic, strong) UILabel* labelComment;
@property(nonatomic, strong) NSMutableArray* commentNumber;
@property(nonatomic, strong) NSMutableArray* likeNumber;

@end

NS_ASSUME_NONNULL_END
