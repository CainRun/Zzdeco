//
//  ZzdecoUserIDCell.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoUserIDCell.h"

@interface ZzdecoUserIDCell()

@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;

@end

@implementation ZzdecoUserIDCell

- (void)setUserID:(NSString *)userID {
    
    self.userIDLabel.text = userID;
}

@end
