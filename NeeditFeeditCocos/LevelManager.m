//
//  LevelManager.m
//  NeeditFeeditCocos
//
//  Created by Haley Erickson on 6/19/13.
//  Copyright (c) 2013 Haley Erickson. All rights reserved.
//

#import "LevelManager.h"

@implementation LevelManager {
    NSArray * levels;
    int currentLevelIndex;
}

+ (LevelManager *)sharedInstance {
    static dispatch_once_t once;
    static LevelManager * sharedInstance; dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if ((self = [super init])) {
        currentLevelIndex = 0;
        Level * level1 = [[Level alloc] initWithLevelNum:1];
        Level * level2 = [[Level alloc] initWithLevelNum:2];
        levels = @[level1, level2];
    }
    return self;
}

- (Level *)currentLevel {
    if (currentLevelIndex >= levels.count) {
        return nil;
    }
    return levels[currentLevelIndex];
}

- (void)nextLevel {
    currentLevelIndex++;
}

- (void)reset {
    currentLevelIndex = 0;
}

- (void)dealloc {
    levels = nil;
}

@end
