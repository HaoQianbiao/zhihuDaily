//
//  CollectViewController.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/10.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
#import "CollectView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollectViewController : UIViewController
@property (nonatomic, strong) NSString* path;
@property (nonatomic, strong) FMDatabase* database;
@property (nonatomic, strong) CollectView* collectView;
@end

NS_ASSUME_NONNULL_END
