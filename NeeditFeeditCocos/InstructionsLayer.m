//
//  InstructionsLayer.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/19/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "InstructionsLayer.h"
#import "MenuLayer.h"


@implementation InstructionsLayer

+(id) scene{
    //Initialize the scene
	CCScene *scene = [CCScene node];
	InstructionsLayer *layer = [InstructionsLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init{
    if (self = [super init]){
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        // Create Instructions Background
        CCSprite *background = [CCSprite spriteWithFile:@"background1.png"];
        background.scale = 2.0;
        background.position = ccp(0, 0);
        [self addChild:background];
        
        
        // Create MenuItem
        [CCMenuItemFont setFontSize:24];
        [CCMenuItemFont setFontName:@"Marker Felt"];
        CCMenuItemImage *back = [CCMenuItemImage itemWithNormalImage:@"menu3.png" selectedImage:@"menu2.png" block:^(id sender)  {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MenuLayer node]]];
        }];
        
        //Create Menu
        CCMenu *menu = [CCMenu menuWithItems: back, nil];
        menu.position = ccp(size.width/2, size.height/8);
        [self addChild:menu];
        
        // Get the file from the resources
        NSString* path = [[NSBundle mainBundle] pathForResource:@"instructions" ofType:@"txt"];
        NSString* fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        // Create the label
        CCLabelTTF *label = [CCLabelTTF labelWithString:fileContents fontName:@"Marker Felt" fontSize:34];
        [label setColor:ccWHITE];
        label.position = ccp(size.width/2,size.height/2);
        [self addChild:label];
        
    }
    return self;
}

@end
