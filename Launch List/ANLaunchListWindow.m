//
//  ANLaunchListWindow.m
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANLaunchListWindow.h"

@implementation ANLaunchListWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag screen:(NSScreen *)screen {
    if ((self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag screen:screen])) {
        autoLaunch = [ANAutoLaunch autoLauncheForHelper];
        executableManager = [ANExecutableManager sharedManager];
        
        autoLaunchCheckBox = [[NSButton alloc] initWithFrame:NSMakeRect(contentRect.size.width - 200, 17, 110, 18)];
        [autoLaunchCheckBox setButtonType:NSSwitchButton];
        [autoLaunchCheckBox setBezelStyle:NSRoundedBezelStyle];
        [autoLaunchCheckBox setTitle:@"Run at startup"];
        [autoLaunchCheckBox setTarget:self];
        [autoLaunchCheckBox setAction:@selector(autoLaunchCheckBoxChanged:)];
        [autoLaunchCheckBox setState:[autoLaunch bundleExistsInLaunchItems]];
        [autoLaunchCheckBox setAutoresizingMask:(NSViewMaxYMargin | NSViewMaxXMargin)];
        if (!autoLaunch) {
            // perhaps the helper is not compiled into the bundle correctly?
            [autoLaunchCheckBox setEnabled:NO];
        }
        
        launchButton = [[NSButton alloc] initWithFrame:NSMakeRect(contentRect.size.width - 90, 10, 80, 32)];
        [launchButton setTitle:@"Launch!"];
        [launchButton setBezelStyle:NSRoundedBezelStyle];
        [launchButton setTarget:self];
        [launchButton setAction:@selector(launchButtonPressed:)];
        
        [[self contentView] addSubview:autoLaunchCheckBox];
        [[self contentView] addSubview:launchButton];
    }
    return self;
}

- (void)autoLaunchCheckBoxChanged:(id)sender {
    if ([autoLaunchCheckBox state] && ![autoLaunch bundleExistsInLaunchItems]) {
        [autoLaunch addBundleToLaunchItems];
    } else if (![autoLaunchCheckBox state] && [autoLaunch bundleExistsInLaunchItems]) {
        [autoLaunch removeBundleFromLaunchItems];
    }
}

- (void)launchButtonPressed:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL fileURLWithPath:[autoLaunch bundlePath]]];
}

@end
