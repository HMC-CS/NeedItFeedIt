//
//  Level.h
//  NeeditFeeditCocos
//
//  Created by Haley Erickson on 6/19/13.
//  Copyright (c) 2013 Haley Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject

@property (nonatomic, assign) int levelNum;
@property (nonatomic, assign) float resourceInterval;

- (id)initWithLevelNum:(int)levelNum resourceInterval:(float)resourceInterval;

@end
