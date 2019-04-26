//
//  AnimationModel.h
//  BaseAnimationView
//
//  Created by KOCHIAEE6 on 2019/4/26.
//  Copyright © 2019 KOCHIAEE6. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimationModel : NSObject
@property(nonatomic, copy)NSString *keyPaths;
@property(nonatomic, strong) NSNumber *fromValue;
@property(nonatomic, strong) NSNumber *toValue;

@end

NS_ASSUME_NONNULL_END
