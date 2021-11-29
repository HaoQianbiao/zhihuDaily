//
//  TestModel.m
//  知乎日报
//
//  Created by haoqianbiao on 2021/10/18.
//

#import "TestModel.h"

@implementation TestModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation StoriesModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation Top_StoriesModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
