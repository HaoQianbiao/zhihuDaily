//
//  Manager.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/6.
//

#import "Manager.h"

static Manager* manager = nil;
@implementation Manager
+ (instancetype)sharedManage {
    if (!manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [Manager new];
        });
    }
    return manager;
}

-(void)NetWorkTestWithData:(TestSucceedBlock)succeedBlock error:(ErrorBlock)errorBlock and:(nonnull NSString *)string{
    NSString *json = [NSString stringWithString:string];
    json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *testUrl = [NSURL URLWithString:json];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession *testSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            WebMessageModel *country = [[WebMessageModel alloc] initWithData:data error:nil];
            succeedBlock(country);
        } else {
            errorBlock(error);
        }
        }];
        [testDataTask resume];
}
@end
