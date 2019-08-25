//
//  LCActivity.m
//  LCSafariViewControllerDemo
//
//  Created by 罗川 on 2019/8/25.
//  Copyright © 2019 luochuan. All rights reserved.
//

#import "LCActivity.h"

@implementation LCActivity
- (NSString *)activityType {
    
    return @"CustomActivity";
}

- (NSString *)activityTitle {
    
    return @"自定义Activity";
}

- (UIImage *)activityImage {//只有iOS8才支持彩色,所以不建议使用彩色照片
    
    
    return [UIImage imageNamed:@"luochuan"];
}

- (void)performActivity {
    [self activityDidFinish:YES];
    
    if (self.activityBlock) {
        self.activityBlock();
    }
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    
    if (activityItems.count > 0) {
        
        return YES;
    }
    
    return NO;
}

@end
