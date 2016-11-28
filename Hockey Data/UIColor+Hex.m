//
//  UIColor+Hex.m
//  Hockey Data
//
//  Created by Alex King on 11/22/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    if ([hexString characterAtIndex:0] == '#') {
        [scanner setScanLocation:1]; // bypass '#' character
    } else {
        [scanner setScanLocation:0];
    }
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
