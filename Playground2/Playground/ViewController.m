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
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //================================订阅信号
//    [self.textField.rac_textSignal subscribeNext:^(id x) {
//        NSLog(@"New Value:%@",x);
//    } error:^(NSError *error) {
//        NSLog(@"%@",error);
//    } completed:^{
//        NSLog(@"completed");
//    }];
    
    
    //===============================状态推导
//    RAC(self.button,enabled) = [self.textField.rac_textSignal map:^id(id value) {
//        return @([value rangeOfString:@"@"].location != NSNotFound);
//    }];
//    RACSignal *validEmailSignal = [self.textField.rac_textSignal map:^id(id value) {
//        return @([value rangeOfString:@"@"].location != NSNotFound);
//    }];
//    RAC(self.button,enabled) = validEmailSignal;
//    
//    RAC(self.textField,textColor) = [validEmailSignal map:^id(id value) {
//        if ([value boolValue]) {
//            return [UIColor greenColor];
//        }else{
//            return [UIColor redColor];
//        }
//    }];
    //======================指令==========
    RACSignal *validEmailSignal = [self.textField.rac_textSignal map:^id(id value) {
        return @([value rangeOfString:@"@"].location != NSNotFound);
    }];
    self.button.rac_command = [[RACCommand alloc]initWithEnabled:validEmailSignal signalBlock:^RACSignal *(id input) {
        NSLog(@"Button was pressed.");
        return [RACSignal empty];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
