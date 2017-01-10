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
    
    //JS传值给OC
    
    //拿到网页的实时url
    NSString *requestStr = [[request.URL absoluteString] stringByRemovingPercentEncoding];
    
    //在url中寻找自定义协议头"objc://"
    if ([requestStr hasPrefix:@"objc://"]) {
        
        // 以"://"为中心将url分割成两部分，放进数组arr
        NSArray *arr = [requestStr componentsSeparatedByString:@"://"];
        
        //取其后半段
        NSString *paramStr = arr[1];
        
        //约定":/"为标识将后半段url分割成若干部分，放进数组arr2，此时arr2[0]为空，arr2[1]为第一个传参值，arr2[2]为第二个传参值，以此类推
        NSArray *arr2 = [paramStr componentsSeparatedByString:@":/"];
        
        //取出参数，进行使用
        if (arr2.count) {
            NSLog(@"有参数");
            //使用参数
        }else{
            NSLog(@"无参数");
        }
        return NO;
        
    }
    
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
    
    
    
    
    
    
    
    //2.1、JS调用OC (JS传值给OC)（使用JavaScriptCore.framework框架）
    context[@"passValue"] = ^{
        NSArray *arg = [JSContext currentArguments];
        for (id obj in arg) {
            NSLog(@"---%@", obj);
        }
    };
    //2.2、 JS传值给OC（使用自定义url方法）
    // 见shouldStartLoadWithRequest方法
    
    
    
    
    
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
