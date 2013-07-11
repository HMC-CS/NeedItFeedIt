//
//  UserLayer.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "UserLayer.h"
#import "PauseLayer.h"
#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"
#import "LevelManager.h"

static const int HEIGHTSCALE = 0.97;

@implementation UserLayer{
    CCSprite* timeLabel;
    CCLabelTTF* timeText;
    CCSprite* scoreLabel;
    CCLabelTTF* scoreText;
    CCSprite* multiLabel;
    CCLabelTTF* multiText;
    CCLabelTTF* highScoreText;
    int endValue;
    double delta;
    int highScore;
}

-(id) init{
    if (self = [super init]) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];


        //Create timer label
        timeLabel = [CCSprite spriteWithFile:@"timer.png"];
        timeLabel.position = ccp(5*size.width/6, size.height*HEIGHTSCALE);
        
        timeText = [CCLabelTTF labelWithString:@"" fontName:@"Hobo" fontSize:36];
        timeText.position = ccp(5*size.width/6 + timeLabel.contentSize.width + 20, size.height*HEIGHTSCALE);
        timeText.color = ccc3(48, 0, 68);
        
        //Create score label
        scoreLabel = [CCSprite spriteWithFile:@"score.png"];
        scoreLabel.position = ccp(size.width*.35, size.height*HEIGHTSCALE);
        
        scoreText = [CCLabelTTF labelWithString:@"" fontName:@"Hobo" fontSize:36];
        scoreText.position = ccp(size.width*.35 + scoreLabel.contentSize.width/2 + 40, size.height*HEIGHTSCALE);
        scoreText.color = ccc3(48, 0, 68);
        
        //Get the high Score from the data file
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Data.plist"]];
        NSDictionary* plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        Level *curLevel = [[LevelManager sharedInstance] currentLevel];
        NSDictionary* ecosystem = plistDictionary[curLevel.ecosystem];
        NSString* levelName = [NSString stringWithFormat:@"Level%i", curLevel.levelNum];
        highScore = [ecosystem[levelName] intValue];
        
        NSString* hiScore = [NSString stringWithFormat:@"High Score: %d", highScore];
        highScoreText = [CCLabelTTF labelWithString:hiScore fontName:@"Hobo" fontSize:36];
        highScoreText.position = ccp(size.width*.6, size.height*HEIGHTSCALE);
        highScoreText.color = ccc3(48, 0, 68);
        
        //Add pause button
        CCMenuItemImage* pause  = [CCMenuItemImage itemWithNormalImage:@"pause.png" selectedImage:@"pausesel.png" target:self selector:@selector(pausePressed:)];
        CCMenu* pauseMenu = [CCMenu menuWithItems:pause, nil];
        pauseMenu.position = ccp(size.width/11, size.height*HEIGHTSCALE);
        
        //Add sound icon
        CCMenuItem* soundOn = [CCMenuItemImage itemWithNormalImage:@"soundIcon.png" selectedImage:@"soundIcon.png" target:nil selector:nil];
        CCMenuItem* soundOff = [CCMenuItemImage itemWithNormalImage:@"soundIconMute.png" selectedImage:@"soundOff.png" target:nil selector:nil];
        CCMenuItemToggle *soundToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundIconPressed:) items:soundOn, soundOff, nil];
        
        CCMenu* soundMenu = [CCMenu menuWithItems:soundToggle, nil];
        soundMenu.position = ccp(size.width/5, size.height*HEIGHTSCALE);
        
        //Fix toggle
        if (soundToggle.selectedItem == soundOn && [CDAudioManager sharedManager].backgroundMusic.volume == 0.0)
            [soundToggle setSelectedIndex:1];
        if (soundToggle.selectedItem == soundOff && [CDAudioManager sharedManager].backgroundMusic.volume == 1.0)
            [soundToggle setSelectedIndex:0];
        
               
        [self updateTimer:0];
        [self updatePoints:0];
        [self addChild: timeLabel];
        [self addChild: timeText];
        [self addChild: scoreLabel];
        [self addChild: scoreText];
        [self addChild: pauseMenu];
        [self addChild: soundMenu];
        [self addChild: highScoreText];
        
        
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
    if (_points>highScore) {
        highScore = points;
        highScoreText.string = [NSString stringWithFormat:@"High Score: %d", highScore];
    }
}

-(void) pausePressed: (id) sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"menu.wav"];
    [[CCDirector sharedDirector] pushScene:[PauseLayer node]];
}

-(void) soundIconPressed:(id) sender{
    // toggle sound on and off
    if ([CDAudioManager sharedManager].backgroundMusic.volume == 1.0){
        [CDAudioManager sharedManager].backgroundMusic.volume = 0.0;
        [SimpleAudioEngine sharedEngine].effectsVolume = 0.0;
    }
    else{
        [CDAudioManager sharedManager].backgroundMusic.volume = 1.0;
        [SimpleAudioEngine sharedEngine].effectsVolume = 1.0;
    }

}

@end
