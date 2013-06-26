//
//  PickLevelLayer.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/20/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "PickLevelLayer.h"
#import "MenuLayer.h"
#import "GameController.h"
#import "LevelManager.h"


@implementation PickLevelLayer

+(id) scene{
    //Initialize the scene
	CCScene *scene = [CCScene node];
	PickLevelLayer *layer = [PickLevelLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init{
    if (self = [super init]){
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        // Create Instructions Background
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.scale = 2.0;
        background.position = ccp(0, 0);
        [self addChild:background];
        
        
        // Create MenuItem
        [CCMenuItemFont setFontSize:36];
        [CCMenuItemFont setFontName:@"Marker Felt"];
        
        CCMenuItem *back = [CCMenuItemFont itemWithString:@"Main Menu" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MenuLayer node]]];
        }];
        back.color = ccBLACK;
        
        //Create Menu
        CCMenu *menu = [CCMenu menuWithItems: back, nil];
        menu.position = ccp(size.width/2, size.height/8);
        [self addChild:menu];
        
        CCMenuItem *forest = [CCMenuItemFont itemWithString:@"1. Forest" target:self selector:@selector(goToForest)];
        forest.color = ccBLACK;
        CCMenuItem *ocean = [CCMenuItemFont itemWithString:@"2. Ocean" target:self selector:@selector(goToOcean)];
        ocean.color = ccBLACK;
        CCMenuItem *desert = [CCMenuItemFont itemWithString:@"3. Desert" target:self selector:@selector(goToDesert)];
        desert.color = ccBLACK;
        CCMenuItem *savanna = [CCMenuItemFont itemWithString:@"4. Savanna" target:self selector:@selector(goToSavanna)];
        savanna.color = ccBLACK;
        CCMenuItem *arctic = [CCMenuItemFont itemWithString:@"5. Arctic" target:self selector:@selector(goToArctic)];
        arctic.color = ccBLACK;
        
        CCMenu* menu2 = [CCMenu menuWithItems:forest, ocean, desert, savanna, arctic, nil];
        menu2.position = ccp(size.width/2, size.height/2);
        [menu2 alignItemsVerticallyWithPadding:25];
        [self addChild:menu2];
        
    }
    return self;
}

-(void) goToForest{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameController node]]];
}

-(void) goToOcean{
    [[LevelManager sharedInstance] startAtLevel:@"Ocean"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameController node]]];
}

-(void) goToDesert{
    [[LevelManager sharedInstance] startAtLevel:@"Desert"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameController node]]];
}

-(void) goToSavanna{
    [[LevelManager sharedInstance] startAtLevel:@"Savanna"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameController node]]];
}

-(void) goToArctic{
    [[LevelManager sharedInstance] startAtLevel:@"Arctic"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameController node]]];
}

@end
