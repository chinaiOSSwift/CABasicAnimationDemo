//
//  UIView+HPAdditions.h
//  BaseAnimationView
//
//  Created by KOCHIAEE6 on 2019/4/26.
//  Copyright © 2019 KOCHIAEE6. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HPAdditions)
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@end

NS_ASSUME_NONNULL_END
