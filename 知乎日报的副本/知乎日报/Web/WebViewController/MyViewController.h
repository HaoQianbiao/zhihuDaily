//
//  MyViewController.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/24.
//

#import <UIKit/UIKit.h>
#import "HomeView.h"
#import "StoriesView.h"
#import "FMDB.h"
#import <Webkit/Webkit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MyViewController : UIViewController
<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView* scrollView;
@property(nonatomic, strong) NSMutableArray* urlStoriesArray;
@property(nonatomic, strong) NSMutableArray* idArray;
@property(nonatomic, assign) NSInteger flagStories;
@property(nonatomic, strong) NSMutableArray* WebArray;
@property(nonatomic, strong) StoriesView* storiesView;
@property(nonatomic, assign) int select;
@property(nonatomic, assign) NSString* flag;
@property(nonatomic, strong) NSString* numberComment;
@property(nonatomic, strong) NSMutableArray* titleArray;
@property(nonatomic, strong) NSMutableArray* imageArray;
@property(nonatomic, strong) FMDatabase* database;
@property(nonatomic, strong) NSString* path;
@property(nonatomic, strong) WKWebView* wkWebView;
- (void)update;
@end

NS_ASSUME_NONNULL_END
