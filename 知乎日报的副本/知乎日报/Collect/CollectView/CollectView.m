//
//  CollectView.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/12.
//

#import "CollectView.h"
#import "CollectTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MyViewController.h"
#define W self.bounds.size.width
#define H self.bounds.size.height

@implementation CollectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, W, H) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CollectTableViewCell class] forCellReuseIdentifier:@"collect"];
    [self.tableView registerClass:[CollectTableViewCell class] forCellReuseIdentifier:@"Empty"];
    [self.tableView registerClass:[CollectTableViewCell class] forCellReuseIdentifier:@"Last"];
    [self addSubview:self.tableView];
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.URLArray count] == 0) {
        return H;
    } else {
        if (indexPath.section == 0) {
            return 100;
        } else {
            return H - [self.URLArray count] * 100;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.URLArray count] == 0) {
        return 1;
    } else {
        return 2;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.URLArray count] == 0) {
        return 1;
    } else {
        if (section == 0) {
            return [self.URLArray count];
        } else {
            return 1;
        }
    }
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if ([self.URLArray count] == 0) {
        CollectTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Empty"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        if (indexPath.section == 0) {
            CollectTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"collect"];
            cell.label.text = [self.titleArray objectAtIndex:indexPath.row];
            [cell.collectImageView sd_setImageWithURL:[self.imageArray objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:nil]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            CollectTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Last"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.URLArray count] != 0 && indexPath.section == 0) {
        return YES;
    } else {
        return NO;
    }
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* string = [NSString stringWithFormat:@"%ld",indexPath.row];
    //添加 字典，将label的值通过key值设置传递
    NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:string,@"text", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"delete" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.URLArray count] != 0 && indexPath.section == 0) {
        MyViewController* myViewController = [[MyViewController alloc] init];
        myViewController.urlStoriesArray = self.URLArray;
        myViewController.titleArray = self.titleArray;
        myViewController.imageArray = self.imageArray;
        myViewController.idArray = self.idArray;
        self.controller = [self viewController];
        myViewController.flagStories = indexPath.row;
        [self.controller.navigationController pushViewController:myViewController animated:YES];
    }
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


@end
