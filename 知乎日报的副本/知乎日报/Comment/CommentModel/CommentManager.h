//
//  CommentManager.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/6.
//

#import <Foundation/Foundation.h>
#import "ShortCommentModel.h"
#import "LongCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^TestSucceedShortBlock)(ShortCommentModel * _Nonnull mainViewNowModel);
typedef void (^TestSucceedLongBlock)(LongCommentModel * _Nonnull mainViewNowModel);

//失败返回error
typedef void (^ErrorBlock)(NSError * _Nonnull error);

@interface CommentManager : NSObject
+ (instancetype)sharedManage;
- (void)NetWorkTestShortWithData:(TestSucceedShortBlock) succeedBlock error:(ErrorBlock) errorBlock and:(NSString*) string;
- (void)NetWorkTestLongWithData:(TestSucceedLongBlock) succeedBlock error:(ErrorBlock) errorBlock and:(NSString*) string;


@end

NS_ASSUME_NONNULL_END
