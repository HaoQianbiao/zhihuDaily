//
//  CommentManager.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/6.
//

#import "CommentManager.h"
#import "ShortCommentModel.h"
#import "LongCommentModel.h"
static CommentManager* comment = nil;

@implementation CommentManager
+(instancetype)sharedManage {
    if (!comment) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            comment = [CommentManager new];
        });
    }
    return comment;
}
-(void)NetWorkTestShortWithData:(TestSucceedShortBlock)succeedBlock error:(ErrorBlock)errorBlock and:(NSString *)string {
    NSString *json = [NSString stringWithString:string];
    json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *testUrl = [NSURL URLWithString:json];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession *testSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            ShortCommentModel *country = [[ShortCommentModel alloc] initWithData:data error:nil];
            succeedBlock(country);
        } else {
            errorBlock(error);
        }
        }];

        [testDataTask resume];
}

-(void)NetWorkTestLongWithData:(TestSucceedLongBlock)succeedBlock error:(ErrorBlock)errorBlock and:(NSString *)string {
    NSString *json = [NSString stringWithString:string];
    json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *testUrl = [NSURL URLWithString:json];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession *testSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            LongCommentModel *country = [[LongCommentModel alloc] initWithData:data error:nil];
            succeedBlock(country);
        } else {
            errorBlock(error);
        }
        }];

        [testDataTask resume];
}
@end
