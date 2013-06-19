//
//  ResourceBar.h
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ResourceBar : CCLayer {
    
}

//@property (nonatomic) int* percentage;


-(id) init;

// Fill up the bars depending on percentage
-(void)updateBar:(int)newPercentage;

// Decrements percentage
-(void)decreasePercentage;

// Generates an unsigned int representing a color.
// redFrac, greenFrac, blueFrac should be values from 0-1.
-(ccColor3B)colorFromRed: (float)redFrac Green: (float)greenFrac Blue: (float)blueFrac;

// Increase green linearly
-(float)greenAmount;

// Decrease red linearly
-(float)redAmount;

@end
