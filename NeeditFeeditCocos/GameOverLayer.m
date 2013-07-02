//
//  GameOverLayer.m
//  NeeditFeeditCocos
//
//  Created by Haley Erickson on 6/19/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "GameOverLayer.h"
#import "MenuLayer.h"
#import "LevelManager.h"
#import "GameController.h"
#import "CounterLabel.h"

@implementation GameOverLayer

+(CCScene *) sceneWithWon:(BOOL)won andScore: (int) score andBonus: (int) bonus{
    CCScene *scene = [CCScene node];
    GameOverLayer *layer = [[GameOverLayer alloc] initWithWon:won andScore:score andBonus:bonus];
    [scene addChild: layer];
    return scene;
}

- (id)initWithWon:(BOOL)won andScore: (int) score andBonus: (int) bonus{
    if (self = [super init]) {
        
        
        //Get the window size for alignment later
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //Get the dictionary with the information for the level
        Level* curLevel = [[LevelManager sharedInstance] currentLevel];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Data.plist"]];
        NSMutableDictionary* plistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        NSMutableDictionary* current = [[NSMutableDictionary alloc] initWithDictionary: plistDictionary[curLevel.ecosystem]];
        
        //If you have a new highscore, add it to the Data.plist
        NSString* level = [[NSString alloc] initWithFormat:@"Level%i", curLevel.levelNum];
        int bestScore = [current[level] intValue];
        if ((score+ bonus)>bestScore) {
            [current setValue:[NSNumber numberWithInt:score] forKey:level];
            [plistDictionary setValue:current forKey:curLevel.ecosystem];
            [plistDictionary writeToFile:path atomically:YES];
            bestScore = score +bonus;
            NSLog(@"new high score %i", [current[level] intValue]);
        }
        
        
        CCSprite * message;
        CCSprite * nextLevel = [CCSprite spriteWithFile:@"retryLevel.png"];
        CCSprite * nextLevelSel = [CCSprite spriteWithFile:@"retryLevelSel.png"];
        if (won) {
            
            //Check if they won the game or if they just beat the level
            if (![[LevelManager sharedInstance] atMaxLevel]) {
                nextLevel = [CCSprite spriteWithFile:@"nextLevel.png"];
                nextLevelSel = [CCSprite spriteWithFile:@"nextLevelSel.png"];
                message = [CCSprite spriteWithFile:@"wincase.png"];
                [[LevelManager sharedInstance] nextLevel];
            } else{
                message = [CCSprite spriteWithFile:@"beatGame"];
            }
            
            //Check if need to unlock next ecosystem
            Level* curLevel = [[LevelManager sharedInstance] currentLevel];
            if (curLevel.levelNum == 1.0) {
                if ([current[@"unlocked"] intValue] == 1){
                    NSMutableDictionary* curDict = plistDictionary[curLevel.ecosystem];
                    [curDict setValue: [NSNumber numberWithBool:YES] forKey:@"unlocked"];
                    [plistDictionary setValue:curDict forKey:curLevel.ecosystem];
                    [plistDictionary writeToFile:path atomically:YES];
                }
            }
            
            //If they earned a bonus, create score and bonus counting labels for a cool effect
            if (bonus!=0) {
                CGPoint pt = ccp(size.width/2, 5*size.height/8);
                CounterLabel* bonusLabel = [CounterLabel labelWithFont:@"Marker Felt"
                                                              position:pt value:bonus andString:@"Bonus: "];
                bonusLabel.color = ccc3(68, 14, 98);
                [self addChild:bonusLabel];
                [bonusLabel countTo:0 withDuration:0.5 afterDelay:1.0];
                
                CGPoint point = ccp(size.width/2, 11*size.height/16);
                CounterLabel* scoreLabel = [CounterLabel labelWithFont:@"Marker Felt"
                                                              position:point value:score andString:@"Score: "];
                scoreLabel.color = ccc3(68, 14, 98);
                [self addChild:scoreLabel];
                [scoreLabel countTo:score+bonus withDuration:0.5 afterDelay:1.0];
                
            //If they didn't get a bonus, display score in a normal label
            }else{
                CCSprite* scoreLabel = [CCSprite spriteWithFile:@"score1.png"];
                NSString* scoring = [[NSString alloc] initWithFormat:@" %d", score];
                CCLabelTTF* scoreText = [[CCLabelTTF alloc] initWithString:scoring fontName:@"Marker Felt" fontSize:50];
                scoreLabel.position = ccp(size.width/2 - scoreLabel.contentSize.width/2, 3*size.height/5);
                scoreText.position = ccp(size.width/2 + scoreLabel.contentSize.width/2, 3*size.height/5);
                scoreText.color = ccc3(68, 14, 98);
                [self addChild: scoreLabel];
                [self addChild: scoreText];
            }
            
            //Display the high score
            CCSprite* highScoreLabel = [CCSprite spriteWithFile:@"highscore.png"];
            NSString* highScores = [[NSString alloc] initWithFormat:@" %d", bestScore];
            CCLabelTTF* highScoreText  =  [[CCLabelTTF alloc] initWithString:highScores fontName:@"Marker Felt" fontSize:50];
            highScoreLabel.position = ccp(size.width/2 - highScoreLabel.contentSize.width/2 + 35, size.height/2);
            highScoreText.position = ccp(size.width/2 + highScoreLabel.contentSize.width/2 - 5, size.height/2);
            highScoreText.color = ccc3(68, 14, 98);
            [self addChild: highScoreLabel];
            [self addChild: highScoreText];
            
        }
        else {
            message = [CCSprite spriteWithFile:@"losecase.png"];
        }
        
        CCSprite* background = [CCSprite spriteWithFile:@"background3.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background z:-1];
        
        message.position = ccp(size.width/2, 6*size.height/8);
        [self addChild:message];
        
        [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:50];
        
        CCMenuItem* next = [CCMenuItemSprite itemWithNormalSprite:nextLevel selectedSprite:nextLevelSel block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameController node]]];
        }];
        CCSprite* menuUnselected = [CCSprite spriteWithFile:@"menu1.png"];
        CCSprite* menuSelected = [CCSprite spriteWithFile:@"menu2.png"];
        CCMenuItem* mainMenu = [CCMenuItemImage itemWithNormalSprite:menuUnselected selectedSprite:menuSelected block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MenuLayer node]]];
            [[LevelManager sharedInstance] reset];
        }];
        
        CCMenu* menu = [CCMenu menuWithItems:next, mainMenu, nil];
        menu.position = ccp(size.width/2, size.height/3);
        if (!won)
            menu.position = ccp(size.width/2, size.height/2);
        [menu alignItemsVerticallyWithPadding:25];
        [self addChild:menu];
        
        
    }
    return self;
}

@end