//
//  UserLayer.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "UserLayer.h"


@implementation UserLayer{
    CCLabelTTF* timeLabel;
    CCLabelTTF* scoreLabel;
    int endValue;
    double delta;
}

-(id) init{
    if (self = [super init]) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //Create a label
        timeLabel = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:36];
        timeLabel.position = ccp(5*size.width/6, size.height*0.97);
        timeLabel.color = ccBLACK;
        
        scoreLabel = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:36];
        scoreLabel.position = ccp(2*size.width/6, size.height*0.97);
        scoreLabel.color = ccBLACK;
        
        [self updateTimer:0];
        [self updatePoints:0];
        [self addChild: timeLabel];
        [self addChild: scoreLabel];
        
        self.touchEnabled = NO;
        
        return self;
    }
    return nil;
}

-(void) updateTimer: (int) seconds{
    timeLabel.string = [NSString stringWithFormat:@"Timer %02.f : %02i", round(seconds/60), seconds % 60];
}

-(void)setPoints:(int)points
{
    _points = MAX(points, 0);
}

-(void) updatePoints: (int) points{
    scoreLabel.string = [NSString stringWithFormat:@"Score %d", points];
}

@end
