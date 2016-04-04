//
//  YFViwepager.h
//  YFViwePager
//
//  Created by HO on 16/4/4.
//  Copyright © 2016年 HO. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  定义协议，并声明协议方法（谁遵守谁实现）
 *
 *  协议方法 传回一个参数 记录点击了哪张图片
 */
@protocol headerTap <NSObject>

- (void)returnFlog:(NSInteger)flog;

@end


@interface YFViwepager : UIView

/** 声明一个属性指针 指向协议对象*/
@property (nonatomic,weak) id<headerTap>delegate;

/** 公开scrollView 可以在其他类按需求设定scrollView的风格样式*/
@property (weak, nonatomic) UIScrollView *scrollView;

/** 设置UIPageControl的颜色 必须实现*/
@property (weak, nonatomic) UIColor * color;

/** 传入图片网址或者本地图片名称*/
@property (nonatomic, copy) NSArray *imageNames;

/** 类方法 创建该类并设定frame*/
+ (instancetype)viwepagerWithFrame:(CGRect)frame;

/**
 *  YES（网络图片） 代表传入的是一个网址接口，并且开启UIImageview交互
 *  NO  (本地)     代表传入本地的图片名称，关闭UIImageview交互
 */
@property (nonatomic,assign) BOOL imageType;



@end
