//
//  ZzdecoRestUserNameViewController.h
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseViewController.h"

@interface ZzdecoChangeUserNameController : CALBaseViewController

@property (nonatomic, copy) void(^calRestUserNameBlock)(void);

@property (nonatomic, copy) NSString *userNameString;

@end
