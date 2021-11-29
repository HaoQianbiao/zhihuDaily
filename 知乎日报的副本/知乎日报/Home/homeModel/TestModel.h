//
//  TestModel.h
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/18.
//

@protocol StoriesModel
@end

@protocol Top_StoriesModel
@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoriesModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSArray* images;
@property (nonatomic, copy) NSString *id;
@end
@interface Top_StoriesModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *id;
@end


@interface TestModel : JSONModel
@property (nonatomic, copy) NSString* date;

@property(nonatomic, strong) NSMutableArray* Top_StoriesTitle;
@property(nonatomic, strong) NSMutableArray* Top_StoriesHint;
@property(nonatomic, strong) NSMutableArray* Top_StoriesUrl;
@property(nonatomic, strong) NSMutableArray* Top_StoriesImage;
@property(nonatomic, strong) NSMutableArray* Top_StoriesID;


@property(nonatomic, strong) NSMutableArray* StoriesTitle;
@property(nonatomic, strong) NSMutableArray* StoriesHint;
@property(nonatomic, strong) NSMutableArray* StoriesUrl;
@property(nonatomic, strong) NSMutableArray* StoriesImages;
@property(nonatomic, strong) NSMutableArray* StoriesID;

@property(nonatomic, strong) NSString* dateString;

@property (nonatomic, copy) NSArray<StoriesModel>* stories;
@property (nonatomic, copy) NSArray<Top_StoriesModel>* top_stories;

@end

NS_ASSUME_NONNULL_END
