//
//  ZzdecoUserPasswordCell.m
//  Zzdeco
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoUserPasswordCell.h"

@interface ZzdecoUserPasswordCell()

@property (weak, nonatomic) IBOutlet UILabel *passwordLevelLabel;

@end

@implementation ZzdecoUserPasswordCell

- (void)setPasswordLevel:(NSString *)passwordLevel {
    
    self.passwordLevelLabel.text = passwordLevel;
}

@end
