//
//  ZzdecoRestUserNameView.h
//  Zzdeco
//
//  Created by Cain on 18/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZzdecoChangeUserNameView : UIView

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) void(^zzdecoCompleteButtonBlock)(NSString *userName);

@end
