//
//  ShortCommentModel.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/9.
//

#import "ShortCommentModel.h"

@implementation ShortCommentModel
+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation ShortCommentContent
+(BOOL) propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end


@implementation ShortCommentReply
+(BOOL) propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end


