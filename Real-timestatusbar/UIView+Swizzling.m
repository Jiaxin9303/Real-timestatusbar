//
//  UIView+Swizzling.m
//  Real-timestatusbar
//
//  Created by Jiaxin on 2018/11/22.
//  Copyright © 2018年 Jiaxin. All rights reserved.
//

#import "UIView+Swizzling.h"
#import <objc/runtime.h>
#import "Configuration.h"

@implementation UIView (Swizzling)

+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
        Method layoutSubviews = class_getInstanceMethod(self, @selector(layoutSubviews));
        Method loglayoutSubviews = class_getInstanceMethod(self, @selector(logviewDidLayoutSubviews));
        
        //两方法进行交换
        method_exchangeImplementations(layoutSubviews, loglayoutSubviews);
        
//    });
}
- (void)logviewDidLayoutSubviews {
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"%@ will appear",className);
    [self calculateStatusBarAreaAvgLuminance];
}
-(void)calculateStatusBarAreaAvgLuminance{
    UIGraphicsBeginImageContext([UIApplication sharedApplication].statusBarFrame.size);   //self为需要截屏的UI控件 即通过改变此参数可以截取特定的UI控件
    
    [[self currentViewController].view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"image:%@",image); //至此已拿到image
    CGImageRef inImage = image.CGImage;
    
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    
    if (cgctx == NULL) {
        
    }
    
    size_t w = CGImageGetWidth(inImage);
    
    size_t h = CGImageGetHeight(inImage);
    
    CGRect rect = {{0,0},{w,h}};
    
    CGContextDrawImage(cgctx, rect, inImage);
    
    unsigned char* data = CGBitmapContextGetData (cgctx);
    
    if (data != NULL) {
        int offset = 4*((w*round(0))+round(0));
        
        int alpha =  data[offset];
        
        int red = data[offset+1];
        
        int green = data[offset+2];
        
        int blue = data[offset+3];
        
        CGFloat luminance = 0.212 * red + 0.715 * green + 0.073 * blue;
        Configuration *configuration = [Configuration Configurationinformation];
        CGFloat antiFlick = configuration.antiFlickRange / 2;
        if (luminance <= configuration.midPoint - antiFlick)
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            
        }else
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }
        NSLog(@"324532");
    }
    CGContextRelease(cgctx);
    if (data) { free(data); }
}
- (UIViewController*)currentViewController{
    
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            
            break;
        }
    }
    return vc;
}
- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
    
    CGColorSpaceRef colorSpace;
    
    void *          bitmapData;
    
    int             bitmapByteCount;
    
    int             bitmapBytesPerRow;
    
    size_t pixelsWide = CGImageGetWidth(inImage);
    
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    bitmapBytesPerRow   = (pixelsWide * 4);
    
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
        
    {
        
        fprintf(stderr, "Error allocating color space\n");
        
        return NULL;
        
    }
    
    
    bitmapData = malloc( bitmapByteCount );
    
    if (bitmapData == NULL)
        
    {
        
        fprintf (stderr, "Memory not allocated!");
        
        CGColorSpaceRelease( colorSpace );
        
        return NULL;
        
    }
    context = CGBitmapContextCreate (bitmapData,
                                     
                                     pixelsWide,
                                     
                                     pixelsHigh,
                                     
                                     8,      // bits per component
                                     
                                     bitmapBytesPerRow,
                                     
                                     colorSpace,
                                     
                                     kCGImageAlphaPremultipliedFirst);
    
    if (context == NULL)
    {
        free (bitmapData);
        
        fprintf (stderr, "Context not created!");
        
    }
    CGColorSpaceRelease( colorSpace );
    
    return context;
    
}

@end
