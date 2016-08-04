//
//  ZzdecoCaseInfoView.h
//  Zzdeco
//
//  Created by Cain on 5/9/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZzdecoCaseInfoView : UIView

@property (nonatomic, copy) NSString *caseName;
@property (nonatomic, copy) NSString *caseInfo;

@property (nonatomic, strong, readonly) UIImageView *backgroundImageView;

@property (nonatomic, strong, readonly) UITableView *infoTableView;

@end
