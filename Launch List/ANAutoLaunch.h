//
//  ANAutoLaunch.h
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ANAutoLaunch : NSObject {
    NSString * bundlePath;
}

@property (readonly) NSString * bundlePath;

+ (ANAutoLaunch *)autoLauncheForHelper;
- (id)initWithBundlePath:(NSString *)appBundle;

- (BOOL)bundleExistsInLaunchItems;
- (void)addBundleToLaunchItems;
- (void)removeBundleFromLaunchItems;

@end
