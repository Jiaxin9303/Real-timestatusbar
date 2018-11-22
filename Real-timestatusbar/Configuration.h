//
//  Configuration.h
//  Real-timestatusbar
//
//  Created by Jiaxin on 2018/11/22.
//  Copyright © 2018年 Jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Configuration : NSObject

@property (nonatomic,assign) NSTimeInterval animationDuration;
@property (nonatomic,assign) UIStatusBarAnimation animationType;
@property (nonatomic,assign) CGFloat midPoint;
@property (nonatomic,assign) CGFloat antiFlickRange;
@property (nonatomic,assign) NSTimeInterval throttleDelay;
+ (instancetype)Configurationinformation;

@end
