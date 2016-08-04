//
//  ZzdecoUserSafeQuitCell.m
//  Zzdeco
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoUserSafeQuitCell.h"

@implementation ZzdecoUserSafeQuitCell

- (IBAction)safeQuit:(UIButton *)sender {
    
    self.userSafeQuitCellBlock(sender);
}

@end
