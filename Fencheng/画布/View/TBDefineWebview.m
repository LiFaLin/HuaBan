//
//  MyWebView.m
//  textView
//
//  Created by jun zhao on 16/9/8.
//  Copyright © 2016年 jun zhao. All rights reserved.
//

#import "TBDefineWebview.h"

@implementation TBDefineWebview

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self becomeFirstResponder];
    }
    return self;
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // cut:剪切 / copy:复制 / paste:粘贴
    if (action == @selector(select:)  || action == @selector(selectAll:)) {
        return  YES;
    }
   return NO;
}
@end
