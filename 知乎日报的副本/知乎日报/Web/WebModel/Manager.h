//
//  Manager.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/6.
//

#import <Foundation/Foundation.h>
#import "WebMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^TestSucceedBlock)(WebMessageModel * _Nonnull mainViewNowModel);
//失败返回error
typedef void (^ErrorBlock)(NSError * _Nonnull error);
@interface Manager : NSObject
+ (instancetype)sharedManage;
- (void)NetWorkTestWithData:(TestSucceedBlock) succeedBlock error:(ErrorBlock) errorBlock and:(NSString*) string;
@end

NS_ASSUME_NONNULL_END
