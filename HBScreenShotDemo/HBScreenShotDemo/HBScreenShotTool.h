//
//  HBScreenShotTool.h
//  HBScreenShotDemo
//
//  Created by admin on 2019/12/2.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HBScreenShotTool : NSObject
+ (instancetype)defaultShotTool;

// tabelView的estimatedRowHeight需要设置下，否则无法计算出准确的contentSize。
- (void)screenShotView:(UIView *)view complete:(void (^)(UIImage * _Nonnull shotImg))complete;
- (void)screenShotView:(UIView *)view savedToAlbum:(BOOL)savedToAlbum;
- (void)screenShotView:(UIView *)view savedToAlbum:(BOOL)savedToAlbum complete:(void (^)(UIImage * _Nonnull shotImg))complete;
- (void)screenShotView:(UIView *)view transparent:(BOOL)transparent savedToAlbum:(BOOL)savedToAlbum complete:(void (^)(UIImage * _Nonnull shotImg))complete;
@property (nonatomic, copy) void(^shotImgSavedToAlbum)(NSError *error);
@end

NS_ASSUME_NONNULL_END
