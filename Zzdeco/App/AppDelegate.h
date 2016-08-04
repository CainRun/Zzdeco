//
//  AppDelegate.h
//  Zzdeco
//
//  Created by Cain on 5/4/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+ (AppDelegate *)userInfoAppDelegate;

@property (nonatomic, assign) NSInteger loginStatus;

@property (nonatomic, copy) NSString *userPhoneNumber;
@property (nonatomic, copy) NSString *userPassword;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *verificationCode;
@property (nonatomic, assign) NSInteger userID;

@property (nonatomic, strong) NSURL *backgroundImageURL;

@property (strong, nonatomic) UIWindow *window;

@end

