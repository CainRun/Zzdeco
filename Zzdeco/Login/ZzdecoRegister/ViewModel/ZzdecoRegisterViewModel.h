//
//  ZzdecoRegisterViewModel.h
//  Zzdeco
//
//  Created by Cain on 27/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoRegisterViewModel : NSObject

- (instancetype)initRegisterViewModel:(UIViewController *)controller;

- (void)registerRequst:(NSString *)verificationCode;
- (void)getVerificationCode;

@end
