//
//  ZzdecoUserInfoViewController.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoUserInfoController.h"
#import "ZzdecoChangeUserNameController.h"

#import "ZzdecoUserHeadCell.h"
#import "ZzdecoUserNameCell.h"
#import "ZzdecoUserIDCell.h"

#import "ZzdecoUserPasswordCell.h"
#import "ZzdecoUserPhoneNumberCell.h"
#import "ZzdecoUserSafeQuitCell.h"
#import "ZzdecoUserInfoViewModel.h"

typedef NS_ENUM(NSInteger, CALUserInfoType) {
    
    CALUserBaseInfo,
    CALUserSafeInfo
};

@interface ZzdecoUserInfoController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, assign) CALUserInfoType userInfoType;

@property (weak, nonatomic) IBOutlet UIView *customTitleView;
@property (weak, nonatomic, readwrite) IBOutlet UITableView *userInfoTableView;

@property (nonatomic, assign) NSInteger *segementIndexPath;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;
@property (nonatomic, strong) ZzdecoUserInfoViewModel *userInfoViewModel;

@property (nonatomic, assign) NSInteger dactyl;

@end

@implementation ZzdecoUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomSegmentControllerView];
    
    [self.view addSubview:self.titleView];
    [self setTitleViewButtonActionBlock];
    [self setImageTableViewRefreshHeader];
    
    [self.userInfoTableView.mj_header beginRefreshing];
}

#pragma mark - Set Title View
- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);
    
    _titleView                 = [CALBaseControllerTitleView new];
    _titleView.backgroundColor = CAL_COLOR_FROM_HEX_CODE(0x3c3c3c);
    
    return _titleView;
}

#pragma mark - Set User Info View Model
- (ZzdecoUserInfoViewModel *)userInfoViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_userInfoViewModel);
    
    _userInfoViewModel = [[ZzdecoUserInfoViewModel alloc] initViewModelWithController:self];
    
    return _userInfoViewModel;
}

- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(weakSelf);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)setCustomSegmentControllerView {
    
    CGRect rect = CGRectMake((CAL_SCREEN_WIDTH / 2) - (CAL_WIDTH_TO_FIT(340) / 2), self.titleView.height - CAL_WIDTH_TO_FIT(74), CAL_WIDTH_TO_FIT(340), CAL_WIDTH_TO_FIT(70));
    
    ZLCustomeSegmentControlView *segmentController = [[ZLCustomeSegmentControlView alloc] initWithFrame:rect];
    
    segmentController.titles             = @[@"基本资料", @"安全设置"];
    segmentController.duration           = 0.3f;
    segmentController.titlesCustomeColor = [UIColor lightGrayColor];
    segmentController.titlesFont         = [UIFont systemFontOfSize:15];
    
    [segmentController setButtonOnClickBlock:^(NSInteger tag, NSString *title) {
        
        switch (tag) {
            case 0: {
                
                self.userInfoType = CALUserBaseInfo;
                
                [self.userInfoViewModel getUserInfo];
            }
                break;
            default: {
                
                self.userInfoType = CALUserSafeInfo;
                
                [self.userInfoViewModel getPasswordState];
            }
                break;
        }
        
        [self.userInfoTableView reloadData];
    }];

    [self.titleView addSubview:segmentController];
}

#pragma mark - TableView Data Source Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    if (self.userInfoType == CALUserBaseInfo) {
        
        switch (indexPath.row) {
            case 0: {
                
                ZzdecoUserHeadCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"calUserHeadCell"];
                
                headCell.isNeedLine = YES;

                NSURL *url = [NSURL URLWithString:self.restultModel.authPhoto];
                
                if (url) {
                    
                    [headCell.userHeaderImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_background_image"]];
                    
                } else {
                    
                    NSData *header = [[NSUserDefaults standardUserDefaults] objectForKey:@"userHeaderImage"];
                    
                    headCell.userHeaderImageView.image = [UIImage imageWithData:header];
                }
                
                return headCell;
            }
                
            case 1: {
                
                ZzdecoUserNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:@"calUserNameCell"];
                
                nameCell.isNeedLine = YES;
                nameCell.userName   = self.restultModel.userName;
                
                return nameCell;
            }
                
            default: {
                
                ZzdecoUserIDCell *idCell = [tableView dequeueReusableCellWithIdentifier:@"calUserIDCell"];
                
                idCell.userID         = self.restultModel.memberNo;
                idCell.isNeedLine     = YES;
                idCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return idCell;
            }
                break;
        }
        
    } else {
        
        switch (indexPath.row) {
            case 0: {
                
                ZzdecoUserPasswordCell *passwordCell = [tableView dequeueReusableCellWithIdentifier:@"calUserPasswordCell"];
                passwordCell.isNeedLine = YES;
                
                switch (self.dactyl) {
                    case 30:
                        
                        passwordCell.passwordLevel = @"弱";
                        
                        break;
                        
                    case 60:
                        
                        passwordCell.passwordLevel = @"中等";

                        break;
                    default:
                        
                        passwordCell.passwordLevel = @"  ";
                        
                        break;
                }
                
                return passwordCell;
            }
                
            case 1: {
                
                ZzdecoUserPhoneNumberCell *phoneNumberCell = [tableView dequeueReusableCellWithIdentifier:@"calUserPhoneNumberCell"];
                phoneNumberCell.userPhone               = CAL_USER_PHONER_NUMBER;
                phoneNumberCell.isNeedLine              = YES;
                
                return phoneNumberCell;
            }
                
            default: {
                
                ZzdecoUserSafeQuitCell *safeQuitCell = [tableView dequeueReusableCellWithIdentifier:@"calUserSafeQuitCell"];
                safeQuitCell.isNeedLine     = NO;
                safeQuitCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [safeQuitCell setUserSafeQuitCellBlock:^(UIButton *safeQuitButton) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                        message:@"是否要退出?"
                                                                       delegate:self
                                                              cancelButtonTitle:@"取消"
                                                              otherButtonTitles:@"确定", nil];
                    
                    [alertView show];
                }];
                
                return safeQuitCell;
            }
                break;
        }
    }
    
    return nil;
}

#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.userInfoType == CALUserBaseInfo) {
        
        switch (indexPath.row) {
            case 0: {
                
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.sourceType               = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePickerController.allowsEditing            = YES;
                imagePickerController.delegate                 = self;
                
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
                break;
            case 1: {
                
                ZzdecoChangeUserNameController *viewController = [[ZzdecoChangeUserNameController alloc] init];
                                
                viewController.userNameString = self.restultModel.userName;
                
                [viewController setCalRestUserNameBlock:^{
                    
                    [tableView reloadData];
                }];
                
                [self.navigationController pushViewController:viewController animated:YES];
            }
                break;
            default:
                break;
        }
        
    } else {
        
        switch (indexPath.row) {
                
            case 0:  {
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CALMyPage" bundle:nil];
                UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"calResetPasswordViewController"];
                
                [self.navigationController pushViewController:viewController animated:YES];
            }
                break;
                
            case 1: {
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CALMyPage" bundle:nil];
                UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"calRestPhoneNumerViewController"];
                
                [self.navigationController pushViewController:viewController animated:YES];

            }
                break;
            default:
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.userInfoType == CALUserSafeInfo && indexPath.row == 2) {
        
        return CAL_WIDTH_TO_FIT(160);
    }
    
    return CAL_WIDTH_TO_FIT(130);
}

#pragma mark - Image Picker Controller Delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
    UIImage *headImage = [UIImage imageWithData:[[self class] imageData:image]];
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(headImage) forKey:@"userHeaderImage"];
    
    [self.userInfoTableView reloadData];
    
    [self.userInfoViewModel uploadHeder:headImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

+ (NSData *)imageData:(UIImage *)myimage {
    
    NSData *data = UIImageJPEGRepresentation(myimage, 1.0);
    
    if (data.length > 100 * 1024) {
        
        if (data.length > 1024 * 1024) { //1M以及以上
            
            data = UIImageJPEGRepresentation(myimage, 0.1);
            
        } else if (data.length > 512 * 1024) {   //0.5M-1M
            
            data = UIImageJPEGRepresentation(myimage, 0.5);
            
        } else if (data.length > 200 * 1024) {   //0.25M-0.5M
            
            data = UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    
    return data;
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        [self.userInfoViewModel loginOutRequest:buttonIndex];
    }
}

#pragma mark - Set Password Dactyl
- (void)getPasswordDactyl:(NSInteger)dactyl {
    
    self.dactyl = dactyl;
    
    [self.userInfoTableView reloadData];
}

#pragma mark - Set Table View Refresh Header
- (void)setImageTableViewRefreshHeader {
    
    CAL_WEAK_SELF(weakSelf);
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (weakSelf.userInfoType == CALUserBaseInfo) {
            
            [weakSelf.userInfoViewModel getUserInfo];
            
        } else {
            
            [weakSelf.userInfoViewModel getPasswordState];
        }
        
        [weakSelf.userInfoTableView.mj_header endRefreshing];
    }];
    
    refreshHeader.height                      = 50.f;
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    
    self.userInfoTableView.mj_header = refreshHeader;
}

@end
