//
//  homeView.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/18.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeView : UIView
<UITableViewDelegate,
UITableViewDataSource>
@property(nonatomic, copy) TestModel* testModel;

@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) UILabel* labelDateDay;
@property(nonatomic, strong) UILabel* labelDateMonth;
@property(nonatomic, strong) UILabel* labelTitle;
@property(nonatomic, strong) UIImageView* imageView;
@property(nonatomic, strong) NSString* stringTest;
@property(nonatomic, strong) UIScrollView* scrollView;
@property(nonatomic, strong) NSTimer* timer;
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, assign) int Flag;
@property(nonatomic, strong) NSDate* lastDate;
@property(nonatomic, strong) UIActivityIndicatorView *testActivityIndicator;
@property(nonatomic, strong) UIViewController* controller;
@property(nonatomic, assign) int seclect;
@property(nonatomic, strong) NSMutableArray* dateArray;
@property(nonatomic, strong) NSString* panduan;
- (void)setup;
- (void)testBefore;


@end

NS_ASSUME_NONNULL_END
