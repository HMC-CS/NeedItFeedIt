//
//  UserLayer.h
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UserLayer : CCLayer {
    
}

@property (assign, nonatomic) int points;

-(id) init;
-(void) updateTimer: (int) seconds;
-(void) updatePoints: (int) points;
-(void) highlight;
-(void) redhighlight;


@end
