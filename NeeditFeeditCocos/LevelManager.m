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
        Level * level1 = [[Level alloc] initWithEcosystem:@"Forest" andLevelNum:1];
        Level * level2 = [[Level alloc] initWithEcosystem:@"Forest" andLevelNum:2];
        Level * level3 = [[Level alloc] initWithEcosystem:@"Forest" andLevelNum:3];
        
        Level * level4 = [[Level alloc] initWithEcosystem:@"Ocean" andLevelNum:1];
        Level * level5 = [[Level alloc] initWithEcosystem:@"Ocean" andLevelNum:2];
        Level * level6 = [[Level alloc] initWithEcosystem:@"Ocean" andLevelNum:3];
        
        Level * level7 = [[Level alloc] initWithEcosystem:@"Desert" andLevelNum:1];
        Level * level8 = [[Level alloc] initWithEcosystem:@"Desert" andLevelNum:2];
        Level * level9 = [[Level alloc] initWithEcosystem:@"Desert" andLevelNum:3];
        
        Level * level10 = [[Level alloc] initWithEcosystem:@"Savanna" andLevelNum:1];
        Level * level11 = [[Level alloc] initWithEcosystem:@"Savanna" andLevelNum:2];
        Level * level12 = [[Level alloc] initWithEcosystem:@"Savanna" andLevelNum:3];
        
        Level * level13 = [[Level alloc] initWithEcosystem:@"Arctic" andLevelNum:1];
        Level * level14 = [[Level alloc] initWithEcosystem:@"Arctic" andLevelNum:2];
        Level * level15 = [[Level alloc] initWithEcosystem:@"Arctic" andLevelNum:3];
        levels = @[level1, level2, level3, level4, level5, level6, level7,
                   level8, level9, level10, level11, level12, level13, level14, level15];
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

-(void) startAtLevel: (NSString*) ecosystem{
    for (int i=0; i<levels.count; i++) {
        Level* temp = levels[i];
        if ([temp.ecosystem isEqualToString: ecosystem]) {
            currentLevelIndex = i;
            break;
        }
    }
}

-(BOOL) atMaxLevel{
    if (currentLevelIndex == (levels.count-1)) {
        return true;
    }
    return false;
}


@end
