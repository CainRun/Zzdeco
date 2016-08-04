//
//  CALBaseControllerSubTitleView.h
//  Zzdeco
//
//  Created by Cain on 5/9/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALBaseControllerSubTitleView : UIView

@property (nonatomic, copy) NSString *rightButtonTitle;

@property (nonatomic, copy) void(^calControllerSubTitleViewLeftBlock)(UIButton *leftButton);
@property (nonatomic, copy) void(^calControllerSubTitleViewRightBlock)(UIButton *rightButton);

@property (nonatomic, assign) BOOL isAcstate;

@property (nonatomic, strong) UIColor *titleTextColor;

@property (nonatomic, strong) UIImage *leftButtonImage;
@property (nonatomic, strong) UIImage *leftButtonHighlightedImage;

@property (nonatomic, strong) UIImage *rightButtonImage;
@property (nonatomic, strong) UIImage *rightButtonHighlightedImage;

@end
