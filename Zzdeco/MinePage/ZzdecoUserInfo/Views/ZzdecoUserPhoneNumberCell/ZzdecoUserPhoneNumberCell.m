//
//  ZzdecoUserPhoneNumberCell.m
//  Zzdeco
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoUserPhoneNumberCell.h"

@interface ZzdecoUserPhoneNumberCell()

@property (weak, nonatomic) IBOutlet UILabel *userPhoneLabel;

@end

@implementation ZzdecoUserPhoneNumberCell

- (void)setUserPhone:(NSString *)userPhone {
    
    self.userPhoneLabel.text = userPhone;
}

@end
