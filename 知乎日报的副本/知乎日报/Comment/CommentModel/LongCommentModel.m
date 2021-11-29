//
//  LongCommentModel.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/9.
//

#import "LongCommentModel.h"

@implementation LongCommentModel
+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation LongCommentReply
+(BOOL) propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation LongCommentContent
+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
