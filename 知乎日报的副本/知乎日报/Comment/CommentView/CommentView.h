//
//  CommentView.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/11/6.
//

#import <UIKit/UIKit.h>



@interface CommentView : UIView
<UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIButton* buttonBack;
@property (nonatomic, strong) UILabel* labelTitle;


@property (nonatomic, strong) NSMutableArray* longContentArray;
@property (nonatomic, strong) NSMutableArray* longAvatarArray;
@property (nonatomic, strong) NSMutableArray* longTimeArray;
@property (nonatomic, strong) NSMutableArray* longLikesArray;
@property (nonatomic, strong) NSMutableArray* longAuthorArray;
@property (nonatomic, strong) NSMutableArray* longReply_Author;
@property (nonatomic, strong) NSMutableArray* longReply_content;
@property (nonatomic, strong) NSMutableArray* longReplyArray;

@property (nonatomic, strong) NSMutableArray* shortContentArray;
@property (nonatomic, strong) NSMutableArray* shortTimeArray;
@property (nonatomic, strong) NSMutableArray* shortLikesArray;
@property (nonatomic, strong) NSMutableArray* shortAvatarArray;
@property (nonatomic, strong) NSMutableArray* shortAuthorArray;
@property (nonatomic, strong) NSMutableArray* shortReply_Author;
@property (nonatomic, strong) NSMutableArray* shortReply_content;
@property (nonatomic, strong) NSMutableArray* shortReplyArray;

@property (nonatomic, strong) NSString* Selection;
@property (nonatomic, strong) NSString* selection;
@property (nonatomic, assign) bool selected;
@property (nonatomic, strong) NSMutableArray* buttonState;
@end

