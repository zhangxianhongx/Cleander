//
//  ViewController.m
//  个人日历
//
//  Created by ybon on 16/8/31.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "ViewController.h"
#import "ZYCalendarView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    ZYCalendarView *calendarView = [[ZYCalendarView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width+40)];
    calendarView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:calendarView];
    
}

@end
