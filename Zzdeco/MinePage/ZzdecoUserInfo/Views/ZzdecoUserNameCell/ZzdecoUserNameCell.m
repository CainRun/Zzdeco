//
//  CALUserNameCell.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoUserNameCell.h"

@interface ZzdecoUserNameCell()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation ZzdecoUserNameCell

- (void)setUserName:(NSString *)userName {
    
    self.userNameLabel.text = userName;
}

@end
