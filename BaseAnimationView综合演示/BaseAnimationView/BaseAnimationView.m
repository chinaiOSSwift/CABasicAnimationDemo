//
//  BaseAnimationView.m
//  BaseAnimationView
//
//  Created by KOCHIAEE6 on 2019/4/26.
//  Copyright © 2019 KOCHIAEE6. All rights reserved.
//

/**
 属性    说明
 duration    动画的时长
 repeatCount    重复的次数。不停重复设置为 HUGE_VALF
 repeatDuration    设置动画的时间。在该时间内动画一直执行，不计次数。
 beginTime    指定动画开始的时间。从开始延迟几秒的话，设置为【CACurrentMediaTime() + 秒数】 的方式
 timingFunction    设置动画的速度变化
 autoreverses    动画结束时是否执行逆动画
 fromValue    所改变属性的起始值
 toValue    所改变属性的结束时的值
 byValue    所改变属性相同起始值的改变量
 
 */



#import "BaseAnimationView.h"
#import "AnimationModel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#ifndef AnimationKeyPathName_h
#define AnimationKeyPathName_h
#import <Foundation/Foundation.h>
/* CATransform3D Key Paths */
/* 旋转x,y,z分别是绕x,y,z轴旋转 */
static NSString *kCARotation = @"transform.rotation";
static NSString *kCARotationX = @"transform.rotation.x";
static NSString *kCARotationY = @"transform.rotation.y";
static NSString *kCARotationZ = @"transform.rotation.z";

/* 缩放x,y,z分别是对x,y,z方向进行缩放 */
static NSString *kCAScale = @"transform.scale";
static NSString *kCAScaleX = @"transform.scale.x";
static NSString *kCAScaleY = @"transform.scale.y";
static NSString *kCAScaleZ = @"transform.scale.z";

/* 平移x,y,z同上 */
static NSString *kCATranslation = @"transform.translation";
static NSString *kCATranslationX = @"transform.translation.x";
static NSString *kCATranslationY = @"transform.translation.y";
static NSString *kCATranslationZ = @"transform.translation.z";

/* 平面 */
/* CGPoint中心点改变位置，针对平面 */
static NSString *kCAPosition = @"position";
static NSString *kCAPositionX = @"position.x";
static NSString *kCAPositionY = @"position.y";

/* CGRect */
static NSString *kCABoundsSize = @"bounds.size";
static NSString *kCABoundsSizeW = @"bounds.size.width";
static NSString *kCABoundsSizeH = @"bounds.size.height";
static NSString *kCABoundsOriginX = @"bounds.origin.x";
static NSString *kCABoundsOriginY = @"bounds.origin.y";

/* 透明度 */
static NSString *kCAOpacity = @"opacity";
/* 背景色 */
static NSString *kCABackgroundColor = @"backgroundColor";
/* 圆角 */
static NSString *kCACornerRadius = @"cornerRadius";
/* 边框 */
static NSString *kCABorderWidth = @"borderWidth";
/* 阴影颜色 */
static NSString *kCAShadowColor = @"shadowColor";
/* 偏移量CGSize */
static NSString *kCAShadowOffset = @"shadowOffset";
/* 阴影透明度 */
static NSString *kCAShadowOpacity = @"shadowOpacity";
/* 阴影圆角 */
static NSString *kCAShadowRadius = @"shadowRadius";
#endif /* AnimationKeyPathName_h */

@interface BaseAnimationView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *squareView;
@property (nonatomic, strong) UILabel *squareLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation BaseAnimationView

- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        [self initData];
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.squareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
    self.squareView.backgroundColor = [UIColor cyanColor];
    self.squareView.layer.borderColor = [UIColor redColor].CGColor;
    self.squareView.center = CGPointMake(SCREEN_WIDTH/2.0, 200);
    self.squareView.layer.shadowOpacity = 0.6;
    self.squareView.layer.shadowOffset = CGSizeMake(0, 0);
    self.squareView.layer.shadowRadius = 4;
    self.squareView.layer.shadowColor = [UIColor redColor].CGColor;
    [self addSubview:self.squareView];
    
    self.squareLabel = [[UILabel alloc] initWithFrame:self.squareView.bounds];
    self.squareLabel.text = @"label";
    self.squareLabel.textAlignment = NSTextAlignmentCenter;
    self.squareLabel.textColor = [UIColor blackColor];
    self.squareLabel.font = [UIFont systemFontOfSize:17];
    [self.squareView addSubview:self.squareLabel];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, SCREEN_HEIGHT-400) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
}

- (CABasicAnimation *)getAnimationKeyPath:(NSString *)keyPath fromValue:(id)fromValue toValue:(id)toValue{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    basicAnimation.fromValue = fromValue;
    /*byvalue是在fromvalue的值的基础上增加量*/
    //basicAnimation.byValue = @1;
    basicAnimation.toValue = toValue;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];;
    basicAnimation.duration = 2;
    basicAnimation.repeatCount = 1;
    /* animation remove from view after animation finish */
    basicAnimation.removedOnCompletion = YES;
    return basicAnimation;
}
- (void)initData{
    /*
     kCAScaleZ 缩放z 没有意义，因为是平面图形
     kCAPositionX设置y没有意义，可以随意设置，同理kCAPositionY设置x没有意义
     kCABackgroundColor,颜色变化必须要用CGColor
     用到shadow的几个属性变化的时候，需要先设置shadow
     */
    NSValue *startPoint = [NSValue valueWithCGPoint:self.squareView.center];
    NSValue *endPoint = [NSValue valueWithCGPoint:CGPointMake(500, 500)];
    NSValue *shadowStartPoint = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue *shadowEndPoint = [NSValue valueWithCGPoint:CGPointMake(5, 5)];
    id startColor = (id)([UIColor cyanColor].CGColor);
    id endColor = (id)([UIColor redColor].CGColor);
    id shadowStartColor = (id)[UIColor clearColor].CGColor;
    id shadowEndColor = (id)[UIColor redColor].CGColor;
    self.dataSource = [NSMutableArray array];
    NSArray *keypaths   = @[kCARotation,kCARotationX,kCARotationY,kCARotationZ,
                            kCAScale,kCAScaleX,kCAScaleZ,kCAPositionX,
                            kCABoundsSizeW,kCAOpacity,kCABackgroundColor,kCACornerRadius,
                            kCABorderWidth,kCAShadowColor,kCAShadowRadius,kCAShadowOffset];
    
    NSArray *fromValues = @[@0,@0,@0,@0,@0,@0,@0,startPoint,@100,@1,startColor,@0, @0,shadowStartColor,@0,shadowStartPoint];
    
    NSArray *toValues   = @[@(M_PI),@(M_PI),@(M_PI),@(M_PI),
                            @1,@1,@1,endPoint,
                            @200,@0,endColor,@40,
                            @4,shadowEndColor,@8,shadowEndPoint];
    for (int i=0; i<keypaths.count; i++) {
        AnimationModel *model = [[AnimationModel alloc] init];
        model.keyPaths = keypaths[i];
        model.fromValue = fromValues[i];
        model.toValue = toValues[i];
        [self.dataSource addObject:model];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AnimationModel *model = [self.dataSource objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text = model.keyPaths;
    cell.selectionStyle = 0;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AnimationModel *model = [self.dataSource objectAtIndex:indexPath.row];
    CABasicAnimation *animation = [self getAnimationKeyPath:model.keyPaths fromValue:model.fromValue toValue:model.toValue];
    [self.squareView.layer addAnimation:animation forKey:nil];
}


@end
