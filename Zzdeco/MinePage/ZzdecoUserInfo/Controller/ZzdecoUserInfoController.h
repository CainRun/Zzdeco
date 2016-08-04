//
//  ZzdecoUserInfoViewController.h
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseViewController.h"
#import "ZzdecoUserInfoResultModel.h"

@interface ZzdecoUserInfoController : CALBaseViewController

- (void)getPasswordDactyl:(NSInteger)dactyl;

@property (weak, nonatomic, readonly) IBOutlet UITableView *userInfoTableView;

@property (nonatomic, strong) ZzdecoUserInfoResultModel *restultModel;

@end
