//
//  ViewController.m
//  LCSafariViewControllerDemo
//
//  Created by 罗川 on 2019/8/25.
//  Copyright © 2019 luochuan. All rights reserved.
//

#import "ViewController.h"

#import <SafariServices/SafariServices.h>

#import "LCActivity.h"
@interface ViewController ()<SFSafariViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self presentToSafariViewController];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //自定义跳转方式二 设置
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)presentToSafariViewController{
    
    SFSafariViewController * sf;
    
    /*
     *  初始化方法一:适用iOS9.0及以上
     *
     *  @param url 注意:1,不能加载本地HTML文件(已在模拟器测试过); 2,URL需要加https://或者http:// 否则会崩溃
     */
    //sf = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://strictfrog.com"]];//API_AVAILABLE(ios(9.0, *))
    
    
    /*
     *  初始化方法二:适用iOS9.0~iOS11.0 和 iOS11.0及以上
     *
     *  @param url 注意:1,不能加载本地HTML文件(已在模拟器测试过); 2,URL需要加https://或者http:// 否则会崩溃
     *
     *  @param entersReaderIfAvailable 是否能开启阅读模式 只适用iOS9.0~iOS11.0
     *
     *  @param SFSafariViewControllerConfiguration 配置文件 适用iOS11.0及以上 属性entersReaderIfAvailable:是否能开启阅读模式; 属性barCollapsingEnabled: 滑动网页时是否隐藏导航栏和标签栏
     */
    if (@available(iOS 11.0, *)) {
        SFSafariViewControllerConfiguration * sfConfig = [[SFSafariViewControllerConfiguration alloc]init];//API_AVAILABLE(ios(11.0))
        sfConfig.entersReaderIfAvailable = YES;
        sfConfig.barCollapsingEnabled = YES;
        sf = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://strictfrog.com"] configuration:sfConfig];
    }else{
        sf = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://strictfrog.com"] entersReaderIfAvailable:YES];//API_AVAILABLE(ios(9.0, 11.0))
    }
    
    sf.delegate = self;
    
    /*
     *  设置SFSafariViewController属性
     *
     *  preferredBarTintColor:导航栏和标签栏背景颜色 (建议run一下) 只适用iOS10.0及以上
     *
     *  preferredControlTintColor 导航栏和标签栏里的字颜色 (建议run一下) 只适用iOS10.0及以上
     *
     *  dismissButtonStyle 返回按钮的样式 Done/Cancel/Close 这三种字都已做了文字国际化 只适用iOS11.0及以上
     */
    if (@available(iOS 10.0, *)) {
        sf.preferredBarTintColor = [UIColor lightGrayColor];
        sf.preferredControlTintColor = [UIColor blackColor];
        
        if (@available(iOS 11.0, *)) {
            sf.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleCancel;
        }
    }
    
    /*
     *  跳转方式一: 默认
     */
//    [self presentViewController:sf animated:YES completion:nil];
    
    
    /*
     *  自定义跳转方式二:
     */
    [self.navigationController pushViewController:sf animated:YES];
    
    
}



#pragma mark ------SFSafariViewControllerDelegate--------

/*
 *  点击分享按钮,UIActivityViewController弹出窗口将要显示的时候, 调用该方法
 *
 *  @param URL 当前网页的URL
 *
 *  @param title 当前网页的title
 *
 *  @result 返回一个UIActivity数组, 可以自定义添加UIActivity到数组中
 */

- (NSArray<UIActivity *> *)safariViewController:(SFSafariViewController *)controller activityItemsForURL:(NSURL *)URL title:(nullable NSString *)title{
    LCActivity * activity = [[LCActivity alloc]init];
    
    
    return @[activity];
}

/*
 *  过滤safari浏览器点击分享按钮,弹出窗口中的内容
 *
 *  @param URL 当前网页的URL
 *
 *  @param title 当前网页的title
 *
 *  @result 返回一个数组, 数组中包含你要过滤掉的UIActivityType类型, 默认是不过滤
 */
- (NSArray<UIActivityType> *)safariViewController:(SFSafariViewController *)controller excludedActivityTypesForURL:(NSURL *)URL title:(nullable NSString *)title API_AVAILABLE(ios(11.0)){
    /**
     UIActivityTypePostToFacebook      发送到Facebook
     UIActivityTypePostToTwitter       发送到Twitter
     UIActivityTypePostToWeibo         发送到微博
     UIActivityTypeMessage             发送到Message
     UIActivityTypeMail                发送到Mail
     UIActivityTypePrint               打印
     UIActivityTypeCopyToPasteboard    拷贝到粘贴板
     UIActivityTypeAssignToContact     发送给指定联系人
     UIActivityTypeSaveToCameraRoll    保存到相机
     UIActivityTypeAddToReadingList    添加到阅读标签
     UIActivityTypePostToFlickr        发送到Flicker
     UIActivityTypePostToVimeo         发送到Vimeo
     UIActivityTypePostToTencentWeibo  发送到腾讯微博
     UIActivityTypeAirDrop             传送给Airdrop
     UIActivityTypeOpenInIBooks        打开iBooks
     UIActivityTypeMarkupAsPDF         作为PDF收藏
     */
    return @[UIActivityTypeAddToReadingList];
}

/*
 *  点击左上角Done/Cancel/Close按钮
 */
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
    //自定义跳转方式二 设置
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 *  只有初始化加载页面完成加载一次
 *
 *  @param didLoadSuccessfully  YES:加载成功;NO:加载失败
 */
- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully{
    
}

/*
 *  重定向url 只适用iOS11.0及以上
 *
 *  @param URL  网页重定向时会调用该方法,并且返回重定向页面的URL
 */
- (void)safariViewController:(SFSafariViewController *)controller initialLoadDidRedirectToURL:(NSURL *)URL API_AVAILABLE(ios(11.0)){

}
@end
