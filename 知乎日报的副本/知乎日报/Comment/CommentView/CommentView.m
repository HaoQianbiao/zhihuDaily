//
//  CommentView.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/6.
//

#import "CommentView.h"
#import "CommentTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "TopLeftLabel.h"
#define H self.bounds.size.height
#define W self.bounds.size.width
@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    
    
    self = [super initWithFrame:frame];
    
    
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(W / 2 - 50, 50, 100, 30)];
    [self addSubview:_labelTitle];
    _labelTitle.font = [UIFont systemFontOfSize:20];
    
    _buttonBack = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:_buttonBack];
    _buttonBack.frame = CGRectMake(20, 50, 30, 30);
    _buttonBack.tintColor = [UIColor blackColor];
    [_buttonBack setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test/知乎日报/素材/fanhui.png"] forState:UIControlStateNormal];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, W, H - 90) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"LongCommentTitle"];
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"LongCommentContent"];
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"ShortCommentTitle"];
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"ShortCommentContent"];
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"Empty"];
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"Last"];

    [self addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSelectShort:)name:@"tongzhiOne" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSelectLong:)name:@"tongzhiTwo" object:nil];
   
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.longContentArray count] == 0 && [self.shortContentArray count] == 0) {
        return 1;
    } else {
        if ([self.longContentArray count] != 0 && [self.shortContentArray count] != 0) {
            return 5;
        } else {
            return 3;
        }
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.longContentArray count] == 0 && [self.shortContentArray count] == 0) {
        return 1;
    } else {
        if ([self.longContentArray count] != 0 && [self.shortContentArray count] != 0) {
            if (section == 0 || section == 2 || section == 4) {
                return 1;
            } else if (section == 1) {
                return [self.longContentArray count];
            } else {
                return [self.shortContentArray count];
            }
        } else {
            if (section == 0 || section == 2) {
                return 1;
            } else {
                if ([self.longContentArray count] != 0) {
                    return [self.longContentArray count];
                } else {
                    return [self.shortContentArray count];
                }
            }
        }
    }
}

       

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.longContentArray count] == 0 && [self.shortContentArray count] == 0) {
        CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Empty"];
        return cell;
    } else if ([self.longContentArray count] != 0 && [self.shortContentArray count] == 0) {
        if (indexPath.section == 0) {
            CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"LongCommentTitle"];
            NSString* longContentNumber = [NSString stringWithFormat:@"%lu条长评", (unsigned long)[self.longContentArray count]];
            cell.labelLongCommentTitle.text = longContentNumber;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, W);
            return cell;
        } else if (indexPath.section == 2) {
            CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Last"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"LongCommentContent"];
            [cell.buttonFold addTarget:self action:@selector(pressOpenClose:) forControlEvents:UIControlEventTouchUpInside];

            cell.labelName.text = [self.longAuthorArray objectAtIndex:indexPath.row];
            cell.labelContent.text = [self.longContentArray objectAtIndex:indexPath.row];
            UIImageView* imageView = [[UIImageView alloc] init];
            [cell addSubview:imageView];

            [cell.CommentImageView sd_setImageWithURL:[self.longAvatarArray objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:nil]];
            cell.labelDate.text = [self dateWork:[self.longTimeArray objectAtIndex:indexPath.row]];
            
            if([[self.longReplyArray objectAtIndex:indexPath.row] isEqualToString:@"Empty"]) {
                cell.labelReply.text = @"";
            } else {
                cell.labelReply.text = [self.longReplyArray objectAtIndex:indexPath.row];
            }
            cell.buttonFold.tag = indexPath.row + 101;
            NSInteger count = [self getWidth:W - 90 title:[self.longReplyArray objectAtIndex:indexPath.row] font:[UIFont systemFontOfSize:15]] / cell.labelReply.font.lineHeight;
            if (count > 2) {
                cell.buttonFold.hidden = NO;
            } else {
                cell.buttonFold.hidden = YES;
            }
            cell.buttonFold.selected = [[self.buttonState objectAtIndex:indexPath.row] intValue];
            if (cell.buttonFold.selected == NO) {
                cell.labelReply.numberOfLines = 2;
            } else {
                cell.labelReply.numberOfLines = 0;
            }
            return cell;
        }
    } else if ([self.longContentArray count] == 0 && [self.shortContentArray count] != 0) {
        if (indexPath.section == 0) {
            CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ShortCommentTitle"];
            NSString* shortContentNumber = [NSString stringWithFormat:@"%lu条短评", (unsigned long)[self.shortContentArray count]];

            cell.labelShortCommentTitle.text = shortContentNumber;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, W);
            return cell;
        } else if (indexPath.section == 2) {
            CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Last"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ShortCommentContent"];
            [cell.buttonFold addTarget:self action:@selector(pressOpenClose:) forControlEvents:UIControlEventTouchUpInside];

            cell.labelName.text = [self.shortAuthorArray objectAtIndex:indexPath.row];
            cell.labelContent.text = [self.shortContentArray objectAtIndex:indexPath.row];
           
            [cell.CommentImageView sd_setImageWithURL:[self.shortAvatarArray objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:nil]];
            
            cell.labelDate.text = [self dateWork:[self.shortTimeArray objectAtIndex:indexPath.row]];
            if([[self.shortReplyArray objectAtIndex:indexPath.row] isEqualToString:@"Empty"]) {
                cell.labelReply.text = @"";
            } else {
                cell.labelReply.text = [self.shortReplyArray objectAtIndex:indexPath.row];
            }
            cell.buttonFold.tag = indexPath.row + 101;
            NSInteger count = [self getWidth:W - 100 title:[self.shortReplyArray objectAtIndex:indexPath.row] font:[UIFont systemFontOfSize:15]] / cell.labelReply.font.lineHeight;
            if (count > 2) {
                cell.buttonFold.hidden = NO;
            } else {
                cell.buttonFold.hidden = YES;
            }
            cell.buttonFold.selected = [[self.buttonState objectAtIndex:indexPath.row] intValue];
            
            if (cell.buttonFold.selected == NO) {
                cell.labelReply.numberOfLines = 2;
            } else {
                cell.labelReply.numberOfLines = 0;
            }
            return cell;
        }
    } else {
        if (indexPath.section == 0) {
            CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"LongCommentTitle"];
            NSString* longContentNumber = [NSString stringWithFormat:@"%lu条长评", (unsigned long)[self.longContentArray count]];
            cell.labelLongCommentTitle.text = longContentNumber;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, W);
            return cell;
        } else if (indexPath.section == 1) {
            CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"LongCommentContent"];
            [cell.buttonFold addTarget:self action:@selector(pressOpenClose:) forControlEvents:UIControlEventTouchUpInside];

            cell.labelName.text = [self.longAuthorArray objectAtIndex:indexPath.row];
            cell.labelContent.text = [self.longContentArray objectAtIndex:indexPath.row];
            
            [cell.CommentImageView sd_setImageWithURL:[self.longAvatarArray objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:nil]];

            cell.labelDate.text = [self dateWork:[self.longTimeArray objectAtIndex:indexPath.row]];
            if([[self.longReplyArray objectAtIndex:indexPath.row] isEqualToString:@"Empty"]) {
                cell.labelReply.text = @"";
            } else {
                cell.labelReply.text = [self.longReplyArray objectAtIndex:indexPath.row];
            }
            cell.buttonFold.tag = indexPath.row + 101;
            NSInteger count = [self getWidth:W - 90 title:[self.longReplyArray objectAtIndex:indexPath.row] font:[UIFont systemFontOfSize:15]] / cell.labelReply.font.lineHeight;
            if (count > 2) {
                cell.buttonFold.hidden = NO;
            } else {
                cell.buttonFold.hidden = YES;
            }
            cell.buttonFold.selected = [[self.buttonState objectAtIndex:indexPath.row] intValue];
            cell.buttonFold.tag = indexPath.row + 101;
            if (cell.buttonFold.selected == NO) {
                cell.labelReply.numberOfLines = 2;
            } else {
                cell.labelReply.numberOfLines = 0;
            }
            return cell;
        } else if (indexPath.section == 2) {
            CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ShortCommentTitle"];
            NSString* shortContentNumber = [NSString stringWithFormat:@"%lu条短评", (unsigned long)[self.shortContentArray count]];
            cell.labelShortCommentTitle.text = shortContentNumber;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, W);
            return cell;
        } else if (indexPath.section == 4) {
            CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Last"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            CommentTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ShortCommentContent"];
            [cell.buttonFold addTarget:self action:@selector(pressOpenClose:) forControlEvents:UIControlEventTouchUpInside];

            cell.labelName.text = [self.shortAuthorArray objectAtIndex:indexPath.row];
            cell.labelContent.text = [self.shortContentArray objectAtIndex:indexPath.row];
           
            [cell.CommentImageView sd_setImageWithURL:[self.shortAvatarArray objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:nil]];
            
            cell.labelDate.text = [self dateWork:[self.shortTimeArray objectAtIndex:indexPath.row]];
            if([[self.shortReplyArray objectAtIndex:indexPath.row] isEqualToString:@"Empty"]) {
                cell.labelReply.text = @"";
            } else {
                cell.labelReply.text = [self.shortReplyArray objectAtIndex:indexPath.row];
            }
            cell.buttonFold.tag = indexPath.row + 101 + [self.longAuthorArray count];
            NSInteger count = [self getWidth:W - 90 title:[self.shortReplyArray objectAtIndex:indexPath.row] font:[UIFont systemFontOfSize:15]] / cell.labelReply.font.lineHeight;
            if (count > 2) {
                cell.buttonFold.hidden = NO;
            } else {
                cell.buttonFold.hidden = YES;
            }
            cell.buttonFold.selected = [[self.buttonState objectAtIndex:indexPath.row + [self.longAuthorArray count]] intValue];
            if (cell.buttonFold.selected == NO) {
                cell.labelReply.numberOfLines = 2;
            } else {
                cell.labelReply.numberOfLines = 0;
            }
            return cell;
        }
    }
}


- (NSString*)dateWork:(NSString*) string {
    NSTimeInterval time = [string doubleValue];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSDate* date = [NSDate date];
    NSString* stringDate = [dateFormatter stringFromDate:date];
    NSString* stringToday = [stringDate substringToIndex:5];
    NSString* stringRequest = [currentDateStr substringToIndex:5];
    if ([stringToday isEqualToString:stringRequest]) {
        NSString* dateString = [NSString stringWithFormat:@"今天 "];
        dateString = [dateString stringByAppendingFormat:@"%@", [currentDateStr substringWithRange:NSMakeRange(6, 5)]];
        return dateString;
    } else {
        return currentDateStr;
    }
    

}

- (CGFloat)getWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    // 创建一个label对象，给出目标label的宽度
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    // 获得文字
    label.text = title;
    // 获得字体大小
    label.font = font;
    // 自适应
    label.numberOfLines = 0;
    
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
    // 经过自适应之后的label，已经有新的高度
    CGFloat height = size.height;
    // 返回高度
    return height;
}

- (void)getSelectShort:(NSNotification*) sender {
    _selection = sender.userInfo[@"textShort"];
    if ([_Selection isEqualToString:@"YES"]) {
        [self.tableView reloadData];
        [self ReplyDealLong];
        [self ReplyDealShort];
    }
}
- (void)getSelectLong:(NSNotification*) sender {
    _Selection = sender.userInfo[@"textLong"];
    if ([_selection isEqualToString:@"YES"]) {
        [self.tableView reloadData];
        [self ReplyDealLong];
        [self ReplyDealShort];
    }
}


- (void)ReplyDealShort {
    self.shortReplyArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.shortReply_content count]; i++) {
        if ([[self.shortReply_content objectAtIndex:i] isEqualToString:@"delete"]) {
            [self.shortReplyArray addObject:@"抱歉原点评已经被删除"];
        } else if ([[self.shortReply_content objectAtIndex:i] isEqualToString:@"Empty"]) {
            [self.shortReplyArray addObject:@"Empty"];
        } else {
            NSString* string = [NSString stringWithFormat:@"//%@:%@", [self.shortReply_Author objectAtIndex:i], [self.shortReply_content objectAtIndex:i]];
            [self.shortReplyArray addObject:string];
        }
    }
}
- (void)ReplyDealLong {
    self.longReplyArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.longReply_content count]; i++) {
        if ([[self.longReply_content objectAtIndex:i] isEqualToString:@"delete"]) {
            [self.longReplyArray addObject:@"抱歉原点评已经被删除"];
        } else if ([[self.longReply_content objectAtIndex:i] isEqualToString:@"Empty"]) {
            [self.longReplyArray addObject:@"Empty"];
        } else {
            NSString* string = [NSString stringWithFormat:@"//%@:%@", [self.longReply_Author objectAtIndex:i], [self.longReply_content objectAtIndex:i]];
            [self.longReplyArray addObject:string];
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)pressOpenClose:(UIButton*)button {
    
    if([self.buttonState[button.tag - 101] isEqualToString:@"1"]) {
        [self.buttonState replaceObjectAtIndex:button.tag - 101 withObject:@"0"];
    } else {
        [self.buttonState replaceObjectAtIndex:button.tag - 101 withObject:@"1"];
    }
    [self.tableView reloadData];
}
@end
