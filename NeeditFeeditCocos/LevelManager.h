//
//  LevelManager.h
//  NeeditFeeditCocos
//
//  Created by Haley Erickson on 6/19/13.
//  Copyright (c) 2013 Haley Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"

@interface LevelManager : NSObject

+ (LevelManager *)sharedInstance;
- (Level *)currentLevel;
- (void)nextLevel;
- (void)reset;

@end
