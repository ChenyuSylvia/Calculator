//
//  ViewController.m
//  calculator
//
//  Created by yangchenyu on 2019/7/12.
//  Copyright © 2019 yangchenyu. All rights reserved.
//

#import "ViewController.h"
#import "YCYstack.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *result;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) BOOL is_letter;
@property (nonatomic, assign) NSInteger cur;//第几个变量
@property (nonatomic, assign) NSInteger op_tag;
@property (nonatomic, assign) NSInteger op_count;//记录栈中符号个数
@property (nonatomic, assign) double num;//存储当前数
@property (nonatomic, strong) YCYstack *stack;//zhan
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSArray *keys = @[@"AC", @"+/-", @"%", @"➗"
                    , @"7", @"8", @"9", @"✖️"
                    , @"4", @"5", @"6", @"➖"
                    , @"1", @"2", @"3", @"➕"
                    , @"0", @"？", @".", @"="];

    //初始化button格式
    _is_letter = YES;
    _op_count = 0;
    _cur = 0;
    _num = 0;
    _stack = [[YCYstack alloc] init];
    
    _result = [[UITextField alloc] init];
    _result.frame = CGRectMake(0, 390, [[UIScreen mainScreen] bounds].size.width - 80, 50);
    //_result.backgroundColor =[UIColor whiteColor];
    _result.textAlignment = NSTextAlignmentRight;
    _result.text = @"0";
    [_result setTextColor:[UIColor whiteColor]];
    [_result setFont:[UIFont fontWithName:@"Arial" size:50]];
    _dataArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    [self.view addSubview:_result];
    
    NSInteger indexOfKeys = 0;
    for (NSString *key in keys) {
        //循环所有键
        if (indexOfKeys == 17){
            indexOfKeys++;
            continue;
        }
        UIButton *temp = [UIButton buttonWithType:UIButtonTypeSystem];
        if (indexOfKeys == 16) {
            temp.frame = CGRectMake(50 + (indexOfKeys % 4)*80, 450 + (indexOfKeys / 4)*80, 140, 60);
        }else {
            temp.frame = CGRectMake(50 + (indexOfKeys % 4)*80, 450 + (indexOfKeys / 4)*80, 60, 60);
        }
        if ((indexOfKeys + 1)%4 == 0) {
            temp.backgroundColor = [UIColor orangeColor];
        }else{
            temp.backgroundColor = [UIColor grayColor];
        }
        temp.layer.cornerRadius = 30;//设置半径
        temp.layer.masksToBounds = YES;//裁边
        [temp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [temp setTitle:key forState:UIControlStateNormal];
        temp.tag = indexOfKeys;
        indexOfKeys++;
        [temp addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:temp];

    }
}

//-(void) BtnClick:(UIButton *)btn
//{
//    NSInteger tag = btn.tag;
//
//    switch (tag) {
//        case 0://AC
//            _cur = 0;
//            _dataArray[0] = @(0);
//            _dataArray[1] = @(0);
//            _op_tag = 0;
//            _result.text = @"0";
//            break;
//        case 1://变正负
//            _dataArray[_cur] = @([_dataArray[_cur] doubleValue]*(-1));
//            _result.text = @([_dataArray[_cur] doubleValue]).stringValue;
//            break;
//        case 4:
//        case 5:
//        case 6:
//        case 8:
//        case 9:
//        case 10:
//        case 12:
//        case 13:
//        case 14:
//        case 16:
//            _is_letter = YES;
//            if (_op_tag == 19) {
//                _dataArray[0] = @(0);
//            }
//            _dataArray[_cur] = @([_dataArray[_cur] doubleValue]*10 + [btn.currentTitle doubleValue]);
//            _result.text = @([_dataArray[_cur] doubleValue]).stringValue;
//            break;
//        case 2:
//        case 3:
//        case 7:
//        case 11:
//        case 15:
//
//            _is_letter = NO;
//            _cur = 1;
//            _dataArray[_cur] = @(0);
//            _op_tag = btn.tag;
//            break;
//        case 18: //.
//
//            break;
//        case 19://=
//            if (_is_letter) {
//                if (_op_tag == 2){ //%
//                    _result.text = @([_dataArray[0] integerValue] % [_dataArray[1] integerValue]).stringValue;
//                }else if (_op_tag == 3) { //chu
//                    _result.text = @([_dataArray[0] doubleValue] / [_dataArray[1] doubleValue]).stringValue;
//                }else if (_op_tag == 7) { //cheng
//                    _result.text = @([_dataArray[0] doubleValue] * [_dataArray[1] doubleValue]).stringValue;
//                }else if (_op_tag == 11){ //-
//                    _result.text = @([_dataArray[0] doubleValue] - [_dataArray[1] doubleValue]).stringValue;
//                }else if (_op_tag ==15){ //+
//                    _result.text = @([_dataArray[0] doubleValue] + [_dataArray[1] doubleValue]).stringValue;
//                }
//            }else {
//                if (_op_tag == 2){ //%
//                    _result.text = @([_dataArray[0] integerValue] % [_dataArray[0] integerValue]).stringValue;
//                }else if (_op_tag == 3) { //chu
//                    _result.text = @([_dataArray[0] doubleValue] / [_dataArray[0] doubleValue]).stringValue;
//                }else if (_op_tag == 7) { //cheng
//                    _result.text = @([_dataArray[0] doubleValue] * [_dataArray[0] doubleValue]).stringValue;
//                }else if (_op_tag == 11){ //-
//                    _result.text = @([_dataArray[0] doubleValue] - [_dataArray[0] doubleValue]).stringValue;
//                }else if (_op_tag ==15){ //+
//                    _result.text = @([_dataArray[0] doubleValue] + [_dataArray[0] doubleValue]).stringValue;
//                }
//            }
//            //等号结束之后
//            _cur = 0;
//            _dataArray[_cur] = _result.text;
//            //_op_tag = btn.tag;
//            break;
//        default:
//            break;
//    }
//}

- (void)BtnClick:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    switch (tag) {
        case 0:
            _result.text = @(0).stringValue;
            _num = 0;
            [_stack removeAllObjects];
        case 1://变正负
            _num = -_num;
            _result.text = @(_num).stringValue;
            break;
        case 4:
        case 5:
        case 6:
        case 8:
        case 9:
        case 10:
        case 12:
        case 13:
        case 14:
        case 16:
            _is_letter = YES;
            _num = _num * 10 + [btn.currentTitle integerValue];
            _result.text = @(_num).stringValue;
            break;
        case 2://%
            _num = _num / 100;
            _result.text = @(_num).stringValue;
            break;
        case 3://chu
        case 7://cheng
            if(_op_count == 2) { //只有前一个符号是*/才会pop
                if (_is_letter) {
                    _op_count = 2;
                    [_stack push:@(_num).stringValue];
                    id temp2 = [_stack popObj];//运算数2
                    id sign = [_stack popObj];//符号
                    id temp1 = [_stack popObj];//运算数1
                    
                    if ([sign integerValue] == 3) { //chu
                        _result.text =  @([temp1 doubleValue] / [temp2 doubleValue]).stringValue;
                        [_stack push:@([temp1 doubleValue] / [temp2 doubleValue]).stringValue];
                    }else if ([sign integerValue] == 7) { //cheng
                        _result.text =  @([temp1 doubleValue] * [temp2 doubleValue]).stringValue;
                        [_stack push:@([temp1 doubleValue] * [temp2 doubleValue]).stringValue];
                    }else if ([sign integerValue] == 11){ //-
                        _result.text =  @([temp1 doubleValue] - [temp2 doubleValue]).stringValue;
                        [_stack push:@([temp1 doubleValue] - [temp2 doubleValue]).stringValue];
                    }else if ([sign integerValue] ==15){ //+
                        _result.text =  @([temp1 doubleValue] + [temp2 doubleValue]).stringValue;
                        [_stack push:@([temp1 doubleValue] + [temp2 doubleValue]).stringValue];
                    }
                    _num = 0;
                    _is_letter = NO;
                    [_stack push:@(btn.tag).stringValue];
                }else {  //替换前面的符号
                    [_stack popObj];
                    [_stack push:@(btn.tag).stringValue];
                }
            }else {
                if (_is_letter) {
                    _op_count = 2;  //表示记录符号为*/
                    [_stack push:@(_num).stringValue];
                    _num = 0;
                    _is_letter = NO;
                    [_stack push:@(btn.tag).stringValue];
                }else {  //替换前面的符号
                    _op_count = 2;  //表示记录符号为*/
                    [_stack popObj];
                    [_stack push:@(btn.tag).stringValue];
                }
            }
            break;
        case 11://-
        case 15: { //+
            if(_op_count > 0) {  //前面已经有过一组 需要pop出来
                if (_is_letter) {
                        _op_count = 1;
                        [_stack push:@(_num).stringValue];
                    while (_stack.isEmpty > 1) {
                        id temp2 = [_stack popObj];//运算数2
                        id sign = [_stack popObj];//符号
                        id temp1 = [_stack popObj];//运算数1
                        
                        if ([sign integerValue] == 3) { //chu
                            _result.text =  @([temp1 doubleValue] / [temp2 doubleValue]).stringValue;
                            [_stack push:@([temp1 doubleValue] / [temp2 doubleValue]).stringValue];
                        }else if ([sign integerValue] == 7) { //cheng
                            _result.text =  @([temp1 doubleValue] * [temp2 doubleValue]).stringValue;
                            [_stack push:@([temp1 doubleValue] * [temp2 doubleValue]).stringValue];
                        }else if ([sign integerValue] == 11){ //-
                            _result.text =  @([temp1 doubleValue] - [temp2 doubleValue]).stringValue;
                            [_stack push:@([temp1 doubleValue] - [temp2 doubleValue]).stringValue];
                        }else if ([sign integerValue] == 15){ //+
                            _result.text =  @([temp1 doubleValue] + [temp2 doubleValue]).stringValue;
                            [_stack push:@([temp1 doubleValue] + [temp2 doubleValue]).stringValue];
                        }
                    }
                    _num = 0;
                    _is_letter = NO;
                    [_stack push:@(btn.tag).stringValue];
                }else {  //替换前面的符号
                    [_stack popObj];
                    [_stack push:@(btn.tag).stringValue];
                }
                
            }else {
                if (_is_letter) {
                    _op_count = 1;  //表示记录符号为+-
                    [_stack push:@(_num).stringValue];
                    _num = 0;
                    _is_letter = NO;
                    [_stack push:@(btn.tag).stringValue];
                }else {  //替换前面的符号
                    _op_count = 1;  //表示记录符号为+-
                    [_stack popObj];
                    [_stack push:@(btn.tag).stringValue];
                }
            }
        }
            break;
        case 18: //.

            break;
        case 19: { //=
            [_stack push:@(_num).stringValue];
            while (_stack.isEmpty > 1) {
                id temp2 = [_stack popObj];//运算数2
                id sign = [_stack popObj];//符号
                id temp1 = [_stack popObj];//运算数1
                
                if ([sign integerValue] == 3) { //chu
                    _result.text =  @([temp1 doubleValue] / [temp2 doubleValue]).stringValue;
                    [_stack push:@([temp1 doubleValue] / [temp2 doubleValue]).stringValue];
                }else if ([sign integerValue] == 7) { //cheng
                    _result.text =  @([temp1 doubleValue] * [temp2 doubleValue]).stringValue;
                    [_stack push:@([temp1 doubleValue] * [temp2 doubleValue]).stringValue];
                }else if ([sign integerValue] == 11){ //-
                    _result.text =  @([temp1 doubleValue] - [temp2 doubleValue]).stringValue;
                    [_stack push:@([temp1 doubleValue] - [temp2 doubleValue]).stringValue];
                }else if ([sign integerValue] == 15){ //+
                    _result.text =  @([temp1 doubleValue] + [temp2 doubleValue]).stringValue;
                    [_stack push:@([temp1 doubleValue] + [temp2 doubleValue]).stringValue];
                }
            }
            _num = 0;
            //_is_letter = NO;
            //[_stack push:@(btn.tag).stringValue];
        }
            break;
    }
}

@end
