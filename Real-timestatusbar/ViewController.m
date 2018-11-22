//
//  ViewController.m
//  Real-timestatusbar
//
//  Created by Jiaxin on 2018/11/22.
//  Copyright © 2018年 Jiaxin. All rights reserved.
//

#import "ViewController.h"
//#import "UIView+Swizzling.h"
@interface ViewController ()
{
    UIView *v;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    v = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 10, 10)];
    [self.view addSubview:v];
    
    
    UIScrollView *myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500)];
    myScrollView.backgroundColor = [UIColor whiteColor];
    myScrollView.contentSize = CGSizeMake(0, 600);
    
    UIImageView *ima = [[UIImageView alloc]initWithFrame:CGRectMake(0, -20, 414, 100)];
    //    ima.image = [UIImage imageNamed:@"Unknown.jpeg"];
    ima.backgroundColor = [UIColor blackColor];
    [myScrollView addSubview:ima];
    myScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myScrollView];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)btnAction:(UIButton *)sender{
    v.frame = CGRectMake(200, 200, 50, v.frame.size.height + 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
