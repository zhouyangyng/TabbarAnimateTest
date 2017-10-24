//
//  MainTabBarController.m
//  tabbarTest
//
//  Created by mac1 on 2017/9/20.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "MainTabBarController.h"
#import "FirstViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MainTabBarController ()

@property (nonatomic, assign) NSInteger indexFlag;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViewController:[FirstViewController new] withTitle:@"首页" imageName:@"tabbar_home" withTag:0];
    
    [self addViewController:[FirstViewController new] withTitle:@"联系" imageName:@"tabbar_message" withTag:2];
    
    [self addViewController:[FirstViewController new] withTitle:@"我的" imageName:@"tabbar_profile" withTag:3];
}

#pragma mark -- 重写 didSelectItem方法
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (self.indexFlag != index) {
        [self animationWithIndex:index];
    }
}


// 动画
- (void)animationWithIndex:(NSInteger) index {
    
    NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
    //找到所有的 UITabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    //动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[[self scaleAnimation], [self rotationAnimation]];
    group.duration = 0.15;
    
    UIView *tabbarBtn = tabbarbuttonArray[index];
    //找到UITabBarButton中的imageView，加动画
    for (UIView *sub in tabbarBtn.subviews) {

        if ([sub isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {

            [sub.layer addAnimation:group forKey:nil];
            //音效
            AudioServicesPlaySystemSound(1109);
        }
    }
    
    self.indexFlag = index;
}

///大小的动画
- (CABasicAnimation *)scaleAnimation {
    
    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleAni.repeatCount = 1;
    scaleAni.autoreverses = YES;
    scaleAni.fromValue = [NSNumber numberWithFloat:1];
    scaleAni.toValue = [NSNumber numberWithFloat:0.5];
    
    return scaleAni;
}

///旋转的动画
- (CABasicAnimation *)rotationAnimation {
    
    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotateAni.fromValue = @(0);
    rotateAni.toValue = @(M_PI);
    rotateAni.repeatCount = 1;
    
    return rotateAni;
}


//添加子控制器
- (void)addViewController:(UIViewController *)vc withTitle:(NSString *)title imageName:(NSString *)imageName withTag:(NSInteger)tag{
    
    vc.title=title;
    
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    vc.tabBarItem.title=title;
    
    vc.tabBarItem.tag=tag;
    
    vc.tabBarController.tabBar.translucent = NO;
    
    //图片不被渲染
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //修改文字
    [vc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];

    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    
    [self addChildViewController:nav];
}


@end


