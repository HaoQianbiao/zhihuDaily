//
//  MyMessageView.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyMessageView : UIView
<UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic, strong)UITableView* tableView;
@property(nonatomic, strong) UIViewController* controller;

@end

NS_ASSUME_NONNULL_END
