//
//  AppDelegate.m
//  HollowOutView&Window
//
//  Created by Leonidas.Luo on 2/13/20.
//  Copyright © 2020 Leonidas.Luo. All rights reserved.
//

#import "AppDelegate.h"

#import "NSView+Hollow.h"

#import "NSWindow+Drag.h"

#import <AVFoundation/AVFoundation.h>

#import "LYView.h"


@interface AppDelegate ()


@property (weak) IBOutlet NSWindow *window;

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation AppDelegate {
    NSArray *_hollowoutAreas;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self setupWindow];
    
    
//    self.customView.wantsLayer = YES;
//    self.customView.layer.backgroundColor = [NSColor orangeColor].CGColor;
    
     _hollowoutAreas = @[[NSValue valueWithRect:NSMakeRect(0, 0, 100, 100)],
                         [NSValue valueWithRect:NSMakeRect(self.imageView.frame.size.width - 100, self.imageView.frame.size.height - 100, 200, 200)]];
}

- (void)setupWindow {
    self.window.draggable = YES;
    [self.window setOpaque: NO];
    self.window.backgroundColor = [NSColor clearColor];
//    self.window.styleMask =NSWindowStyleMaskBorderless;
    self.window.hasShadow = NO;
}


- (IBAction)butClicked0:(id)sender {
    [self hollowOutView:self.customView];
}

- (IBAction)butClicked1:(id)sender {
    [self hollowOutView:self.imageView];
}



- (IBAction)butClicked2:(id)sender {
    [self hollowOutView:self.textField];
}

- (IBAction)butClicked3:(id)sender {
    [self.player play];
    [self hollowOutView:self.playerView];
}

- (void)hollowOutView:(NSView*)aView {
   aView.enableHollowOut = YES;
    aView.hollowoutAreaArray = [_hollowoutAreas mutableCopy];
    [aView hollowOut];
}

#pragma mark - AVPlayer

- (AVPlayer *)player {
    if (!_player ) {
        _player = [AVPlayer playerWithPlayerItem:[self itemWithIndex:3]];
        _player.muted = YES;
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        playerLayer.frame = self.playerView.bounds;
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        
        
        [self.playerView.layer addSublayer:playerLayer];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
        
    }
    return _player ;
}

- (AVPlayerItem*)itemWithIndex:(NSUInteger)idx {
    NSString *resName = [NSString stringWithFormat:@"demo%ld", idx];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:resName ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
    
    return playerItem;
}

#pragma mark - 接收播放完成的通知，实现循环播放
- (void)runLoopTheMovie:(NSNotification *)notification {
    AVPlayerItem *playerItem = notification.object;
    __weak typeof(self) weakself = self;
    [playerItem seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        __strong typeof(self) strongself = weakself;
        [strongself->_player play];
    }];
}


@end
