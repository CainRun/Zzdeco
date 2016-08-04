//
//  NSAttributedString+CALAttributedString.h
//  Zzdeco
//
//  Created by Cain on 5/5/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (CALAttributedString)

+ (NSAttributedString *)cal_attributedStringAddLine:(NSString *)string;
+ (NSAttributedString *)cal_attributedStringAddLine:(NSString *)string range:(NSRange)range;

/**
 *  设置指定字符串的字体大小, 以及每行的间距
 *
 *  @param string      指定字符串
 *  @param font        字符大小
 *  @param lineSpacing 每行间距
 *
 *  @return NSAttributedString
 */
+ (NSAttributedString *)cal_attributedStringAddLineAndFont:(NSString *)string
                                                      font:(CGFloat)font
                                               lineSpacing:(CGFloat)lineSpacing;

/**
 *  设置指定某字符串的位置的字体大小, 以及每行的间距
 *
 *  @param string      指定字符串
 *  @param font        字符大小
 *  @param lineSpacing 每行间距
 *  @param range       字符串的位置
 *
 *  @return NSAttributedString
 */
+ (NSAttributedString *)cal_attributedStringRangeAddLineSpacing:(NSString *)string
                                                           font:(CGFloat)font
                                                    lineSpacing:(CGFloat)lineSpacing
                                                          range:(NSRange)range;

@end
