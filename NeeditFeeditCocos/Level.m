//
//  Level.m
//  NeeditFeeditCocos
//
//  Created by Haley Erickson on 6/19/13.
//  Copyright (c) 2013 Haley Erickson. All rights reserved.
//

#import "Level.h"

@implementation Level

- (id)initWithLevelNum:(int)levelNum resourceInterval:(float)resourceInterval {
    if ((self = [super init])) {
        self.levelNum = levelNum;
        self.resourceInterval = resourceInterval;
    }
    return self;
}

@end
