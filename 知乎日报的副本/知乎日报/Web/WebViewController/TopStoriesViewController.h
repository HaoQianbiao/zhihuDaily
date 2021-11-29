//
//  TopStoriesViewController.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/31.
//

#import <UIKit/UIKit.h>
#import "StoriesView.h"
#import "FMDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopStoriesViewController : UIViewController
<UIScrollViewDelegate>

@property(nonatomic, strong) NSMutableArray* urlTopStoriesArray;
@property(nonatomic, assign) NSInteger flagTopStories;
@property(nonatomic, strong) NSMutableArray* idArray;
@property(nonatomic, strong) UIScrollView* scrollView;
@property(nonatomic, strong) StoriesView* storiesView;
@property(nonatomic, strong) NSMutableArray* commentNumber;
@property(nonatomic, strong) NSMutableArray* likeNumber;
@property(nonatomic, strong) NSString* numberComment;
@property(nonatomic, strong) FMDatabase* database;
@property(nonatomic, strong) NSString* path;
@property(nonatomic, strong) NSMutableArray* titleArray;
@property(nonatomic, strong) NSMutableArray* imageArray;
@property(nonatomic, strong) NSMutableArray* WebArray;
@end

NS_ASSUME_NONNULL_END
