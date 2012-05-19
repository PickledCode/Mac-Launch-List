//
//  ANExecutableManager.m
//  Launch List
//
//  Created by Alex Nichol on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANExecutableManager.h"

@interface ANExecutableManager (Private)

- (NSString *)plistStorePath;
- (NSMutableArray *)loadExecutables:(NSString *)path;
- (BOOL)writeExecutables:(NSString *)path;

@end

@implementation ANExecutableManager

+ (ANExecutableManager *)sharedManager {
    static ANExecutableManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ANExecutableManager alloc] init];
    });
    return manager;
}

- (id)init {
    if ((self = [super init])) {
        NSString * path = [self plistStorePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            _executables = [self loadExecutables:path];
        }
        if (!_executables) _executables = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)executables {
    return _executables;
}

- (void)addExecutable:(ANExecutable *)executable {
    [_executables addObject:executable];
}

- (void)removeExecutable:(ANExecutable *)executable {
    [_executables removeObject:executable];
}

- (BOOL)synchronize {
    return [self writeExecutables:[self plistStorePath]];
}

#pragma mark - Private -

- (NSString *)plistStorePath {
    NSString * appSupport = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Application Support"] stringByAppendingPathComponent:@"Launch List"];
    
    BOOL isDirectory = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:appSupport isDirectory:&isDirectory]) {
        BOOL status = [[NSFileManager defaultManager] createDirectoryAtPath:appSupport withIntermediateDirectories:NO attributes:nil error:nil];
        if (!status) return nil;
    } else {
        if (!isDirectory) return nil;
    }
    return [appSupport stringByAppendingPathComponent:@"executables.plist"];
}

- (NSMutableArray *)loadExecutables:(NSString *)path {
    NSMutableArray * executables = [NSMutableArray array];
    NSArray * dictionaries = [NSArray arrayWithContentsOfFile:path];
    if (!dictionaries) return nil;
    for (NSDictionary * info in dictionaries) {
        ANExecutable * executable = [[ANExecutable alloc] initWithCommand:[info objectForKey:@"command"]
                                                               enabled:[[info objectForKey:@"enabled"] boolValue]];
        [executables addObject:executable];
    }
    return executables;
}

- (BOOL)writeExecutables:(NSString *)path {
    NSMutableArray * dictionaries = [[NSMutableArray alloc] init];
    for (ANExecutable * executable in _executables) {
        NSDictionary * info = [NSDictionary dictionaryWithObjectsAndKeys:executable.command, @"command",
                               [NSNumber numberWithBool:executable.enabled], @"enabled", nil];
        [dictionaries addObject:info];
    }
    return [dictionaries writeToFile:path atomically:YES];
}

@end
