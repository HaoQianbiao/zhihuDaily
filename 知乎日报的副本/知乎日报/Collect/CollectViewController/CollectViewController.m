//
//  CollectViewController.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/10.
//

#import "CollectViewController.h"
#import "CollectView.h"
#import "FMDB.h"

#define W self.view.bounds.size.width
#define H self.view.bounds.size.height

@interface CollectViewController ()

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton* buttonBack = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:buttonBack];
    buttonBack.frame = CGRectMake(20, 50, 30, 30);
    buttonBack.tintColor = [UIColor blackColor];
    [buttonBack setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/fanhui.png"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
    UILabel* labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(W / 2 - 30, 50, 100, 30)];
    labelTitle.text = @"收藏";
    labelTitle.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:labelTitle];
    
    
    self.collectView = [[CollectView alloc] initWithFrame:CGRectMake(0, 80, W, H - 80)];
    [self.view addSubview:self.collectView];
    
    NSString* doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* fileName = [doc stringByAppendingPathComponent:@"collection.sqlite"];
    self.path = fileName;
    FMDatabase* database = [FMDatabase databaseWithPath:self.path];
    [self ergodicData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteData:) name:@"delete" object:nil];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [self ergodicData];
    [self.collectView.tableView reloadData];
}

//- (void)createDatabase {
//    FMDatabase* database = [FMDatabase databaseWithPath:self.path];
//    if ([database open]) {
//        BOOL result = [database executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collection(title text NOT NULL, imageURL text NOT NULL, webURL text NOT NULL, id text NOT NULL);"];
//        if (result) {
//            NSLog(@"数据库创建成功！\n");
//        } else {
//            NSLog(@"数据库创建失败！\n");
//        }
//        [database close];
//    }
//}

- (void)deleteData:(NSNotification *)text {
    int i = [text.userInfo[@"position"] intValue];
    FMDatabase* database = [FMDatabase databaseWithPath:self.path];
    if ([database open]) {
        NSString* sqlDelete = @"delete from t_collection WHERE imageURL = ?";
        BOOL result = [database executeUpdate:sqlDelete, self.collectView.imageArray[i]];
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

- (void)ergodicData {                                                          //遍历数据库
    self.collectView.imageArray = [[NSMutableArray alloc] init];
    self.collectView.titleArray = [[NSMutableArray alloc] init];
    self.collectView.URLArray = [[NSMutableArray alloc] init];
    self.collectView.idArray = [[NSMutableArray alloc] init];
    FMDatabase* database = [FMDatabase databaseWithPath:self.path];
    if([database open]) {
        FMResultSet *resultSet = [database executeQuery:@"SELECT * FROM t_collection"];
        while ([resultSet next]) {
            [self.collectView.imageArray insertObject:[resultSet stringForColumn:@"imageURL"] atIndex:0];
            [self.collectView.titleArray insertObject:[resultSet stringForColumn:@"title"] atIndex:0];
            [self.collectView.URLArray insertObject:[resultSet stringForColumn:@"webURL"] atIndex:0];
            [self.collectView.idArray insertObject:[resultSet stringForColumn:@"id"] atIndex:0];
        }
        [self.collectView.tableView reloadData];
        [database close];
    } else {
        NSLog(@"打开数据库失败！\n");
    }
}


- (void) pressBack {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
