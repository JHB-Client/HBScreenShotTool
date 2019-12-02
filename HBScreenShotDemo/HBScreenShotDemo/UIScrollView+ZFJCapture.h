//
//  UIScrollView+ZFJCapture.h
//  FingerprintUnlock.git
//
//  Created by ZFJ on 2016/10/31.
//  Copyright © 2016年 张福杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ZFJCapture)

- (void)ZFJContentCaptureCompletionHandler:(void(^)(UIImage *capturedImage))completionHandler;

- (void)ZFJRenderImageViewCompletionHandler:(void(^)(UIImage *capturedImage))completionHandler;

- (void)ZFJContentScrollCaptureCompletionHandler:(void(^)(UIImage *capturedImage))completionHandler;

@end
