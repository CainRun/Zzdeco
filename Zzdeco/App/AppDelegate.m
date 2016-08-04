//
//  AppDelegate.m
//  Zzdeco
//
//  Created by Cain on 5/4/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "AppDelegate.h"
#import "ZzdecoUserInfoViewModel.h"

@interface AppDelegate ()

@property (nonatomic, strong) ZzdecoUserInfoViewModel *infoViewModel;

@end

@implementation AppDelegate

+ (AppDelegate *)userInfoAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self.infoViewModel loginOutRequest:0];
    
    self.loginStatus = CAL_LOGIN_STATUS_INIT;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
    return YES;
}

#pragma mark - Set Login Status
- (void)setLoginStatus:(NSInteger)loginStatus {
    
    _loginStatus = loginStatus;
}

- (void)setUserPhoneNumber:(NSString *)userPhoneNumber {
    
    _userPhoneNumber = userPhoneNumber;
}

- (void)setUserPassword:(NSString *)userPassword {
    
    _userPassword = userPassword;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (ZzdecoUserInfoViewModel *)infoViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_infoViewModel);
    
    _infoViewModel = [[ZzdecoUserInfoViewModel alloc] init];
    
    return _infoViewModel;
}

@end
