//
//  homeModel.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/18.
//

#import <Foundation/Foundation.h>
#import "TestModel.h"
typedef void (^TestSucceedBlock)(TestModel * _Nonnull mainViewNowModel);
//失败返回error
typedef void (^ErrorBlock)(NSError * _Nonnull error);
NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject
+ (instancetype)sharedManage;
- (void)NetWorkTestWithData:(TestSucceedBlock) succeedBlock error:(ErrorBlock) errorBlock and:(NSString*) string;
@end

NS_ASSUME_NONNULL_END
