//
//  CALViewController.m
//  Zzdeco
//
//  Created by Cain on 5/4/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseViewController.h"

@interface CALBaseViewController()

@end

@implementation CALBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
