//
//  stack.h
//  calculator
//
//  Created by yangchenyu on 2019/7/14.
//  Copyright © 2019 yangchenyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 定义block
 @param obj 回调值
 */
typedef void(^StackBlock)(id obj);

@interface YCYstack : NSObject

//入栈操作
- (void)push:(id)obj;

//出栈操作
- (id)popObj;

//判断是否为空
- (NSInteger)isEmpty;

/** 清空 */
-(void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
