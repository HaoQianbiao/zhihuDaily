//
//  WebMessageModel.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/6.
//


#import "JSONModel.h"


@interface WebMessageModel : JSONModel
@property(nonatomic, strong)NSString* long_comments;
@property(nonatomic, strong)NSString* popularity;
@property(nonatomic, strong)NSString* short_comments;
@property(nonatomic, strong)NSString* comments;
@end



