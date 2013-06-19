//
//  UserLayer.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "UserLayer.h"


@implementation UserLayer{
    CCLabelTTF* label;
}

-(id) init{
    if (self = [super init]) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        //Create a label
        label = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:36];
        label.position = ccp(5*winSize.width/6, winSize.height*0.97);
        label.color = ccBLACK;
        [self updateTimer:0];
        [self addChild: label];
        
        self.touchEnabled = NO;
        
        return self;
    }
    return nil;
}

-(void) updateTimer: (int) seconds{
    label.string = [NSString stringWithFormat:@"Timer %02.f : %02i", round(seconds/60), seconds % 60];
}

@end
