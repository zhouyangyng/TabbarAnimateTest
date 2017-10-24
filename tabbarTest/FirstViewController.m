//
//  FirstViewController.m
//  tabbarTest
//
//  Created by mac1 on 22017/9/20.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc]init];
    
    lab.bounds = CGRectMake(0, 0, 150, 35);
    
    lab.textAlignment = NSTextAlignmentCenter;
    
    lab.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    lab.text = @"啥都没有啊";
    
    lab.textColor = [UIColor grayColor];
    
    lab.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:lab];
}


@end
