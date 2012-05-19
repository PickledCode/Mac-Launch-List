//
//  ANDeleteTableView.h
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ANDeleteTableView : NSTableView {
    void (^deleteCallback)(NSTableView * tableView);
}

@property (copy) void (^deleteCallback)(NSTableView * tableView);

@end
