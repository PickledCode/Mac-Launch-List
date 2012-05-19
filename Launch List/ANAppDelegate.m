//
//  ANAppDelegate.m
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANAppDelegate.h"

@implementation ANAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSSize windSize = NSMakeSize(420, 250);
    NSSize screenSize = [[NSScreen mainScreen] frame].size;
    NSRect frame = NSMakeRect((screenSize.width - windSize.width) / 2,
                             (screenSize.height - windSize.height) / 2,
                             windSize.width, windSize.height);
    
    window = [[ANLaunchListWindow alloc] initWithContentRect:frame
                                                   styleMask:(NSTitledWindowMask | NSResizableWindowMask | NSMiniaturizableWindowMask)
                                                     backing:NSBackingStoreBuffered
                                                       defer:NO
                                                      screen:[NSScreen mainScreen]];
    [window setMinSize:NSMakeSize(420, 250)];
    [window setTitle:@"Launch List Configuration"];
    [window makeKeyAndOrderFront:self];
}

@end
