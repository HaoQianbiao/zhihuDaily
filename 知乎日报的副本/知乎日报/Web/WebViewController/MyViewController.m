//
//  MyViewController.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/24.
//

#import "MyViewController.h"
#import <Webkit/Webkit.h>
#import "StoriesView.h"
#import "Manager.h"
#import "StoriesCommentViewController.h"

#define W self.view.bounds.size.width
#define H self.view.bounds.size.height

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update)name:@"update" object:nil];

    NSString* doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* fileName = [doc stringByAppendingPathComponent:@"collection.sqlite"];
    
    self.path = fileName;
    FMDatabase* database = [FMDatabase databaseWithPath:self.path];
    self.database = database;
    if([self.database open]) {
        BOOL result = [self.database executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collection(title text NOT NULL, imageURL text NOT NULL, webURL text NOT NULL, id text NOT NULL);"];
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
    NSInteger length = [_urlStoriesArray count];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, W, H)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(W * length, 0);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    self.scrollView.contentOffset = CGPointMake(W * _flagStories, 0);
    self.storiesView = [[StoriesView alloc] initWithFrame:CGRectMake(0, H - 80, W, 80)];
    [self.storiesView.buttonBack addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
    [self.storiesView.buttonComment addTarget:self action:@selector(pressJump) forControlEvents:UIControlEventTouchUpInside];
    [self.storiesView.buttonCollect addTarget:self action:@selector(pressCollect:) forControlEvents:UIControlEventTouchUpInside];
    [self.storiesView.buttonLike addTarget:self action:@selector(pressLike:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_storiesView];
    
    [self.scrollView addSubview:[self addWeb:_flagStories]];
    
    [self getCommentAndLike:_flagStories];
    _select = 1;
}

- (WKWebView*)addWeb:(NSInteger) i {
    WKWebView* wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(W*i, 15, W, H - 140)];
    NSURL* url = [NSURL URLWithString:self.urlStoriesArray[i]];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [wkWebView loadRequest:request];
    _select = 0;
    return wkWebView;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / W;
    if ((scrollView.contentOffset.x > W * page) && _select == 1) {
        self.wkWebView = [self addWeb:page + 1];
    } else {
        self.wkWebView = [self addWeb:page];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / W;
    if (scrollView.contentOffset.x == W * ([_urlStoriesArray count] - 1)) {
        //发送通知回传数据，回传的数据格式自定义，这里定义为dictionary类型
        _flag = @"YES";
        NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.flag,@"flag", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TransDataNoti" object:nil userInfo:dict];
    }
    self.storiesView.buttonCollect.selected = NO;
    [self.storiesView.buttonCollect setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/collect.png"] forState:UIControlStateNormal];
    [self ergodicData];
    [self.scrollView addSubview:self.wkWebView];
    
    [self getCommentAndLike:page];
    _select = 1;

}

- (void) update{
    NSInteger length = [_urlStoriesArray count];
    self.scrollView.contentSize = CGSizeMake(W * length, 0);
}

- (void)getCommentAndLike:(NSInteger)i {
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
    StoriesCommentViewController* storiesCommentViewController = [[StoriesCommentViewController alloc] init];
    storiesCommentViewController.stringLongComment = longCommentString;
    storiesCommentViewController.stringNumber = [NSString stringWithFormat:@"%@ 条评论",self.numberComment];
    storiesCommentViewController.stringShortComment = shortCommentString;
    [self.navigationController pushViewController:storiesCommentViewController animated:YES];
}


- (void) pressCollect:(UIButton*)button {
    NSInteger i = self.scrollView.contentOffset.x / W;
    if (button.selected == NO) {
        [button setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/shoucang.png"] forState:UIControlStateNormal];
        [self insertData:i];
        button.selected = YES;
    } else {
        [button setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/collect.png"] forState:UIControlStateNormal];
        button.tintColor = [UIColor blackColor];
        button.selected = NO;
        [self deleteData:i];
    }
}

- (void) insertData:(NSInteger)i {
    FMDatabase* database = [FMDatabase databaseWithPath:self.path];
    if ([database open]) {
        BOOL result = [database executeUpdate:@"INSERT INTO t_collection(title, imageURL, webURL, id) VALUES (?,?,?,?);",self.titleArray[i], self.imageArray[i], self.WebArray[i], self.idArray[i]];
        if (!result) {
            NSLog(@"增加数据失败！\n");
        } else {
            NSLog(@"增加数据成功！\n");
        }
        [database close];
    } else {
        NSLog(@"打开数据库失败！\n");
    }
}

- (void) deleteData:(NSInteger)i {
    FMDatabase* database = [FMDatabase databaseWithPath:self.path];
    if ([database open]) {
        NSString* sqlDelete = @"delete from t_collection WHERE imageURL = ?";
        BOOL result = [database executeUpdate:sqlDelete, self.imageArray[i]];
        if (!result) {
            NSLog(@"删除数据失败！\n");
        } else {
            NSLog(@"删除数据成功！\n");
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



- (void)pressBack {
    [self.navigationController popViewControllerAnimated:YES];
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
