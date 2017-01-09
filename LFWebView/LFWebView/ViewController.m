//
//  ViewController.m
//  LFWebView
//
//  Created by wen on 2017/1/9.
//  Copyright © 2017年 罗峰. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import <JavaScriptCore/JavaScriptCore.h>

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
    
    //0、创建与JS的交互对象
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    
    //1、OC调用JS，给js传值
    NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码,test js OC就是OC传给JS的值
    [context evaluateScript:alertJS];//通过oc方法调用js的alert
    
    
    
    //2.1、JS调用OC，给oc传值
    context[@"passValue"] = ^{
        NSArray *arg = [JSContext currentArguments];
        for (id obj in arg) {
            NSLog(@"---%@", obj);
        }
    };
    
    
    
    //2.2、 JS调用OC
    
    
    
    //3、获取webView中的内容
    NSString *titleString = @"document.title";// 获取当前页面的title
    NSString *urlString = @"document.location.href";// 获取当前页面的url
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:titleString];
    
}


#pragma mark - 懒加载
-(UIWebView *)lfWebView{
    if (!_lfWebView) {
        _lfWebView = [[UIWebView alloc] init];
        _lfWebView.delegate = self;
    }
    return _lfWebView;
}


@end
