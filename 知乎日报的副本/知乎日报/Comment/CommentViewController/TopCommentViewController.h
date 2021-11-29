//
//  TopCommentViewController.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/8.
//

#import <UIKit/UIKit.h>
#import "CommentView.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopCommentViewController : UIViewController
@property (nonatomic, strong) CommentView* commentView;
@property (nonatomic, strong) NSMutableArray* idArray;
@property (nonatomic, strong) NSString* stringLongComment;
@property (nonatomic, strong) NSString* stringShortComment;
@property (nonatomic, strong) NSString* stringNumber;
@end

NS_ASSUME_NONNULL_END
