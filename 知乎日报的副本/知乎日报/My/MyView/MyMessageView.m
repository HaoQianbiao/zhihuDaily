//
//  MyMessageView.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/5.
//

#import "MyMessageView.h"
#import "Masonry.h"
#import "MyTableViewCell.h"
#import "CollectViewController.h"
#define H self.bounds.size.height
#define W self.bounds.size.width
@implementation MyMessageView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, W, H) style:UITableViewStylePlain];
    [self addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"0"];
    [_tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"1"];
    [_tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"2"];
    return self;
    
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 250;
    } else if (indexPath.section == 1){
        return 80;
    } else {
        return H - 410;
    }
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        MyTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"0"];
        return cell;
    } else if (indexPath.section == 1){
        MyTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"1"];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的收藏";
        } else {
            cell.textLabel.text = @"消息中心";
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, W);
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        MyTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"2"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 1) {
        CollectViewController* collect = [[CollectViewController alloc] init];
        self.controller = [self viewController];
        [self.controller.navigationController pushViewController:collect animated:YES];
        
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
