//
//  NSView+Hollow.h
//  HollowOutView&Window
//
//  Created by Leonidas.Luo on 2/18/20.
//  Copyright © 2020 Leonidas.Luo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (Hollow)
@property (nonatomic, strong) NSMutableArray <NSValue*> *hollowoutAreaArray;

@property (nonatomic, assign) BOOL enableHollowOut;

- (void)hollowOut;

@end

NS_ASSUME_NONNULL_END
