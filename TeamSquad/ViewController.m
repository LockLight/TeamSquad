//
//  ViewController.m
//  TeamSquad
//
//  Created by locklight on 2017/12/27.
//  Copyright © 2017年 locklight. All rights reserved.
//

#import "ViewController.h"
#import "BenchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)pushNext:(UIButton *)sender {
    BenchViewController *vc = [[BenchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
