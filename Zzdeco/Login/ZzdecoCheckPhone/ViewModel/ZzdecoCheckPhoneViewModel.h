//
//  ZzdecoLoginViewModel.h
//  Zzdeco
//
//  Created by Cain on 27/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoCheckPhoneViewModel : NSObject

- (instancetype)initCheckViewModel:(UIViewController *)controller;

- (void)checkPhoneNumberRequst:(NSDictionary *)parameters;

@end
