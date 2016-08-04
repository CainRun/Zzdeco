//
//  Define.h
//  Zzdeco
//
//  Created by Cain on 5/4/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define CAL_OBJC_IS_NIL(objc) ((objc) ? (NO) : (YES))

#define CAL_GET_METHOD_RETURN_OBJC(objc) if (objc) return objc

#define CAL_WEAK_SELF(weakSelf) __weak __typeof(&*self)weakSelf = self

#define CAL_COLOR_FROM_HEX_CODE(hexCode)    [UIColor colorWithRed:((float)((hexCode & 0xFF0000) >> 16))/255.0 green:((float)((hexCode & 0xFF00) >> 8))/255.0 blue:((float)(hexCode & 0xFF))/255.0 alpha:1.0]

#pragma mark - Device Screen Size Fit
#define CAL_SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define CAL_SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define CAL_WIDTH_TO_FIT(wiDth)  (ceilf( [UIScreen mainScreen].bounds.size.width / 375.0f  * (wiDth / 2) * 2) \
/ 2.0f)

#pragma mark - Get Device System Version
#define GET_IOS_7_Device    ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f)
#define GET_IOS_8_Device    ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f)

#pragma mark - Get Login State
#define CAL_LOGIN_SUCCESS    ([AppDelegate userInfoAppDelegate].loginStatus == CAL_LOGIN_STATUS_SUCCESS)
#define CAL_LOGIN_FAIL       ([AppDelegate userInfoAppDelegate].loginStatus == CAL_LOGIN_STATUS_FAILE)

#pragma mark - Get User Info
#define CAL_USER_PHONER_NUMBER ([AppDelegate userInfoAppDelegate].userPhoneNumber)
#define CAL_USER_PASSWORD      ([AppDelegate userInfoAppDelegate].userPassword)
#define CAL_USER_NAME          ([AppDelegate userInfoAppDelegate].userName)
#define CAL_VERIFICATION_CODE  ([AppDelegate userInfoAppDelegate].verificationCode)
#define CAL_USER_ID            ([AppDelegate userInfoAppDelegate].userID)

#define SHOW_ERROR_ALETVIEW(errorString) {\
    UIAlertView* defaultAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示" \
                                                           message:errorString \
                                                          delegate:nil \
                                                 cancelButtonTitle:@"确定" \
                                                 otherButtonTitles:nil, nil];\
        [defaultAlert show];\
}
#endif

#define BACKGROUND_IMAGE_URL ([AppDelegate userInfoAppDelegate].backgroundImageURL)

#define SELECT_ITEM_AT_INDEX @"selectItemAtIndex"

typedef enum {
    CAL_LOGIN_STATUS_INIT       = -1,   // - 初始化状态
    CAL_LOGIN_STATUS_FAILE      = 0,    // - 登录失败
    CAL_LOGIN_STATUS_SUCCESS    = 1,    // - 获取用户信息，真正登录成功
    
}CALLoginStatus;
