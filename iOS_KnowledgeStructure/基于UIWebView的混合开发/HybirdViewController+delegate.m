//
//  HybirdViewController+delegate.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2018/12/1.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "HybirdViewController+delegate.h"

@implementation HybirdViewController (delegate)
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"%@",request);
    return YES;
}

@end
