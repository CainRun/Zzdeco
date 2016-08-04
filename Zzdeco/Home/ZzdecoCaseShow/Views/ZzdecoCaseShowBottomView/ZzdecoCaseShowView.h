//
//  ZzdecoCaseShowView.h
//  Zzdeco
//
//  Created by Cain on 5/15/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZzdecoCaseShowView : UIView

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong, readonly) UITableView *imageTableView;

@property (nonatomic, copy) void(^zzdecoCaseShowDissmissBlock)(void);
@property (nonatomic, copy) void(^zzdecoCaseShowLoadDataBlock)(void);

@end
