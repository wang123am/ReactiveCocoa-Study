//
//  ViewController.m
//  Playground
//
//  Created by 黄成都 on 15/10/6.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * array = @[@1,@2,@3];
    //把数组转换为流
    RACSequence *stream = [array rac_sequence];
    //平方映射
     RACSequence *resultStream = [stream map:^id(id value) {
        return @(pow([value integerValue], 2));
    }];
    //从流中返回一个数组
    NSArray *resultArray = [resultStream array];
    NSLog(@"%@",resultArray);
  
    NSLog(@"%@",[[[array rac_sequence] map:^id(id value) {
        return @(pow([value integerValue], 2));
    }] array]);
    
    //使用过滤
    NSLog(@"%@",[[[array rac_sequence] filter:^BOOL(id value) {
        return [value integerValue] % 2 == 0;
    }] array]);

    //合并
    NSLog(@"%@",[[[array rac_sequence] map:^id(id value) {
        return [value stringValue];
    }] foldLeftWithStart:@"" reduce:^id(id accumulator, id value) {
        return [accumulator stringByAppendingString:value];
    }]);
    //订阅信号
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"New Value:%@",x);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    } completed:^{
        NSLog(@"completed");
    }];
    //状态推导
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
