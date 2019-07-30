//
//  FirstAppStartManager.m
//  Touqiu
//
//  Created by Zhang on 2019/7/30.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

#import "FirstAppStartManager.h"
#import "KSGuaidViewManager.h"
#import <UIKit/UIKit.h>

@implementation FirstAppStartManager


- (void)setUpStartApp{
    KSGuaidManager.images = @[[UIImage imageNamed:@"guid01"],
                              [UIImage imageNamed:@"guid02"],
                              [UIImage imageNamed:@"guid03"],
                              [UIImage imageNamed:@"guid04"]];
    
    /*
     方式一:
     
     CGSize size = [UIScreen mainScreen].bounds.size;
     
     KSGuaidManager.dismissButtonImage = [UIImage imageNamed:@"hidden"];
     
     KSGuaidManager.dismissButtonCenter = CGPointMake(size.width / 2, size.height - 80);
     */
    
    //方式二:
    KSGuaidManager.shouldDismissWhenDragging = YES;
    
    [KSGuaidManager begin];
}
@end
