//
//  LYView.m
//  HollowOutView&Window
//
//  Created by Leonidas.Luo on 2/13/20.
//  Copyright © 2020 Leonidas.Luo. All rights reserved.
//

#import "LYView.h"
@implementation LYView

- (void)drawRect:(NSRect)dirtyRect {
    NSLog(@"%s begin", __func__);

    [super drawRect:dirtyRect];
    
    [[[NSColor orangeColor] colorWithAlphaComponent:0.8] set];
    NSRectFill(dirtyRect);
    NSLog(@"orangeColor");
//    [[[NSColor redColor] colorWithAlphaComponent:0.8] set];
//    NSRectFill(dirtyRect);
//
//    [[NSColor clearColor] set];
//    NSRectFill(dirtyRect);
    
    NSLog(@"%s end", __func__);

}





@end
