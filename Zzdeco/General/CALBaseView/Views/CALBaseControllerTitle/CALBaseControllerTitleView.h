//
//  CALControllerTitleView.h
//  Zzdeco
//
//  Created by Cain on 5/4/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CALBaseControllerTitleViewStyle) {
    
    CALBaseControllerTitleViewCenterStyle = 0,
    CALBaseControllerTitleViewLeftStyle,
    CALBaseControllerTitleViewRightStyle,
};

@interface CALBaseControllerTitleView : UIView

@property (nonatomic, copy) NSString *titleViewTitle;
@property (nonatomic, copy) NSString *rightButtonTitle;

@property (nonatomic, copy) void(^calControllerTitleViewLeftBlock)(UIButton *leftButton);
@property (nonatomic, copy) void(^calControllerTitleViewRightBlock)(UIButton *rightButton);

@property (nonatomic, assign) BOOL hiddenRightButton;
@property (nonatomic, assign) CALBaseControllerTitleViewStyle titleStyle;

@property (nonatomic, strong) UIColor *titleTextColor;

@property (nonatomic, strong) UIImage *leftButtonImage;
@property (nonatomic, strong) UIImage *leftButtonHighlightedImage;

@property (nonatomic, strong) UIImage *rightButtonImage;
@property (nonatomic, strong) UIImage *rightButtonHighlightedImage;

@end
