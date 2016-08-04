//
//  ZzdecoCaseShowViewController.h
//  Zzdeco
//
//  Created by Cain on 5/15/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZzdecoCaseShowView.h"
#import "CALBaseControllerSubTitleView.h"

@interface ZzdecoCaseShowViewController : UIViewController

@property (nonatomic, copy) NSString *caseID;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong, readonly) ZzdecoCaseShowView *showImageView;

@property (nonatomic, strong, readonly) CALBaseControllerSubTitleView *subTitleView;

@end
