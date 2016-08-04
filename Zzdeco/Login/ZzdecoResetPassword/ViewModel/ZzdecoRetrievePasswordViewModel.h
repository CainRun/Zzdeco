//
//  ZzdecoRetrievePasswordViewModel.h
//  Zzdeco
//
//  Created by Cain on 28/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoRetrievePasswordViewModel : NSObject

- (instancetype)initRetrievePasswordViewModel:(UIViewController *)controller;

- (void)retrievePasswordRequst:(NSDictionary *)parameters;
- (void)getVerificationCode;

@end
