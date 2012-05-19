//
//  ANDeleteTableView.m
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANDeleteTableView.h"

@implementation ANDeleteTableView

@synthesize deleteCallback;

- (void)keyDown:(NSEvent *)theEvent {
    if (theEvent.keyCode == 51) {
        if (deleteCallback) {
            deleteCallback(self);
        }
    }
}

@end
