//
//  ZzdecoScreenContentViewController.h
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseViewController.h"

@interface ZzdecoScreenContentController : CALBaseViewController

+ (instancetype)zzdecoScreenContentController;

@property (nonatomic, copy) void(^zzdecoScreenContentBlock)(NSInteger index, NSInteger typeID);

@end
