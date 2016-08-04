//
//  ZzdecoResetPasswordViewModel.h
//  Zzdeco
//
//  Created by Cain on 13/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoChangePasswordViewModel : NSObject

- (instancetype)initChangePasswordViewModel:(UIViewController *)controller;

- (void)changePasswordRequest:(NSDictionary *)parameter;

@end
