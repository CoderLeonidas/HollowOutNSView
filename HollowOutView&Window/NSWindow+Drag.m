//
//  NSWindow+Drag.m
//  HollowOutView&Window
//
//  Created by Leonidas.Luo on 2/18/20.
//  Copyright © 2020 Leonidas.Luo. All rights reserved.
//

#import "NSWindow+Drag.h"
#import <objc/runtime.h>

@implementation NSWindow (Drag)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        {
            SEL originalSelector = @selector(mouseDragged:);
            SEL swizzledSelector = @selector(drag_mouseDragged:);
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            
            BOOL didAddMethod =
            class_addMethod(class,
                            originalSelector,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(class,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    });
}

- (BOOL)draggable {
    return [objc_getAssociatedObject(self, @"draggable") boolValue];
}

- (void)setDraggable:(BOOL)draggable {
    objc_setAssociatedObject(self, @"draggable", @(draggable), OBJC_ASSOCIATION_ASSIGN);
}


- (void)drag_mouseDragged:(NSEvent *)event {
    [self drag_mouseDragged:event];
    
    if (self.draggable) {
        [self performWindowDragWithEvent:event];
    }
}



@end
