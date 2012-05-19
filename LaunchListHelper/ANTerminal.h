//
//  ANTerminal.h
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Terminal.h"

@interface ANTerminal : NSObject {
    TerminalApplication * application;
}

- (void)runCommand:(NSString *)script;

@end
