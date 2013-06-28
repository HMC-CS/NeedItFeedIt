//
//  UserLayer.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "UserLayer.h"
#import "PauseLayer.h"

static const int HEIGHTSCALE = 0.97;

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
        timeLabel.position = ccp(5*size.width/6, size.height*HEIGHTSCALE);
        timeLabel.color = ccc3(68, 14, 98);
        
        scoreLabel = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:36];
        scoreLabel.position = ccp(3*size.width/6, size.height*HEIGHTSCALE);
        scoreLabel.color = ccc3(68, 14, 98);
        
        //Add pause button in
        CCMenuItemImage* pause  = [CCMenuItemImage itemWithNormalImage:@"pause.png" selectedImage:@"pausesel.png" target:self selector:@selector(pausePressed:)];
        CCMenu* pauseMenu = [CCMenu menuWithItems:pause, nil];
        pauseMenu.position = ccp(size.width/8, size.height*HEIGHTSCALE);
               
        [self updateTimer:0];
        [self updatePoints:0];
        [self addChild: timeLabel];
        [self addChild: scoreLabel];
        [self addChild: pauseMenu];
        
        self.touchEnabled = YES;
        
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
    scoreLabel.string = [NSString stringWithFormat:@"Score: %d", points];
}

-(void) pausePressed: (id) sender{
    [[CCDirector sharedDirector] pushScene:[PauseLayer node]];
}

@end
