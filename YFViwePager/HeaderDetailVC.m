//
//  HeaderDetailVC.m
//  YFViwePager
//
//  Created by HO on 16/4/4.
//  Copyright © 2016年 HO. All rights reserved.
//

#import "HeaderDetailVC.h"

@interface HeaderDetailVC ()

@property (nonatomic,strong) UIWebView * webView;

@end

@implementation HeaderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadeWeb:self.url];
}

- (void)loadeWeb:(NSString *)url{
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    self.webView = [[UIWebView alloc] initWithFrame:rect];
    
    NSURLRequest * requestobj = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:requestobj];
    
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
