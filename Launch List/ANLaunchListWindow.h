//
//  ANLaunchListWindow.h
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANExecutableManager.h"
#import "ANAutoLaunch.h"

@interface ANLaunchListWindow : NSWindow <NSTableViewDataSource, NSTableViewDelegate> {
    NSTableView * executableTableView;
    NSButton * autoLaunchCheckBox;
    NSButton * launchButton;
    
    ANAutoLaunch * autoLaunch;
    ANExecutableManager * executableManager;
}

- (void)autoLaunchCheckBoxChanged:(id)sender;
- (void)launchButtonPressed:(id)sender;

@end
