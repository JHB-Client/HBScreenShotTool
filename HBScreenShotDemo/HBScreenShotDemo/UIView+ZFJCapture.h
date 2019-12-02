//
//  UIView+ZFJCapture.h
//  FingerprintUnlock.git
//
//  Created by ZFJ on 2016/10/31.
//  Copyright © 2016年 张福杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZFJCapture)

- (BOOL)ZFJContainsWKWebView;

- (void)ZFJCaptureCompletionHandler:(void(^)(UIImage *capturedImage))completionHandler;

- (void)ZFJSetFrame:(CGRect)frame;

@end
