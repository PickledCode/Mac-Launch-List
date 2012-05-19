//
//  ANExecutableManager.h
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANExecutable.h"

@interface ANExecutableManager : NSObject {
    NSMutableArray * _executables;
}

+ (ANExecutableManager *)sharedManager;
- (NSArray *)executables;
- (void)addExecutable:(ANExecutable *)executable;
- (void)removeExecutable:(ANExecutable *)executable;
- (BOOL)synchronize;

@end
