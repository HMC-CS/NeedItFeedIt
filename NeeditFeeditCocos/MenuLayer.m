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

#import "GameController.h"

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
        CCSprite* background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background z:-1];
		
		// create title label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Need It Feed It" fontName:@"Arial Rounded MT Bold" fontSize:36];
		label.position =  ccp( size.width /2 , size.height/2 );
        
        //Create a menu item as a start button
        [CCMenuItemFont setFontName:@"Arial Rounded MT Bold"];
        [CCMenuItemFont setFontSize:30];
        CCMenuItem* start = [CCMenuItemFont itemWithString:@"Start" target:self selector:@selector(goToGame:)];
        
        //Create the menu to hold the start command
        CCMenu* menu = [CCMenu menuWithItems:start, nil];
        menu.position = ccp(size.width/2, size.height/4);
		
		// add the label and menu as a child to this Layer
		[self addChild: label];
        [self addChild:menu];
		
		
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
	[super dealloc];
}

-(void) goToGame: (id) sender{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameController node] withColor:ccBLACK]];
}

#pragma mark GameKit delegate

@end
