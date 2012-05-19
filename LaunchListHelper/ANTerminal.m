//
//  ANTerminal.m
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANTerminal.h"

@implementation ANTerminal

- (id)init {
    if ((self = [super init])) {
        application = [SBApplication applicationWithBundleIdentifier:@"com.apple.Terminal"];
        while (![application isRunning]) {
            [application activate];
            [NSThread sleepForTimeInterval:0.25];
        }
    }
    return self;
}

- (void)runCommand:(NSString *)script {
    [application doScript:script in:nil];
}

@end
