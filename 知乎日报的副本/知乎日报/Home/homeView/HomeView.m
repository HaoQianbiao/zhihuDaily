//
//  homeView.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/18.
//

#import "HomeView.h"
#include "Masonry.h"
#import "HomeModel.h"
#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TopStoriesViewController.h"
#import "MyViewController.h"
#import "MyMessageViewController.h"

#define H self.bounds.size.height
#define W self.bounds.size.width

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    self.backgroundColor = [UIColor whiteColor];
    
    _Flag = 0;
    NSDate* date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSString *dateStr = [formatter stringFromDate:date];
    self.labelDateDay = [[UILabel alloc] init];
    [self addSubview:self.labelDateDay];
    [self.labelDateDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(50);
        make.left.equalTo(self).offset(10);
        make.width.equalTo(@(70));
        make.height.equalTo(@(30));
    }];
    self.labelDateDay.backgroundColor = [UIColor whiteColor];
    self.labelDateDay.font = [UIFont systemFontOfSize:30];
    self.labelDateDay.textAlignment = NSTextAlignmentCenter;
    NSString* dateDayStr = [dateStr substringWithRange:NSMakeRange(8, 2)];
    if ([dateDayStr characterAtIndex:0] == '0') {
        dateDayStr = [dateDayStr substringFromIndex:1];
    }
    self.labelDateDay.text = dateDayStr;

    
    
    self.labelDateMonth = [[UILabel alloc] init];
    [self addSubview:self.labelDateMonth];
    [self.labelDateMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(80);
        make.left.equalTo(self).offset(10);
        make.width.equalTo(@(70));
        make.height.equalTo(@(30));
    }];
    self.labelDateMonth.textAlignment = NSTextAlignmentCenter;
    self.labelDateMonth.backgroundColor = [UIColor whiteColor];
    NSString* stringMonth = [NSString stringWithFormat:@"%@", [dateStr substringWithRange:NSMakeRange(5, 2)]];
    int iValue = [stringMonth intValue];
    
    switch (iValue) {
        case 12:
            self.labelDateMonth.text = @"十二月";
            break;
        case 11:
            self.labelDateMonth.text = @"十一月";
            break;
        case 10:
            self.labelDateMonth.text = @"十月";
            break;
        case 9:
            self.labelDateMonth.text = @"九月";
            break;
        case 8:
            self.labelDateMonth.text = @"八月";
            break;
        case 7:
            self.labelDateMonth.text = @"七月";
            break;
        case 6:
            self.labelDateMonth.text = @"六月";
            break;
        case 5:
            self.labelDateMonth.text = @"五月";
            break;
        case 4:
            self.labelDateMonth.text = @"四月";
            break;
        case 3:
            self.labelDateMonth.text = @"三月";
            break;
        case 2:
            self.labelDateMonth.text = @"二月";
            break;
        case 1:
            self.labelDateMonth.text = @"一月";
            break;
        default:
            break;
    }
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/fengexian-3.png"]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(50);
            make.left.equalTo(self).offset(80);
            make.width.equalTo(@(30));
            make.height.equalTo(@(60));
    }];
    self.controller = [self viewController];
    
    UIButton* buttonHead = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:buttonHead];
    [buttonHead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(50);
            make.right.equalTo(self).offset(-20);
            make.width.mas_offset(60);
            make.height.mas_offset(60);
    }];
    buttonHead.layer.cornerRadius = 30;
    buttonHead.layer.masksToBounds = YES;
    [buttonHead setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/头像.jpg"] forState:UIControlStateNormal];
    [buttonHead addTarget:self action:@selector(touchHead) forControlEvents:UIControlEventTouchUpInside];
    
    self.labelTitle = [[UILabel alloc] init];
    [self addSubview:self.labelTitle];
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(50);
        make.left.equalTo(self).offset(110);
        make.width.equalTo(@(200));
        make.height.equalTo(@(60));
    }];
    self.labelTitle.backgroundColor = [UIColor whiteColor];
    self.labelTitle.font = [UIFont systemFontOfSize:27];
    self.labelTitle.text = @"知乎日报";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, W, H - 120) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tag = 101;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor blackColor];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"0"];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"1"];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"2"];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"3"];
    [self addSubview:_tableView];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, W, 400)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(W * 7, 400);
    [_scrollView setContentOffset:CGPointMake(W, 400) animated:NO];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.tag = 102;
    _seclect = 0;
    _dateArray = [[NSMutableArray alloc] init];
    [self setup];
    
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 6;
    } else if (section == 2) {
        return 7 * _Flag;
    } else {
        return 1;
    }
    
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 400;
    } else if (indexPath.section == 2 && indexPath.row % 7 == 0) {
        return 50;
    } else if (indexPath.section == 3){
        return 50;
    } else {
        return 150;
    }

}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HomeTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"0" forIndexPath:indexPath];
        [self addUI:cell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1){
        HomeTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"1" forIndexPath:indexPath];
        NSURL* url = [NSURL URLWithString:[self.testModel.StoriesImages objectAtIndex:indexPath.row]];
        [cell.storiesImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:nil]];
        cell.labelTitle.text = [self.testModel.StoriesTitle objectAtIndex:indexPath.row];
        cell.labelSubtitle.text = [self.testModel.StoriesHint objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    } else if (indexPath.section == 2) {
        if (indexPath.row % 7 == 0) {
            HomeTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"2" forIndexPath:indexPath];
            cell.label.text = [NSString stringWithFormat:@"%@", [_dateArray objectAtIndex:indexPath.row / 7]];
            return cell;
        } else {
            HomeTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"1" forIndexPath:indexPath];
            NSURL* url = [NSURL URLWithString:[self.testModel.StoriesImages objectAtIndex:indexPath.row + 5 - indexPath.row / 7]];
            
            [cell.storiesImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:nil]];

            cell.labelTitle.text = [self.testModel.StoriesTitle objectAtIndex:indexPath.row + 5 - indexPath.row / 7];
            cell.labelSubtitle.text = [self.testModel.StoriesHint objectAtIndex:indexPath.row + 5 - indexPath.row / 7];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else {
        HomeTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"3" forIndexPath:indexPath];
        _testActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        _testActivityIndicator.center = CGPointMake(W/2, 25);//只能设置中心，不能设置大小
        [cell addSubview:_testActivityIndicator];
        _testActivityIndicator.color = [UIColor grayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)addUI:(HomeTableViewCell*)cell {
    [cell addSubview:_scrollView];
    for (int i = 0; i < 7; i++) {
        NSString* imageString;
        NSString* stringTitle;
        NSString* stringAuthor;
        if (i == 0) {
            imageString = [self.testModel.Top_StoriesImage objectAtIndex:4];
            stringTitle = [NSString stringWithFormat:@"%@", [self.testModel.Top_StoriesTitle objectAtIndex:4]];
            stringAuthor = [NSString stringWithFormat:@"%@", [self.testModel.Top_StoriesHint objectAtIndex:4]];
        } else if (i == 6) {
            imageString = [self.testModel.Top_StoriesImage objectAtIndex:0];
            stringTitle = [NSString stringWithFormat:@"%@", [self.testModel.Top_StoriesTitle objectAtIndex:0]];
            stringAuthor = [NSString stringWithFormat:@"%@", [self.testModel.Top_StoriesHint objectAtIndex:0]];
        } else {
            
            imageString = [self.testModel.Top_StoriesImage objectAtIndex:i - 1];
            stringTitle = [NSString stringWithFormat:@"%@", [self.testModel.Top_StoriesTitle objectAtIndex:i - 1]];
            stringAuthor = [NSString stringWithFormat:@"%@", [self.testModel.Top_StoriesHint objectAtIndex:i - 1]];
        }
        NSURL* url = [NSURL URLWithString:imageString];
        UIImageView* imageView = [[UIImageView alloc] init];
        [_scrollView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollView).offset(0);
            make.left.equalTo(_scrollView).offset(W * i);
            make.width.equalTo(@(W));
            make.height.equalTo(@(400));
        }];
//        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
        CGRect frame = CGRectMake(0, W * i, W, 400);
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:nil]];
        
//        [imageView addSubview:[self imageDeal:frame and:imageView.image]];

        imageView.tag = 101 + i;
        imageView.userInteractionEnabled = YES;
        UIGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topClick:)];
        [imageView addGestureRecognizer:gesture];
        
        UILabel* labelTitle = [[UILabel alloc] init];
        labelTitle.text = stringTitle;
        labelTitle.numberOfLines = 0;
        labelTitle.lineBreakMode = NSLineBreakByWordWrapping;
        labelTitle.textColor = [UIColor whiteColor];
        labelTitle.font = [UIFont systemFontOfSize:27];
        [imageView addSubview:labelTitle];
        [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imageView).offset(-60);
            make.left.equalTo(imageView).offset(20);
            make.width.mas_equalTo(W - 20);
            make.height.mas_equalTo(100);
        }];
        UILabel* labelAuthor = [[UILabel alloc] init];
        labelAuthor.text = stringAuthor;
        labelAuthor.textColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        labelAuthor.font = [UIFont systemFontOfSize:20];
        [imageView addSubview:labelAuthor];
        [labelAuthor mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imageView).offset(-30);
            make.left.equalTo(imageView).offset(20);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(30);
        }];
    }
    //默认显示第二页，即第一张照片
    self.scrollView.contentOffset = CGPointMake(W, 0);
    
    
    //设置小圆点
    self.pageControl = [[UIPageControl alloc] init];
    [cell addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell).offset(-20);
            make.right.equalTo(cell).offset(70);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(20);
    }];
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.tag == 101 && decelerate == YES) {
        [self->_testActivityIndicator startAnimating];
        if ((scrollView.contentOffset.y + 780 >= scrollView.contentSize.height) && _seclect == 0) {
            _seclect = 1;
            [self testBefore];
        }
    }
}

- (void)autoPlay {
    int page = self.scrollView.contentOffset.x / W + 1;
    if (page == 6) {
        self.pageControl.currentPage = 0;
        self.scrollView.contentOffset = CGPointMake(W, 0);
    } else {
        self.pageControl.currentPage = page - 1;
        [self.scrollView setContentOffset:CGPointMake(page * W, 0) animated:YES] ;
    }
}

- (void) setup {
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

-(void) testBefore{
    _seclect = 0;
    _lastDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60*_Flag)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *dateStr = [formatter stringFromDate:_lastDate];
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60*(_Flag + 1))];
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
    [formatterDate setDateFormat:@"MM月dd日"];
    NSString* stringDate = [formatterDate stringFromDate:date];
    [_dateArray addObject:stringDate];
    _Flag++;
    
    NSString* urlString = [NSString stringWithFormat:@"http://news.at.zhihu.com/api/4/news/before/%@", dateStr];
    [[HomeModel sharedManage] NetWorkTestWithData:^(TestModel * _Nonnull mainViewNowModel) {
        for (int i = 0; i < 6; i++) {
            [self.testModel.StoriesTitle addObject:[mainViewNowModel.stories[i] title]];
            [self.testModel.StoriesHint addObject:[mainViewNowModel.stories[i] hint]];
            [self.testModel.StoriesUrl addObject:[mainViewNowModel.stories[i] url]];
            [self.testModel.StoriesImages addObject:[[mainViewNowModel.stories[i] images] objectAtIndex:0]];
            [self.testModel.StoriesID addObject:[mainViewNowModel.stories[i] id]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_testActivityIndicator stopAnimating];// 结束旋转
            [self.tableView reloadData];
            if ([self->_panduan isEqual:@"YES"]) {
                NSNotification *notification =[NSNotification notificationWithName:@"update" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
        });
        } error:^(NSError * _Nonnull error) {
            [self->_testActivityIndicator stopAnimating]; // 结束旋转
            NSLog(@"请求错误");
        } and:urlString];
}

- (void)topClick:(UIGestureRecognizer *)gesture {
    TopStoriesViewController* topViewController = [[TopStoriesViewController alloc] init];
    topViewController.urlTopStoriesArray = [self.testModel.Top_StoriesUrl copy];
    topViewController.idArray =  [self.testModel.Top_StoriesID copy];
    topViewController.flagTopStories = self.pageControl.currentPage;
    topViewController.titleArray = self.testModel.Top_StoriesTitle;
    topViewController.imageArray = self.testModel.Top_StoriesImage;
    topViewController.WebArray = self.testModel.Top_StoriesUrl;
    self.controller = [self viewController];
    [self.controller.navigationController pushViewController:topViewController animated:YES];
}
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 101) {
        MyViewController* myViewController = [[MyViewController alloc] init];
        myViewController.urlStoriesArray = self.testModel.StoriesUrl;
        myViewController.idArray = self.testModel.StoriesID;
        myViewController.titleArray = self.testModel.StoriesTitle;
        myViewController.imageArray = self.testModel.StoriesImages;
        myViewController.WebArray = self.testModel.StoriesUrl;
        if (indexPath.section == 2 && indexPath.row % 7 != 0) {
            myViewController.flagStories = indexPath.row + 5 - indexPath.row / 7;
            self.controller = [self viewController];
            [self.controller.navigationController pushViewController:myViewController animated:YES];
        }
        if (indexPath.section == 1) {
            myViewController.flagStories = indexPath.row;
            self.controller = [self viewController];
            [self.controller.navigationController pushViewController:myViewController animated:YES];
        }
    }
}


- (void) touchHead {
    MyMessageViewController* myMessage = [[MyMessageViewController alloc] init];
    self.controller = [self viewController];
    [self.controller.navigationController pushViewController:myMessage animated:YES];
}


- (UIView*)imageDeal:(CGRect)frame and:(UIImage*)image {
    UIView *colorView = [[UIView alloc] init];
    colorView.frame = frame;

    UIColor *colorOne = [[[self class] mostColor:image] colorWithAlphaComponent:1.0];
    UIColor *colorTwo = [[[self class] mostColor:image] colorWithAlphaComponent:0.0];

    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(0, 0);
    gradient.colors = colors;
    gradient.frame = CGRectMake(0, 0, 390, 150);
    [colorView.layer insertSublayer:gradient atIndex:0];
    return colorView;
}
+ (UIColor *)mostColor:(UIImage*)image {
    
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    
    //缩小图片，加快计算速度
    CGSize thumbSize = CGSizeMake(image.size.width/20, image.size.height/20);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, thumbSize.width, thumbSize.height, 8, thumbSize.width * 4, colorSpace,bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //统计每个点的像素值
    unsigned char *data = CGBitmapContextGetData(context);
    if (data == NULL) {
        return nil;
    }
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];
    
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = image.size.height / 30; y < thumbSize.height; y++) {
            int offset = 4 * (x * y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha = data[offset+3];
            //去除透明
            if (alpha > 0) {
                //去除白色
                if (red >= 180 || green >= 180 || blue >= 180) {
                    
                } else {
                    NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
                    [cls addObject:clr];
                }
            }
        }
    }
    CGContextRelease(context);
    //找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) {
            continue;
        }
        MaxCount = tmpCount;
        MaxColor = curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}




-(UIImage *) getImageFromURL:(NSString *)fileURL {

   UIImage * result;

   NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];

   result = [UIImage imageWithData:data];

   return result;

}


@end
