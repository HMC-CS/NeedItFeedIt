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

@implementation GameOverLayer

+(CCScene *) sceneWithWon:(BOOL)won {
    CCScene *scene = [CCScene node];
    GameOverLayer *layer = [[GameOverLayer alloc] initWithWon:won];
    [scene addChild: layer];
    return scene;
}

- (id)initWithWon:(BOOL)won {
    if (self = [super init]) {
        
        [[LevelManager sharedInstance] nextLevel];
        Level* curLevel = [[LevelManager sharedInstance] currentLevel];
        NSString * message;
        NSString* nextLevel = [[NSString alloc] initWithFormat:@" "];
        if (won && curLevel) {
            message = @"You Won!";
            nextLevel = @"Next Level";
        } else if (won){
            message = @"You Won!";
            [[LevelManager sharedInstance] reset];
        }
        else {
            message = @"You Lost!";
            [[LevelManager sharedInstance] reset];
        }
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite* background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background z:-1];
        
        CCLabelTTF * label = [CCLabelTTF labelWithString:message fontName:@"Arial" fontSize:60];
        label.color = ccBLUE;
        label.position = ccp(size.width/2, 3*size.height/4);
        [self addChild:label];
        
        [CCMenuItemFont setFontName:@"Arial"];
        [CCMenuItemFont setFontSize:32];
        
        CCMenuItem* next = [CCMenuItemFont itemWithString:nextLevel block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameController node]]];
        }];
        next.color = ccBLACK;
        
        CCMenuItem* mainMenu = [CCMenuItemFont itemWithString:@"Main Menu" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MenuLayer node]]];
        }];
        mainMenu.color = ccBLACK;
        
        CCMenu* menu = [CCMenu menuWithItems:next, mainMenu, nil];
        menu.position = ccp(size.width/2, size.height/2);
        [menu alignItemsVerticallyWithPadding:25];
        [self addChild:menu];
        
        
    }
    return self;
}

@end
