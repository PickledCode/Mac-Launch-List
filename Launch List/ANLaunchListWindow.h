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
#import "ANDeleteTableView.h"

@interface ANLaunchListWindow : NSWindow <NSTableViewDataSource, NSTableViewDelegate> {
    ANDeleteTableView * executableTableView;
    NSScrollView * tableScrollView;
    NSButton * autoLaunchCheckBox;
    NSButton * launchButton;
    NSButton * addButton;
    NSButton * removeButton;
    
    ANAutoLaunch * autoLaunch;
    ANExecutableManager * executableManager;
}

- (void)autoLaunchCheckBoxChanged:(id)sender;
- (void)launchButtonPressed:(id)sender;
- (void)addButtonPressed:(id)sender;
- (void)removeButtonPressed:(id)sender;

@end
