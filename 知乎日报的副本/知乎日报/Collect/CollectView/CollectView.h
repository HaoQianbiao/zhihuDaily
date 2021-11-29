//
//  CollectView.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectView : UIView
<UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* titleArray;
@property (nonatomic, strong) NSMutableArray* imageArray;
@property (nonatomic, strong) NSMutableArray* URLArray;
@property (nonatomic, strong) UIViewController* controller;
@property(nonatomic, strong) NSMutableArray* idArray;
@end

NS_ASSUME_NONNULL_END
