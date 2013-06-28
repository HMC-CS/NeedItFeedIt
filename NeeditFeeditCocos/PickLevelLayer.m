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
        CCMenuItemImage *back = [CCMenuItemImage itemWithNormalImage:@"mainMenu.png" selectedImage:@"mainMenuSel.png" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MenuLayer node]]];
        }];
        
        //Create Menu
        CCMenu *menu = [CCMenu menuWithItems: back, nil];
        menu.position = ccp(size.width/2, size.height/8);
        [self addChild:menu];
        
        CCMenuItemImage *forest = [CCMenuItemImage itemWithNormalImage:@"forest1.png" selectedImage:@"forestsel.png" target:self selector:@selector(goToForest)];
        CCMenuItemImage *ocean = [CCMenuItemImage itemWithNormalImage:@"ocean1.png" selectedImage:@"oceansel.png" target:self selector:@selector(goToOcean)];
        CCMenuItemImage *desert = [CCMenuItemImage itemWithNormalImage:@"desert1.png" selectedImage:@"desertsel.png" target:self selector:@selector(goToDesert)];
        CCMenuItemImage *savanna = [CCMenuItemImage itemWithNormalImage:@"savanna1.png" selectedImage:@"savannasel.png" target:self selector:@selector(goToSavanna)];
        CCMenuItemImage *arctic = [CCMenuItemImage itemWithNormalImage:@"arctic1.png" selectedImage:@"arcticsel.png" target:self selector:@selector(goToArctic)];
        
        CCMenu* menu2 = [CCMenu menuWithItems:forest, ocean, desert, savanna, arctic, nil];
        menu2.position = ccp(size.width/2, size.height/2);
        [menu2 alignItemsVerticallyWithPadding:25];
        [self addChild:menu2];
            
        CCMenuItemImage *pickLevelTitle = [CCMenuItemImage itemWithNormalImage:@"pickLevelTitle.png" selectedImage:@"pickLevelTitle.png"];
        CCMenu* menu3 = [CCMenu menuWithItems: pickLevelTitle, nil];
        menu3.position = ccp(size.width/2, 3.3*size.height/4);
        [self addChild:menu3];
        
    }
    return self;
}

-(void) goToForest{
    [[LevelManager sharedInstance] startAtLevel:@"Forest"];
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
