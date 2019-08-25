//
//  LCActivity.h
//  LCSafariViewControllerDemo
//
//  Created by 罗川 on 2019/8/25.
//  Copyright © 2019 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCActivity : UIActivity
@property (nonatomic, copy) void(^activityBlock)(void);

@end

