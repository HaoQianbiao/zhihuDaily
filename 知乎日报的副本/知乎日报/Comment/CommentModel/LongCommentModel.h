//
//  LongCommentModel.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/9.
//
@protocol LongCommentContent
@end
@protocol LongCommentReply
@end
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LongCommentReply : JSONModel
@property (nonatomic, copy) NSString* author;
@property (nonatomic, copy) NSString* content;
@end

@interface LongCommentContent: JSONModel
@property (nonatomic, copy) NSString* avatar;
@property (nonatomic, copy) NSString* author;
@property (nonatomic, copy) NSString* time;
@property (nonatomic, copy) NSString* likes;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) LongCommentReply* reply_to;
@end



@interface LongCommentModel : JSONModel
@property(nonatomic, strong) NSArray<LongCommentContent>* comments;
@end

NS_ASSUME_NONNULL_END
