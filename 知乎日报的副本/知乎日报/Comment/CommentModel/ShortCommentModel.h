//
//  ShortCommentModel.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/9.
//
@protocol ShortCommentContent
@end
@protocol ShortCommentReply
@end
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShortCommentReply : JSONModel
@property (nonatomic, copy) NSString* author;
@property (nonatomic, copy) NSString* content;
@end
@interface ShortCommentContent : JSONModel
@property (nonatomic, copy) NSString* avatar;
@property (nonatomic, copy) NSString* author;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* time;
@property (nonatomic, copy) NSString* likes;
@property (nonatomic, copy) ShortCommentReply* reply_to;
@end


@interface ShortCommentModel : JSONModel

@property(nonatomic, strong) NSArray<ShortCommentContent>* comments;
@end

NS_ASSUME_NONNULL_END
