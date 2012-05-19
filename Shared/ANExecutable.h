//
//  ANExecutable.h
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ANExecutable : NSObject {
    NSString * command;
    BOOL enabled;
}

@property (nonatomic, strong) NSString * command;
@property (readwrite) BOOL enabled;

- (id)initWithCommand:(NSString *)aCommand enabled:(BOOL)flag;

@end
