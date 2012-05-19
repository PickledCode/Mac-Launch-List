//
//  ANExecutable.m
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANExecutable.h"

@implementation ANExecutable

@synthesize command;
@synthesize enabled;

- (id)initWithCommand:(NSString *)aCommand enabled:(BOOL)flag {
    if ((self = [super init])) {
        command = aCommand;
        enabled = flag;
    }
    return self;
}

@end
