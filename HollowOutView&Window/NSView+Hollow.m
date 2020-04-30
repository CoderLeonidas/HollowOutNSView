//
//  NSView+Hollow.m
//  HollowOutView&Window
//
//  Created by Leonidas.Luo on 2/18/20.
//  Copyright © 2020 Leonidas.Luo. All rights reserved.
//

#import "NSView+Hollow.h"
#import "objc/runtime.h"

@implementation NSView (Hollow)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//
//        {
//            SEL originalSelector = @selector(drawRect:);
//            SEL swizzledSelector = @selector(hollow_drawRect:);
//
//            Method originalMethod = class_getInstanceMethod(class, originalSelector);
//            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//
//
//            BOOL didAddMethod =
//            class_addMethod(class,
//                            originalSelector,
//                            method_getImplementation(swizzledMethod),
//                            method_getTypeEncoding(swizzledMethod));
//
//            if (didAddMethod) {
//                class_replaceMethod(class,
//                                    swizzledSelector,
//                                    method_getImplementation(originalMethod),
//                                    method_getTypeEncoding(originalMethod));
//            } else {
//                method_exchangeImplementations(originalMethod, swizzledMethod);
//            }
//        }
        
        
//        {
//            SEL originalSelector = @selector(hitTest:);
//            SEL swizzledSelector = @selector(hollow_drawRect:);
//            
//            Method originalMethod = class_getInstanceMethod(class, originalSelector);
//            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//            
//            
//            BOOL didAddMethod =
//            class_addMethod(class,
//                            originalSelector,
//                            method_getImplementation(swizzledMethod),
//                            method_getTypeEncoding(swizzledMethod));
//            
//            if (didAddMethod) {
//                class_replaceMethod(class,
//                                    swizzledSelector,
//                                    method_getImplementation(originalMethod),
//                                    method_getTypeEncoding(originalMethod));
//            } else {
//                method_exchangeImplementations(originalMethod, swizzledMethod);
//            }
//        }
    });
}



- (NSView *)hollow_hitTest:(NSPoint)point {
    for (NSValue *areaValue in self.hollowoutAreaArray) {
        if (NSPointInRect(point, [areaValue rectValue])) {
            return nil;
        }
    }
    return [self hollow_hitTest:point];
}


- (void)hollow_drawRect:(NSRect)dirtyRect {
    NSLog(@"%s begin", __func__);

//    [self hollow_drawRect:dirtyRect];

    if (self.enableHollowOut) {
        CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
        [self hollowOutInContext:context];
    }
    NSLog(@"%s end", __func__);
}

- (void)hollowOut {
    [self display];
}

- (void)hollowOutInContext:(CGContextRef)context {

    //        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
    //        CGContextSetLineWidth(context, 10);
    for (NSValue *areaValue in self.hollowoutAreaArray) {
//        CGContextBeginTransparencyLayer(context, NULL);
        
//        CGContextSetBlendMode(context, kCGBlendModeClear);
        CGContextSetFillColorWithColor(context, [NSColor redColor].CGColor);
        NSLog(@"redColor");
        CGRect rect = [areaValue rectValue];
        //
        //            CGContextStrokeRect(context, rect);
        //            CGContextClearRect(context, rect);
        
        CGContextFillRect(context, rect);
        
//        CGContextEndTransparencyLayer(context);
    }
}

#pragma mark - Getter & Setter

static NSString *hollowoutAreaArrayKey = @"hollowoutAreaArrayKey";
- (void)setHollowoutAreaArray:(NSMutableArray<NSValue *> *)hollowoutAreaArray {
    objc_setAssociatedObject(self, &hollowoutAreaArrayKey, hollowoutAreaArray, OBJC_ASSOCIATION_RETAIN);
//    [self display];
}

- (NSMutableArray<NSValue *> *)hollowoutAreaArray {
    return (NSMutableArray *)objc_getAssociatedObject(self, &hollowoutAreaArrayKey);
}


static NSString *enableHollowOutKey = @"enableHollowOutKey";
- (void)setEnableHollowOut:(BOOL)enableHollowOut {
    objc_setAssociatedObject(self, &enableHollowOutKey, @(enableHollowOut), OBJC_ASSOCIATION_ASSIGN);
//    [self display];
}

- (BOOL)enableHollowOut {
    return [objc_getAssociatedObject(self, &enableHollowOutKey) boolValue];

}



@end
