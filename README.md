# CABasicAnimationDemo
CABasicAnimation综合演示
设定动画的属性和说明
属性          说明
duration    动画的时长
repeatCount    重复的次数。不停重复设置为 HUGE_VALF
repeatDuration    设置动画的时间。在该时间内动画一直执行，不计次数。
beginTime    指定动画开始的时间。从开始延迟几秒的话，设置为【CACurrentMediaTime() + 秒数】 的方式
timingFunction    设置动画的速度变化
autoreverses    动画结束时是否执行逆动画
fromValue    所改变属性的起始值
toValue    所改变属性的结束时的值
byValue    所改变属性相同起始值的改变量


一些常用的animationWithKeyPath值的总结
值                         说明    使用形式
transform.scale    比例转化    @(0.8)
transform.scale.x    宽的比例    @(0.8)
transform.scale.y    高的比例    @(0.8)
transform.rotation.x    围绕x轴旋转    @(M_PI)
transform.rotation.y    围绕y轴旋转    @(M_PI)
transform.rotation.z    围绕z轴旋转    @(M_PI)
cornerRadius    圆角的设置    @(50)
backgroundColor    背景颜色的变化    (id)[UIColor purpleColor].CGColor
bounds    大小，中心不变    [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
position    位置(中心点的改变)    [NSValue valueWithCGPoint:CGPointMake(300, 300)];
contents    内容，比如UIImageView的图片    imageAnima.toValue = (id)[UIImage imageNamed:@"to"].CGImage;
opacity    透明度    @(0.7)
contentsRect.size.width    横向拉伸缩放    @(0.4)最好是0~1之间的



#### CASpringAnimation
1.什么是CASpringAnimation
　　CASpringAnimation是在CABasicAnimation的基础上衍生的另一个动画类，它比CABasicAnimation多了动画的弹性，是动画不再是从一个状态变成另一个状态时显得生硬。CASpringAnimation是iOS9.0之后新加的。
　　
　　2.新增属性
　　@property CGFloat mass;       //质量（影响弹簧的惯性，质量越大，弹簧惯性越大，运动的幅度越大）
　　
　　@property CGFloat stiffness;  //弹性系数（弹性系数越大，弹簧的运动越快）
　　
　　@property CGFloat damping;    //阻尼系数（阻尼系数越大，弹簧的停止越快）
　　
　　@property CGFloat initialVelocity;  //初始速率（弹簧动画的初始速度大小，弹簧运动的初始方向与初始速率的正负一致，若初始速率为0，表示忽略该属性）
　　
　　@property CGFloat settlingDuration; //结算时间（根据动画参数估算弹簧开始运动到停止的时间，动画设置的时间最好根据此时间来设置）
　　
　　这三个属性可以设置动画在执行到最终状态后的弹性效果。
