//
//  homeViewController.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/18.
//

#import <UIKit/UIKit.h>
#import "HomeView.h"


NS_ASSUME_NONNULL_BEGIN

@interface homeViewController : UIViewController
<UIScrollViewDelegate>
@property(nonatomic, strong) HomeView* homeView;
//@property(nonatomic, copy) TestModel* testModel;
@end

NS_ASSUME_NONNULL_END
