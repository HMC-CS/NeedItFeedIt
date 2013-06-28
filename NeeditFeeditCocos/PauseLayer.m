//
//  PauseLayer.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/24/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "PauseLayer.h"
#import "MenuLayer.h"
#import "LevelManager.h"

@implementation PauseLayer

+(id) scene{
    //Initialize the scene
	CCScene *scene = [CCScene node];
	PauseLayer *layer = [PauseLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init{
    if (self = [super init]){
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        // Create Instructions Background
        Level* curLevel = [[LevelManager sharedInstance] currentLevel];
        NSString* backPic = [[NSString alloc] initWithFormat:@"%@.png", curLevel.ecosystem];
        CCSprite *background = [CCSprite spriteWithFile:backPic];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background];
        
        
        // Create MenuItem
        [CCMenuItemFont setFontSize:36];
        [CCMenuItemFont setFontName:@"Marker Felt"];
        
        CCMenuItemImage* resume = [CCMenuItemImage itemWithNormalImage:@"resume.png" selectedImage:@"resumeSel.png" block:^(id sender) {
            [[CCDirector sharedDirector] popScene];
        }];
        
        CCMenuItem *back = [CCMenuItemImage itemWithNormalImage:@"mainMenu.png" selectedImage:@"mainMenuSel.png" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MenuLayer node]]];
        }];

        
        //Create Menu
        CCMenu *menu = [CCMenu menuWithItems: resume, back, nil];
        [menu alignItemsVerticallyWithPadding:25];
        menu.position = ccp(size.width/2, size.height/2);
        [self addChild:menu];
    }
    return self;
}

@end
