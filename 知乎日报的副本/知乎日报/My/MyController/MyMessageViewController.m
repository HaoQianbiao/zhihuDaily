//
//  MyMessageViewController.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/5.
//

#import "MyMessageViewController.h"
#import "MyMessageView.h"
#import "Masonry.h"
#define H self.view.bounds.size.height
#define W self.view.bounds.size.width


@interface MyMessageViewController ()

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton* buttonBack = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:buttonBack];
    buttonBack.frame = CGRectMake(20, 50, 30, 30);
    buttonBack.tintColor = [UIColor blackColor];
    [buttonBack setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/fanhui.png"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
    
    MyMessageView* myMessageView = [[MyMessageView alloc] initWithFrame:CGRectMake(0, 80, W, H - 80)];
    [self.view addSubview:myMessageView];
}

- (void)pressBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
