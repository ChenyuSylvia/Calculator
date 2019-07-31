//
//  stack.m
//  calculator
//
//  Created by yangchenyu on 2019/7/14.
//  Copyright © 2019 yangchenyu. All rights reserved.
//

#import "YCYstack.h"

@interface YCYstack()
@property (nonatomic, strong) NSMutableArray *stackArray;

@end

@implementation YCYstack

-(instancetype)init {
    _stackArray = [[NSMutableArray alloc] init];
    return self;
}

- (void) push:(id)obj{
    [self.stackArray addObject:obj];
}

- (id)popObj {
    if (![self isEmpty]) {
        return nil;
    }
    id lastObject = self.stackArray.lastObject;
    [self.stackArray removeLastObject];
    return lastObject;
}

- (NSInteger)isEmpty {
    return self.stackArray.count;
}

-(void)removeAllObjects {
    [self.stackArray removeAllObjects];
}

@end
