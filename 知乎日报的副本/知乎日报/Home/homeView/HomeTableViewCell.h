//
//  HomeTableViewCell.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/22.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"
#import "HomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
<UIScrollViewDelegate>
@property(nonatomic, copy) TestModel* testModel;
@property(nonatomic, assign) int H;
@property(nonatomic, assign) int W;
@property(nonatomic, strong) NSMutableArray* Top_StoriesTitle;
@property(nonatomic, strong) NSMutableArray* Top_StoriesHint;
@property(nonatomic, strong) NSMutableArray* Top_StoriesUrl;
@property(nonatomic, strong) NSMutableArray* Top_StoriesImage;

@property(nonatomic, strong) NSMutableArray* StoriesTitle;
@property(nonatomic, strong) NSMutableArray* StoriesHint;
@property(nonatomic, strong) NSMutableArray* StoriesUrl;
@property(nonatomic, strong) NSMutableArray* StoriesImages;
@property(nonatomic, strong) NSString* stringImage;
@property(nonatomic, strong) UILabel* labelTitle;
@property(nonatomic, strong) UILabel* labelSubtitle;
@property(nonatomic, strong) UIButton* button;
@property(nonatomic, strong) UILabel* label;
@property(nonatomic, strong) NSTimer* timer;
@property(nonatomic, strong) UIImageView* storiesImageView;
@end

NS_ASSUME_NONNULL_END
