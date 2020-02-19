//
//  AppDelegate.h
//  HollowOutView&Window
//
//  Created by Leonidas.Luo on 2/13/20.
//  Copyright © 2020 Leonidas.Luo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "LYView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet  LYView *customView;

@property (weak) IBOutlet NSImageView *imageView;

@property (weak) IBOutlet NSTextField *textField;

@property (weak) IBOutlet NSView *playerView;

@end

