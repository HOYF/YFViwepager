//
//  ViewController.m
//  YFViwePager
//
//  Created by HO on 16/4/4.
//  Copyright © 2016年 HO. All rights reserved.
//

#import "ViewController.h"
#import "YFViwepager.h"
#import "HeaderDetailVC.h"

//3.遵守协议
@interface ViewController ()<headerTap>

@property (nonatomic,strong) NSArray * headerDetailUrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerDetailUrl = @[@"http://guide.fengjing.com/604806/41236_1.shtml",
                             @"http://ly.fengjing.com/ad/newVersion.html",
                             @"http://ly.fengjing.com/ad/travel99.html"];
    
    UITableView * tableV = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:tableV];
    
    YFViwepager *viwepager = [YFViwepager viwepagerWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    //协议关联
    viwepager.delegate = self;
    viwepager.imageType = YES;
    
    if (viwepager.imageType == YES) {
        viwepager.imageNames = @[@"http://lingyou.co/imgServer/201603/d8bd34a8-83b5-43b5-8d55-647c74ef3fce.png",
                              @"http://lingyou.co/imgServer/201603/1f019400-c436-4dc9-8fde-9d29a9a814c0.png",
                              @"http://lingyou.co/imgServer/201601/208f6dcd-ddff-4ac3-8c0e-237751538b96.png"];
    }else{
        viwepager.imageNames = @[@"1.png",@"2.png",@"3.png"];
    }
    
    tableV.tableHeaderView = viwepager;

}

#pragma mark - headerTap 协议方法实现
- (void)returnFlog:(NSInteger)flog{
    
    HeaderDetailVC * headerVC = [[HeaderDetailVC alloc] init];

    headerVC.url = self.headerDetailUrl[flog - 100];
    
    [self.navigationController pushViewController:headerVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
