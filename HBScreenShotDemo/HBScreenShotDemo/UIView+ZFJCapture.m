//
//  UIView+ZFJCapture.m
//  FingerprintUnlock.git
//
//  Created by ZFJ on 2016/10/31.
//  Copyright © 2016年 张福杰. All rights reserved.
//

#import "UIView+ZFJCapture.h"
#import <objc/runtime.h>
#import <WebKit/WebKit.h>

@implementation UIView (ZFJCapture)

- (void)ZFJSetFrame:(CGRect)frame{
    // Do nothing, use for swizzling
}

- (BOOL)ZFJContainsWKWebView{
    if([self isKindOfClass:[WKWebView class]]){
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if([subView ZFJContainsWKWebView]){
            return YES;
        }
    }
    return NO;
}

- (void)ZFJCaptureCompletionHandler:(void(^)(UIImage *capturedImage))completionHandler{
    
    CGRect bounds = self.bounds;
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, false,[UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, - self.frame.origin.x, - self.frame.origin.y);

    if([self ZFJContainsWKWebView]){
        [self drawViewHierarchyInRect:bounds afterScreenUpdates:YES];
    }else{
        [self.layer renderInContext:context];
    }
    
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    
    completionHandler(capturedImage);
}

@end
