//
//  homeViewController.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/18.
//

#import "homeViewController.h"
#import "HomeModel.h"
#import "TestModel.h"
#import "HomeView.h"
#import "Masonry.h"
#define H self.view.bounds.size.height
#define W self.view.bounds.size.width

@interface homeViewController ()

@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self testLatest];
    self->_homeView = [[HomeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:self->_homeView];
    self.homeView.scrollView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyHandle:)name:@"TransDataNoti" object:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 102) {
        if (scrollView.contentOffset.x == W * 6) {
            [scrollView setContentOffset:CGPointMake(W, 0) animated:NO] ;
        }
        if (scrollView.contentOffset.x == 0) {
            [scrollView setContentOffset:CGPointMake(W * 5, 0) animated:NO] ;
        }
        CGFloat offSetX = scrollView.contentOffset.x + W * 0.5;
        int page = offSetX / W;
        if (page == 6) {
            self.homeView.pageControl.currentPage = 0;
        } else if (page == 0) {
            self.homeView.pageControl.currentPage = 4;
        } else {
            self.homeView.pageControl.currentPage = page - 1;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(scrollView.tag == 102) {
        [self.homeView.timer invalidate];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.tag == 102) {
        [self.homeView setup];
    }
    
}
- (void)testLatest {
    [[HomeModel sharedManage] NetWorkTestWithData:^(TestModel * _Nonnull mainViewNowModel) {
        
        self.homeView.testModel = [[TestModel alloc] init];
        self.homeView.testModel.Top_StoriesTitle = [[NSMutableArray alloc] init];
        self.homeView.testModel.Top_StoriesHint = [[NSMutableArray alloc] init];
        self.homeView.testModel.Top_StoriesUrl = [[NSMutableArray alloc] init];
        self.homeView.testModel.Top_StoriesImage = [[NSMutableArray alloc] init];
        self.homeView.testModel.Top_StoriesID = [[NSMutableArray alloc] init];

        self.homeView.testModel.StoriesTitle = [[NSMutableArray alloc] init];
        self.homeView.testModel.StoriesHint = [[NSMutableArray alloc] init];
        self.homeView.testModel.StoriesUrl = [[NSMutableArray alloc] init];
        self.homeView.testModel.StoriesImages = [[NSMutableArray alloc] init];
        self.homeView.testModel.StoriesID = [[NSMutableArray alloc] init];


        for (int i = 0; i < [mainViewNowModel.top_stories count]; i++) {
            [self.homeView.testModel.Top_StoriesTitle addObject:[mainViewNowModel.top_stories[i] title]];
            [self.homeView.testModel.Top_StoriesHint addObject:[mainViewNowModel.top_stories[i] hint]];
            [self.homeView.testModel.Top_StoriesUrl addObject:[mainViewNowModel.top_stories[i] url]];
            [self.homeView.testModel.Top_StoriesImage addObject:[mainViewNowModel.top_stories[i] image]];
            [self.homeView.testModel.Top_StoriesID addObject:[mainViewNowModel.top_stories[i] id]];
        }

        for (int i = 0; i < [mainViewNowModel.stories count]; i++) {
            [self.homeView.testModel.StoriesTitle addObject:[mainViewNowModel.stories[i] title]];
            [self.homeView.testModel.StoriesHint addObject:[mainViewNowModel.stories[i] hint]];
            [self.homeView.testModel.StoriesUrl addObject:[mainViewNowModel.stories[i] url]];
            [self.homeView.testModel.StoriesImages addObject:[[mainViewNowModel.stories[i] images] objectAtIndex:0]];
            [self.homeView.testModel.StoriesID addObject:[mainViewNowModel.stories[i] id]];
        }
        
        self.homeView.testModel.date = [NSString stringWithFormat:@"%@", mainViewNowModel.date];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeView.tableView reloadData];
        });

        } error:^(NSError * _Nonnull error) {
            NSLog(@"请求错误");
        } and:@"https://news-at.zhihu.com/api/4/news/latest"];
}

- (void)notifyHandle:(NSNotification*)panduan {
    [self.homeView testBefore];
    self.homeView.panduan = panduan.userInfo[@"flag"];
}








@end
