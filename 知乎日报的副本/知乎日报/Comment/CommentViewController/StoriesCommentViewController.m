//
//  StoriesCommentViewController.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/8.
//

#import "StoriesCommentViewController.h"
#import "CommentManager.h"

#define H self.view.bounds.size.height
#define W self.view.bounds.size.width
@interface StoriesCommentViewController ()

@end

@implementation StoriesCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.commentView = [[CommentView alloc] initWithFrame:CGRectMake(0, 0, W, H)];
    [self.view addSubview:self.commentView];
    self.commentView.buttonState = [[NSMutableArray alloc] init];

    [self getCommentLong];
    [self getCommentShort];
    self.commentView.labelTitle.text = self.stringNumber;
    [self.commentView.buttonBack addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];


}
- (void)pressBack{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getCommentLong {
    self.commentView.longAuthorArray = [[NSMutableArray alloc] init];
    self.commentView.longAvatarArray = [[NSMutableArray alloc] init];
    self.commentView.longContentArray = [[NSMutableArray alloc] init];
    self.commentView.longTimeArray = [[NSMutableArray alloc] init];
    self.commentView.longReply_Author = [[NSMutableArray alloc] init];
    self.commentView.longReply_content = [[NSMutableArray alloc] init];
    [[CommentManager sharedManage] NetWorkTestLongWithData:^(LongCommentModel * _Nonnull mainViewNowModel) {
            NSLog(@"-------长评论数获取成功-------");
        for (int i = 0; i < [mainViewNowModel.comments count]; i++) {
            [self.commentView.longAuthorArray addObject:[mainViewNowModel.comments[i] author]];
            [self.commentView.longAvatarArray addObject:[mainViewNowModel.comments[i] avatar]];
            [self.commentView.longTimeArray addObject:[mainViewNowModel.comments[i] time]];
            [self.commentView.longContentArray addObject:[mainViewNowModel.comments[i] content]];
            [self.commentView.longLikesArray addObject:[mainViewNowModel.comments[i] likes]];
            [self.commentView.buttonState addObject:@"0"];
            if([mainViewNowModel.comments[i] reply_to] != nil) {
                if ([[mainViewNowModel.comments[i] reply_to] author] != nil) {
                    [self.commentView.shortReply_Author addObject:[[mainViewNowModel.comments[i] reply_to] author]];
                    [self.commentView.shortReply_content addObject:[[mainViewNowModel.comments[i] reply_to] content]];
                } else {
                    [self.commentView.shortReply_Author addObject:@"delete"];
                    [self.commentView.shortReply_content addObject:@"delete"];
                }
            } else {
                [self.commentView.longReply_Author addObject:@"Empty"];
                [self.commentView.longReply_content addObject:@"Empty"];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:@"YES",@"textLong", nil];
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"tongzhiTwo" object:nil userInfo:dict];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        });
        } error:^(NSError * _Nonnull error) {
            NSLog(@"长评论数获取失败");
        } and:self.stringLongComment];
}


- (void)getCommentShort {
    self.commentView.shortAuthorArray = [[NSMutableArray alloc] init];
    self.commentView.shortAvatarArray = [[NSMutableArray alloc] init];
    self.commentView.shortContentArray = [[NSMutableArray alloc] init];
    self.commentView.shortTimeArray = [[NSMutableArray alloc] init];
    self.commentView.shortReply_Author = [[NSMutableArray alloc] init];
    self.commentView.shortReply_content = [[NSMutableArray alloc] init];
    [[CommentManager sharedManage] NetWorkTestShortWithData:^(ShortCommentModel * _Nonnull mainViewNowModel) {
            NSLog(@"-------短评论数获取成功-------");
        for (int i = 0; i < [mainViewNowModel.comments count]; i++) {
            [self.commentView.shortAuthorArray addObject:[mainViewNowModel.comments[i] author]];
            [self.commentView.shortAvatarArray addObject:[mainViewNowModel.comments[i] avatar]];
            [self.commentView.shortTimeArray addObject:[mainViewNowModel.comments[i] time]];
            [self.commentView.shortContentArray addObject:[mainViewNowModel.comments[i] content]];
            [self.commentView.shortLikesArray addObject:[mainViewNowModel.comments[i] likes]];
            [self.commentView.buttonState addObject:@"0"];
            if([[mainViewNowModel.comments[i] reply_to] author] != nil) {
                if ([[mainViewNowModel.comments[i] reply_to] author] != nil) {
                    [self.commentView.shortReply_Author addObject:[[mainViewNowModel.comments[i] reply_to] author]];
                    [self.commentView.shortReply_content addObject:[[mainViewNowModel.comments[i] reply_to] content]];
                } else {
                    [self.commentView.shortReply_Author addObject:@"delete"];
                    [self.commentView.shortReply_content addObject:@"delete"];
                }
            } else {
                [self.commentView.shortReply_Author addObject:@"Empty"];
                [self.commentView.shortReply_content addObject:@"Empty"];
            }

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //添加 字典，将label的值通过key值设置传递
            NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:@"YES",@"textShort", nil];
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"tongzhiOne" object:nil userInfo:dict];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];

        });
        
        } error:^(NSError * _Nonnull error) {
            NSLog(@"段评论数获取失败");
        } and:self.stringShortComment];
}
@end
