//
//  HelloWorldLayer.m
//  NeeditFeeditCocos
//
//  Created by Haley Erickson on 6/7/13.
//  Copyright Haley Erickson 2013. All rights reserved.
//


// Import the interfaces
#import "MenuLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "PickLevelLayer.h"
#import "InstructionsLayer.h"
#import "CreditsLayer.h"
#import "SimpleAudioEngine.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation MenuLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        //Create and add background
        CCSprite* background = [CCSprite spriteWithFile:@"background4.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background z:-1];
        
		// create title label
        CCSprite* title = [CCSprite spriteWithFile:@"title.png"];
		title.position =  ccp( size.width /2 , size.height/1.5 );
        
        CCMenuItemImage* start =[CCMenuItemImage itemWithNormalImage:@"start.png" selectedImage:@"startSel.png" target:self selector:@selector(goToLevelPick:)];
        
        //Create an instructions menu item 
        CCMenuItemImage* instructions  = [CCMenuItemImage itemWithNormalImage:@"instructions.png" selectedImage:@"instructionsSel.png" target:self selector:@selector(goToInstructions:)];

        //Create a credits menu item
        CCMenuItemImage* credits  = [CCMenuItemImage itemWithNormalImage:@"credits.png" selectedImage:@"creditsSel.png" target:self selector:@selector(goToCredits:)];
        
        //Create the menu to hold the start command
        CCMenu* topMenu = [CCMenu menuWithItems:start, nil];
        topMenu.position = ccp(size.width/2, size.height/3);
        
        CCMenu* bottomMenu = [CCMenu menuWithItems:instructions, credits, nil];
        bottomMenu.position = ccp(size.width/2, size.height/6);
        [bottomMenu alignItemsHorizontallyWithPadding:100];
		
		// add the label and menu as a child to this Layer
		[self addChild: title];
        [self addChild:topMenu];
        [self addChild:bottomMenu];
		
		
    }
        return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
}

-(void) goToLevelPick: (id) sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"menu.wav"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[PickLevelLayer node]]];
}

-(void) goToInstructions: (id) sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"menu.wav"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[InstructionsLayer node]]];
}

-(void) goToCredits: (id) sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"menu.wav"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[CreditsLayer node]]];
}

#pragma mark GameKit delegate

@end
