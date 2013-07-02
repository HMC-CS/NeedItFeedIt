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
    CCSprite* timeLabel;
    CCLabelTTF* timeText;
    CCSprite* scoreLabel;
    CCLabelTTF* scoreText;
    CCSprite* multiLabel;
    CCLabelTTF* multiText;
    int endValue;
    double delta;
}

-(id) init{
    if (self = [super init]) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];


        //Create timer label
        timeLabel = [CCSprite spriteWithFile:@"timer.png"];
        timeLabel.position = ccp(5*size.width/6, size.height*HEIGHTSCALE);
        
        timeText = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:36];
        timeText.position = ccp(5*size.width/6 + timeLabel.contentSize.width + 20, size.height*HEIGHTSCALE);
        timeText.color = ccc3(48, 0, 68);
        
        //Create score label
        scoreLabel = [CCSprite spriteWithFile:@"score.png"];
        scoreLabel.position = ccp(3*size.width/12, size.height*HEIGHTSCALE);
        
        scoreText = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:36];
        scoreText.position = ccp(3*size.width/12 + scoreLabel.contentSize.width/2 + 40, size.height*HEIGHTSCALE);
        scoreText.color = ccc3(48, 0, 68);
        
        //Create multiplier label
        multiLabel = [CCSprite spriteWithFile:@"multiplier.png"];
        multiLabel.position = ccp(3*size.width/6, size.height*HEIGHTSCALE);
        
        multiText = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:36];
        multiText.position = ccp(3*size.width/6 + multiLabel.contentSize.width/2 + 20, size.height*HEIGHTSCALE);
        multiText.color = ccc3(48, 0, 68);
        
        _multiplier = 1;
        multiText.string = [NSString stringWithFormat:@" x%d", _multiplier];
        
        //Add pause button
        CCMenuItemImage* pause  = [CCMenuItemImage itemWithNormalImage:@"pause.png" selectedImage:@"pausesel.png" target:self selector:@selector(pausePressed:)];
        CCMenu* pauseMenu = [CCMenu menuWithItems:pause, nil];
        pauseMenu.position = ccp(size.width/11, size.height*HEIGHTSCALE);
               
        [self updateTimer:0];
        [self updatePoints:0];
        [self addChild: timeLabel];
        [self addChild: timeText];
        [self addChild: scoreLabel];
        [self addChild: scoreText];
        [self addChild: multiLabel];
        [self addChild: multiText];
        [self addChild: pauseMenu];
        
        
        self.touchEnabled = YES;
        
        return self;
    }
    return nil;
}

-(void) updateTimer: (int) seconds{
    timeText.string = [NSString stringWithFormat:@" %02.f : %02i", round(seconds/60), seconds % 60];
}

-(void)setPoints:(int)points
{
    _points = MAX(points, 0);
}

-(void) updatePoints: (int) points{
    scoreText.string = [NSString stringWithFormat:@" %d", points];
}

-(void) pausePressed: (id) sender{
    [[CCDirector sharedDirector] pushScene:[PauseLayer node]];
}

-(void) updateMultiplier:(int)newMulti{
    _multiplier = newMulti;
    multiText.string = [NSString stringWithFormat:@" x%d", _multiplier];
}

@end
