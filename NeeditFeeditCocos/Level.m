//
//  Level.m
//  NeeditFeeditCocos
//
//  Created by Haley Erickson on 6/19/13.
//  Copyright (c) 2013 Haley Erickson. All rights reserved.
//

#import "Level.h"

@implementation Level

- (id)initWithEcosystem: (NSString*) ecosys andLevelNum:(int)levelNum {
    if ((self = [super init])) {
        self.levelNum = levelNum;
        self.ecosystem = ecosys;
    }
    return self;
}

@end
