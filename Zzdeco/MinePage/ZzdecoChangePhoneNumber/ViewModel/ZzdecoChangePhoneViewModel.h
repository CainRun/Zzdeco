//
//  ZzdecoChangePhoneViewModel.h
//  Zzdeco
//
//  Created by Cain on 19/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoChangePhoneViewModel : NSObject

- (instancetype)initChangePhoneViewModelWhithController:(UIViewController *)controller;

- (void)changePhoneRequest:(NSDictionary *)parameters;
- (void)getVerificationCodeRequest:(NSDictionary *)parameters;

@end
