//
//  ZzdecoCheckPhoneView.h
//  Zzdeco
//
//  Created by Cain on 28/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZzdecoCheckPhoneView : UIView

@property (nonatomic, copy) void(^zzdecoCheckPhoenRequstBlock)(NSString *phoneNumber);

- (void)stopLoadingView;

@end
