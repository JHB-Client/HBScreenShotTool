//
//  ViewController.m
//  HBScreenShotDemo
//
//  Created by admin on 2019/12/2.
//  Copyright © 2019 admin. All rights reserved.
//

#import "ViewController.h"
#import "HBScreenShotTool.h"
#import <WebKit/WebKit.h>
#import "WKWebView+ZFJViewCapture.h"

#import <Photos/Photos.h>
//#import "UIScrollView+ZFJCapture.h"
@interface ViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) WKWebView *webView;
@end


static int count = 0;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //1.
//    [[HBScreenShotTool defaultShotTool] screenShotFromView:self.view savedToAlbum:true];
    
    //2.
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(100, 100, 100, 500)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 0;
    [self.view addSubview:tableView];
    
//    //3.
//    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 500) configuration:webConfiguration];
//    NSString *urlStr = @"https://www.baidu.com";
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    [webView loadRequest:request];
//    webView.scrollView.delegate = self;
//    [self.view addSubview:webView];
//    self.webView = webView;
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
////    NSLog(@"----ssssss--:%lf", self.webView.scrollView.contentSize.height);
////    [[HBScreenShotTool defaultShotTool] screenShotView:self.webView.scrollView savedToAlbum:true];
//
//    [self.webView ZFJContentCaptureCompletionHandler:^(UIImage *capturedImage) {
////        NSLog(@"-----ssssssss--:%lf", capturedImage.size.height);
//
//        UIImageWriteToSavedPhotosAlbum(capturedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//    }];
//}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"-------%ld", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [[HBScreenShotTool defaultShotTool] screenShotView:tableView savedToAlbum:true];
        
//        [tableView ZFJContentCaptureCompletionHandler:^(UIImage *capturedImage) {
//            UIImageWriteToSavedPhotosAlbum(capturedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//        }];
    }
}

@end
