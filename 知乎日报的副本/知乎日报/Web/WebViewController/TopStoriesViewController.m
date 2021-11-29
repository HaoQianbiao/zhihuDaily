//
//  TopStoriesViewController.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/31.
//

#import "TopStoriesViewController.h"
#import <WebKit/WebKit.h>
#import "StoriesView.h"
#import "Manager.h"
#import "TopCommentViewController.h"
#import "FMDB.h"
#define W self.view.bounds.size.width
#define H self.view.bounds.size.height

@interface TopStoriesViewController ()

@end

@implementation TopStoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
    [self addUI];
    _storiesView = [[StoriesView alloc] initWithFrame:CGRectMake(0, H - 80, W, 80)];
    [self.view addSubview:_storiesView];
    [_storiesView.buttonBack addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
    [self.storiesView.buttonComment addTarget:self action:@selector(pressJump) forControlEvents:UIControlEventTouchUpInside];
    [self.storiesView.buttonCollect addTarget:self action:@selector(pressCollect:) forControlEvents:UIControlEventTouchUpInside];
    [self.storiesView.buttonLike addTarget:self action:@selector(pressLike:) forControlEvents:UIControlEventTouchUpInside];
    self.scrollView.contentOffset = CGPointMake(W * _flagTopStories, 0);
    
    NSString* doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* fileName = [doc stringByAppendingPathComponent:@"collection.sqlite"];
    
    self.path = fileName;
    FMDatabase* database = [FMDatabase databaseWithPath:self.path];
    self.database = database;
    if([self.database open]) {
        BOOL result = [self.database executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collection (title text NOT NULL, imageURL text NOT NULL, webURL text NOT NULL, id text NOT NULL);"];
        if (!result) {
            NSLog(@"创建失败!");
        } else {
            NSLog(@"创建成功!");
        }
    } else {
        NSLog(@"打开失败");
    }
    [self ergodicData];
}
- (void)addUI {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, W, H)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(W * 5, 0);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    for(int i = 0; i < 5; i++) {
        WKWebView* wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(W*i, 20, W, H - 20)];
        [self.scrollView addSubview:wkWebView];
        NSURL* url = [NSURL URLWithString:self.urlTopStoriesArray[i]];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [wkWebView loadRequest:request];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / W;
    CGFloat offsetX = scrollView.contentOffset.x + W * 0.5;
    if (offsetX / W > page) {
        self.storiesView.buttonCollect.selected = NO;
        [self.storiesView.buttonCollect setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/collect.png"] forState:UIControlStateNormal];
        [self ergodicData];
        [self getCommentAndLike:page];
    }
}
- (void)pressBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getCommentAndLike:(int) i {
    NSString* string = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story-extra/%@",self.idArray[i]];
    [[Manager sharedManage] NetWorkTestWithData:^(WebMessageModel * _Nonnull mainViewNowModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_storiesView.labelComment.text = mainViewNowModel.comments;
            self->_storiesView.labelLike.text = mainViewNowModel.popularity;
            self.numberComment = mainViewNowModel.comments;
        });
    } error:^(NSError * _Nonnull error) {
        NSLog(@"评论和喜欢数目请求失败！");
    } and:string];
}

- (void)pressJump{
    int page = self.scrollView.contentOffset.x / W ;
    NSString* longCommentString = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/long-comments", [self.idArray objectAtIndex:page]];
    NSString* shortCommentString = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/short-comments", [self.idArray objectAtIndex:page]];
    TopCommentViewController* topCommentViewController = [[TopCommentViewController alloc] init];
    topCommentViewController.stringLongComment = longCommentString;
    topCommentViewController.stringNumber = [NSString stringWithFormat:@"%@ 条评论",self.numberComment];
    topCommentViewController.stringShortComment = shortCommentString;
    [self.navigationController pushViewController:topCommentViewController animated:YES];
}

- (void) pressCollect:(UIButton*)button {
    NSInteger i = self.scrollView.contentOffset.x / W;
    if (button.selected == NO) {
        [button setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/shoucang.png"] forState:UIControlStateNormal];
        [self insertData:i];
        button.selected = YES;
    } else {
        [button setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/collect.png"] forState:UIControlStateNormal];
        button.selected = NO;
        [self deleteData:i];
    }
}

- (void) insertData:(NSInteger)i {
    FMDatabase* database = [FMDatabase databaseWithPath:self.path];
    if ([database open]) {
        BOOL result = [database executeUpdate:@"INSERT INTO t_collection(title, imageURL, webURL, id) VALUES (?,?,?, ?);",self.titleArray[i], self.imageArray[i], self.WebArray[i], self.idArray[i]];
        if (!result) {
            NSLog(@"增加数据失败！\n");
            
        } else {
            NSLog(@"增加数据成功！\n");
            [self ergodicData];
        }
        [database close];
    } else {
        NSLog(@"打开数据库失败！\n");
    }
}

- (void)deleteData:(NSInteger)i {
    FMDatabase* database = [FMDatabase databaseWithPath:self.path];
    if ([database open]) {
        NSString* sqlDelete = @"delete from t_collection WHERE imageURL = ?";
        BOOL result = [database executeUpdate:sqlDelete, self.imageArray[i]];
        if (!result) {
            NSLog(@"删除数据失败！\n");
        } else {
            NSLog(@"删除数据成功！\n");
            [self ergodicData];
        }
        [database close];
    } else {
        NSLog(@"打开数据库失败！\n");
    }
}
- (void)ergodicData { //遍历数据库
    NSInteger page = self.scrollView.contentOffset.x / W;
    FMDatabase* database = [FMDatabase databaseWithPath:self.path];
    if([database open]) {
        FMResultSet *resultSet = [database executeQuery:@"SELECT * FROM t_collection"];
        while ([resultSet next]) {
            if([[resultSet stringForColumn:@"title"] isEqualToString:self.titleArray[page]]) {
                [self.storiesView.buttonCollect setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/shoucang.png"] forState:UIControlStateNormal];
                self.storiesView.buttonCollect.selected = YES;
            }
        }
        [database close];
    } else {
        NSLog(@"打开数据库失败！\n");
    }
}

- (void)pressLike:(UIButton*)button {
    if (button.selected == NO) {
        NSString* stringLike = self.storiesView.labelLike.text;
        int numberLike = [stringLike intValue];
        numberLike++;
        stringLike = [NSString stringWithFormat:@"%d", numberLike];
        self.storiesView.labelLike.text = stringLike;
        button.selected = YES;
        [button setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/dianzan.png"] forState:UIControlStateNormal];
        
    } else {
        NSString* stringLike = self.storiesView.labelLike.text;
        int numberLike = [stringLike intValue];
        numberLike--;
        stringLike = [NSString stringWithFormat:@"%d", numberLike];
        self.storiesView.labelLike.text = stringLike;
        button.selected = NO;
        [button setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/zan.png"] forState:UIControlStateNormal];
    }
}
@end
