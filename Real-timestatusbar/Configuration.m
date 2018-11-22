//
//  Configuration.m
//  Real-timestatusbar
//
//  Created by Jiaxin on 2018/11/22.
//  Copyright © 2018年 Jiaxin. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration

+(instancetype)Configurationinformation
{
    static NSTimeInterval defaultAnimationDuration = 0.2;
    static NSTimeInterval defaultThrottleDelay = 0.2;
    static UIStatusBarAnimation defaultAnimationType = UIStatusBarAnimationFade;
    static CGFloat defaultMidPoint = 0.6;
    static CGFloat defaultAntiFlickRange = 0.08;
    Configuration *model = [Configuration new];
    model.animationDuration = defaultAnimationDuration;
    model.animationType = defaultAnimationDuration;
    model.midPoint = defaultMidPoint;
    model.antiFlickRange = defaultAntiFlickRange;
    model.throttleDelay = defaultThrottleDelay;
    
    return model;
}

@end
