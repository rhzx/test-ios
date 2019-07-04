//
//  JSCallOCViewController.m
//  SensorsAnalyticsSDK
//
//  Created by 王灼洲 on 16/9/6.
//  Copyright © 2015－2018 Sensors Data Inc. All rights reserved.
//

#import "JSCallOCViewController.h"
#import "SensorsAnalyticsSDK.h"

@implementation JSCallOCViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.title = @"UIWebView";

//    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"test2.html"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
//    [webView loadRequest:request];

    webView.delegate = self;

    //网址
    NSString *httpStr=@"http://192.168.1.22:81/sa/app.htm?from=ios&a=1#hashjs?b=2&c=3s";
    NSURL *httpUrl=[NSURL URLWithString:httpStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:httpUrl];
    
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([[SensorsAnalyticsSDK sharedInstance] showUpWebView:webView WithRequest:request enableVerify:NO]) {
        return NO;
    }
    // 官方教程说设置enableVerify:YES, 但实际测试要为NO才能发送
    [[SensorsAnalyticsSDK sharedInstance] showUpWebView:webView WithRequest:request enableVerify:NO];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //[[SensorsAnalyticsSDK sharedInstance] showUpWebView:webView];
}

@end
