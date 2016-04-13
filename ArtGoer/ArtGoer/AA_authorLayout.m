//
//  AA_authorLayout.m
//  ArtGoer
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_authorLayout.h"
@implementation AA_authorLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


- (void)prepareLayout{
    
    self.minimumLineSpacing = 75 * AHEIGHT;
    self.minimumInteritemSpacing = 50 * AWIDTH;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(150 * AHEIGHT, 50 * AWIDTH, 150 * AHEIGHT, 50 * AWIDTH);
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *atts = [super layoutAttributesForElementsInRect:rect];
    CGRect visRect;
    
    visRect.size = self.collectionView.frame.size;
    visRect.origin = self.collectionView.contentOffset;
    for (UICollectionViewLayoutAttributes *temp in atts) {
        if (!CGRectIntersectsRect(visRect, temp.frame)) continue;
        temp.alpha = 1 - 0.375 * 1.25 * AWIDTH;
        if (temp.center.x - temp.frame.size.width + 12.5 * AWIDTH < self.collectionView.contentOffset.x && temp.center.x - temp.frame.size.width + 87.5 * AWIDTH > self.collectionView.contentOffset.x) {
            CGFloat count = 1.375 - (ABS(self.collectionView.contentOffset.x - temp.center.x + temp.frame.size.width - 50 * AWIDTH)) / 100 * AWIDTH;
            temp.transform3D = CATransform3DMakeScale(count, count, 0);
            temp.alpha = 1 - 0.375 * 1.25 * AWIDTH + (ABS(self.collectionView.contentOffset.x - temp.center.x + temp.frame.size.width - 50 * AWIDTH)) / 100 * 1.25 * AWIDTH;
        }
    }
        return atts;
}

@end
