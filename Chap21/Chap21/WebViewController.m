//
//  WebViewController.m
//  Chap21
//
//  Created by New on 9/9/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

-(void)loadView
{
    UIWebView * webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    self.view = webView;
}

-(void)setUrl:(NSURL *)url
{
    _url = url;
    if (_url)
    {
        NSURLRequest * req = [NSURLRequest requestWithURL:_url];
        [(UIWebView *)self.view loadRequest:req];
    }
}

@end
