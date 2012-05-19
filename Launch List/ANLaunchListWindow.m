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
        // initialization
        autoLaunch = [ANAutoLaunch autoLauncheForHelper];
        executableManager = [ANExecutableManager sharedManager];
        
        executableTableView = [[ANDeleteTableView alloc] initWithFrame:NSMakeRect(0, 0, contentRect.size.width - 20, contentRect.size.height - 62)];
        tableScrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(10, 52, contentRect.size.width - 20, contentRect.size.height - 62)];
        launchButton = [[NSButton alloc] initWithFrame:NSMakeRect(contentRect.size.width - 90, 10, 80, 32)];
        autoLaunchCheckBox = [[NSButton alloc] initWithFrame:NSMakeRect(contentRect.size.width - 200, 17, 110, 18)];
        addButton = [[NSButton alloc] initWithFrame:NSMakeRect(10, 17, 22, 22)];
        removeButton = [[NSButton alloc] initWithFrame:NSMakeRect(31, 17, 22, 22)];

        // table configuration
        [executableTableView setDelegate:self];
        [executableTableView setDataSource:self];
        __unsafe_unretained id unretainedSelf = self;
        [executableTableView setDeleteCallback:^(NSTableView * tv) {
            [unretainedSelf removeButtonPressed:nil];
        }];
        
        NSTableColumn * enabledColumn = [[NSTableColumn alloc] initWithIdentifier:@"Enabled"];
        [[enabledColumn headerCell] setStringValue:@"√"];
        [enabledColumn setWidth:20];
        [executableTableView addTableColumn:enabledColumn];
        
        NSTableColumn * commandColumn = [[NSTableColumn alloc] initWithIdentifier:@"Command"];
        [[commandColumn headerCell] setStringValue:@"Command"];
        [commandColumn setWidth:300];
        [executableTableView addTableColumn:commandColumn];
        
        // scroll view configuration
        [tableScrollView setDocumentView:executableTableView];
        [tableScrollView setBorderType:NSBezelBorder];
        [tableScrollView setHasVerticalScroller:YES];
        [tableScrollView setHasHorizontalScroller:YES];
        [tableScrollView setAutohidesScrollers:NO];
        [tableScrollView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
        
        // auto-launch configuration
        [autoLaunchCheckBox setButtonType:NSSwitchButton];
        [autoLaunchCheckBox setBezelStyle:NSRoundedBezelStyle];
        [autoLaunchCheckBox setTitle:@"Run at startup"];
        [autoLaunchCheckBox setTarget:self];
        [autoLaunchCheckBox setAction:@selector(autoLaunchCheckBoxChanged:)];
        [autoLaunchCheckBox setState:[autoLaunch bundleExistsInLaunchItems]];
        [autoLaunchCheckBox setAutoresizingMask:(NSViewMaxYMargin | NSViewMinXMargin)];
        if (!autoLaunch) {
            // perhaps the helper is not compiled into the bundle correctly?
            [autoLaunchCheckBox setEnabled:NO];
        }
        
        // launch button configuration
        [launchButton setTitle:@"Launch!"];
        [launchButton setBezelStyle:NSRoundedBezelStyle];
        [launchButton setTarget:self];
        [launchButton setAction:@selector(launchButtonPressed:)];
        [launchButton setAutoresizingMask:(NSViewMaxYMargin | NSViewMinXMargin)];
        
        // add button configuration
        [addButton setTitle:@"+"];
        [addButton setBezelStyle:NSSmallSquareBezelStyle];
        [addButton setTarget:self];
        [addButton setAction:@selector(addButtonPressed:)];
        [addButton setAutoresizingMask:(NSViewMaxYMargin | NSViewMaxXMargin)];
        
        // remove button configuration
        [removeButton setTitle:@"–"]; // NOTE: this is some bizzarre Unicode "-" character...
        [removeButton setBezelStyle:NSSmallSquareBezelStyle];
        [removeButton setTarget:self];
        [removeButton setAction:@selector(removeButtonPressed:)];
        [removeButton setAutoresizingMask:(NSViewMaxYMargin | NSViewMaxXMargin)];
        
        // finalizing
        [[self contentView] addSubview:autoLaunchCheckBox];
        [[self contentView] addSubview:launchButton];
        [[self contentView] addSubview:tableScrollView];
        [[self contentView] addSubview:addButton];
        [[self contentView] addSubview:removeButton];
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

- (void)addButtonPressed:(id)sender {
    ANExecutable * exe = [[ANExecutable alloc] initWithCommand:@"say poop" enabled:YES];
    [executableManager addExecutable:exe];
    [executableManager synchronize];
    [executableTableView reloadData];
}

- (void)removeButtonPressed:(id)sender {
    // TODO: make this work, here!!!
    NSIndexSet * set = [executableTableView selectedRowIndexes];
    NSMutableArray * removeExecs = [NSMutableArray array];
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        ANExecutable * exe = [[executableManager executables] objectAtIndex:idx];
        [removeExecs addObject:exe];
    }];
    for (ANExecutable * exe in removeExecs) {
        [executableManager removeExecutable:exe];
    }
    [executableManager synchronize];
    [executableTableView reloadData];
}

#pragma mark - Table View -

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[executableManager executables] count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    ANExecutable * exec = [[executableManager executables] objectAtIndex:row];
    if ([[tableColumn identifier] isEqualToString:@"Command"]) {
        return [exec command];
    } else if ([[tableColumn identifier] isEqualToString:@"Enabled"]) {
        return [NSNumber numberWithBool:[exec enabled]];
    }
    return nil;
}

- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if ([[tableColumn identifier] isEqualToString:@"Enabled"]) {
        NSButtonCell * cell = [[NSButtonCell alloc] init];
        [cell setButtonType:NSSwitchButton];
        [cell setTitle:@""];
        return cell;
    }
    return nil;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    ANExecutable * exec = [[executableManager executables] objectAtIndex:row];
    if ([[tableColumn identifier] isEqualToString:@"Command"]) {
        exec.command = object;
    } else if ([[tableColumn identifier] isEqualToString:@"Enabled"]) {
        exec.enabled = [object boolValue];
    }
    [executableManager synchronize];
    [executableTableView reloadData];
}

@end
