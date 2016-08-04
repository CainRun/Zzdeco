//
//  ZzdecoInternetProtocolAddress.h
//  Zzdeco
//
//  Created by Cain on 27/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#ifndef ZzdecoInternetProtocolAddress_h
#define ZzdecoInternetProtocolAddress_h

#pragma mark - Get 请求
#define CHECK_PHONE      @"http://mobile.zzdeco.com/login/check_phone.json?"                // 检测手机号接口
#define REGISTER_ADDRESS @"http://mobile.zzdeco.com/login/register.json?"                   // 注册接口
#define LOGIN_ADDRESS    @"http://mobile.zzdeco.com/login/check_password.json?"             // 登录接口

#pragma mark - POST 请求
#define REST_PASSWORD_ADDRESS   @"http://mobile.zzdeco.com/login/reset_password.json?"      // 重置密码接口
#define GET_VERIFICATION_CODE   @"http://mobile.zzdeco.com/login/send_verify.json?"         // 获取验证码接口

#pragma mark - 案例请求接口
#define GET_CASE_INFO_ADDRESS   @"http://mobile.zzdeco.com/anli/project_list.json?"            // 案例介绍接口
#define GET_CASE_IMAGES_ADDRESS @"http://mobile.zzdeco.com/anli/project_imgs.json?"            // 案例图片组接口
#define GET_CASE_SCREEN_ADDRESS @"http://mobile.zzdeco.com/anli/para_list.json?"               // 案例搜索接口
#define GET_CASE_COLLECTION_ADDRESS @"http://mobile.zzdeco.com/myAttention/acproject.json?"    // 收藏案例接口


#pragma mark - 个人设置请求
#define GET_NAME_HEADER_ADDRESS  @"http://mobile.zzdeco.com/manager/modify_user_info.json?"  // 修改用户名
#define GET_UP_HEADER_ADDRESS    @"http://file.zzdeco.com/file/upload.json?"                 // 上传头像接口
#define GET_USER_INFO_ADDRESS    @"http://mobile.zzdeco.com/manager/user_baseinfo.json?"     // 获取个人信息
#define GET_CHANGE_PHONE_ADDRESS @"http://mobile.zzdeco.com/manager/changePhone.json?"       // 修改手机号接口

#define GET_USER_COLLECTION_ADDRESS @"http://mobile.zzdeco.com/myAttention/ac_projectlist.json" // 获取个人收藏案例列表接口
#define GET_USER_COLLECTION_CASE_ADDRESS @"http://mobile.zzdeco.com/anli/project_detail.json?"  // 获取个人收藏列表接口

#define GET_CHANGE_PHONE_VERIFICATION_CODE @"http://mobile.zzdeco.com/manager/send_verify2.json?" // 获取修改手机号验证码接口

#define GET_CHANGE_PASSWORD_ADDRESS @"http://mobile.zzdeco.com/manager/setting_password.json?"  // 修改密码接口
#define GET_LOGOUT_ADDRESS          @"http://mobile.zzdeco.com/login/logout.json"               // 退出登录接口
#define GET_PASSWORD_SAFETY_ADDRESS @"http://mobile.zzdeco.com/manager/safety_setting.json?"    // 获取密码强度接口

#define REQUEST_ERRORMESSAGE @"服务器有些小问题, 请稍后再试"

#endif /* ZzdecoInternetProtocolAddress_h */
