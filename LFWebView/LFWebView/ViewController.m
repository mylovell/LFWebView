//
//  ViewController.m
//  LFWebView
//
//  Created by wen on 2017/1/9.
//  Copyright © 2017年 罗峰. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic ,strong) UIWebView *lfWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadWebView];
}

- (void)loadWebView{
    
    [self.view addSubview:self.lfWebView];
    [self.lfWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.lfWebView loadRequest:request];
    
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //OC调用JS，给js传值
    
    //JS调用OC，给oc传值
    
    //获取webView中的内容
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{}


#pragma mark - 懒加载
-(UIWebView *)lfWebView{
    if (!_lfWebView) {
        _lfWebView = [[UIWebView alloc] init];
        _lfWebView.delegate = self;
    }
    return _lfWebView;
}


@end
