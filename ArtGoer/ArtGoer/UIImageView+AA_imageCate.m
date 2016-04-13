//
//  UIImageView+AA_imageCate.m
//  ArtGoer
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "UIImageView+AA_imageCate.h"
#define noDisableVerticalScrollTag 6666
#define noDisableHorizontalScrollTag 1111

@implementation UIImageView (AA_imageCate)

//- (void) setAlpha:(float)alpha {
//    
//    if (self.superview.tag == noDisableVerticalScrollTag) {
//        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleLeftMargin) {
//            if (self.frame.size.width < 10 && self.frame.size.height > self.frame.size.width) {
//                UIScrollView *sc = (UIScrollView*)self.superview;
//                if (sc.frame.size.height < sc.contentSize.height) {
//                    return;
//                }
//            }
//        }
//    }
//    
//    if (self.superview.tag == noDisableHorizontalScrollTag) {
//        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleTopMargin) {
//            if (self.frame.size.height < 10 && self.frame.size.height < self.frame.size.width) {
//                UIScrollView *sc = (UIScrollView*)self.superview;
//                if (sc.frame.size.width < sc.contentSize.width) {
//                    return;
//                }
//            }
//        }
//    }
//    
//    [super setAlpha:alpha];
//}
@end

