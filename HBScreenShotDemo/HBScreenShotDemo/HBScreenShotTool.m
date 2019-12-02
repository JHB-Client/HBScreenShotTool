//
//  HBScreenShotTool.m
//  HBScreenShotDemo
//
//  Created by admin on 2019/12/2.
//  Copyright © 2019 admin. All rights reserved.
//

#import "HBScreenShotTool.h"
#import <Photos/Photos.h>

static HBScreenShotTool *shotTool;
@implementation HBScreenShotTool
+ (instancetype)defaultShotTool {
    return [[self alloc] init];
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shotTool = [super init];
    });
    return shotTool;
}
+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shotTool = [super allocWithZone:zone];
    });
    return shotTool;
}
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return shotTool;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return shotTool;
}


- (void)screenShotView:(UIView *)view complete:(void (^)(UIImage * _Nonnull))complete {
    [self screenShotView:view transparent:false savedToAlbum:true complete:^(UIImage * _Nonnull shotImg) {
        if (complete && shotImg) {
            complete(shotImg);
        }
    }];
}


- (void)screenShotView:(UIView *)view savedToAlbum:(BOOL)savedToAlbum {
    [self screenShotView:view transparent:false savedToAlbum:savedToAlbum complete:^(UIImage * _Nonnull shotImg) {}];
}


- (void)screenShotView:(UIView *)view savedToAlbum:(BOOL)savedToAlbum complete:(void (^)(UIImage * _Nonnull shotImg))complete {
    [self screenShotView:view transparent:false savedToAlbum:savedToAlbum complete:^(UIImage * _Nonnull shotImg) {
        if (complete && shotImg) {
            complete(shotImg);
        }
    }];
}

- (void)screenShotView:(UIView *)view transparent:(BOOL)transparent savedToAlbum:(BOOL)savedToAlbum complete:(void (^)(UIImage * _Nonnull shotImg))complete {
    
    UIImage *shotImg = nil;
    if ([view isKindOfClass:UIScrollView.class]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        CGPoint contentOffSetSaved = scrollView.contentOffset;
        CGRect frameSaved = scrollView.frame;
        //
        [scrollView setContentOffset:CGPointZero];
        [scrollView setFrame:CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)];
        //
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, transparent, [UIScreen mainScreen].scale);
        [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
        shotImg = UIGraphicsGetImageFromCurrentImageContext();
        //
        [scrollView setContentOffset:contentOffSetSaved];
        [scrollView setFrame:frameSaved];
        //
        UIGraphicsEndImageContext();
    } else {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, transparent, [UIScreen mainScreen].scale);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
        shotImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    //
    if (shotImg) {
        if (savedToAlbum == true) {
            UIImageWriteToSavedPhotosAlbum(shotImg, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
        
        if (complete) {
            complete(shotImg);
        }
        
    } else {
        NSLog(@"error:------截取失败");
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    //
    if (self.shotImgSavedToAlbum) {
        self.shotImgSavedToAlbum(error);
    }
}
@end
