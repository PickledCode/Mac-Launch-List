//
//  ANAppDelegate.m
//  LaunchListHelper
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANAppDelegate.h"

@implementation ANAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    ANExecutableManager * manager = [ANExecutableManager sharedManager];
    ANTerminal * term = [[ANTerminal alloc] init];
    for (ANExecutable * exec in [manager executables]) {
        if ([exec enabled]) {
            [term runCommand:[exec command]];
        }
    }
    [[NSApplication sharedApplication] terminate:self];
}

@end
