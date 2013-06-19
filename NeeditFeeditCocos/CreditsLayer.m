//
//  CreditsLayer.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/19/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "CreditsLayer.h"
#import "MenuLayer.h"


@implementation CreditsLayer

+(id) scene{
    //Initialize the scene
	CCScene *scene = [CCScene node];
	CreditsLayer *layer = [CreditsLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init{
    if (self = [super init]){
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        // Create Instructions Background
        CCSprite *background = [CCSprite spriteWithFile:@"background1.png"];
        background.scale = 3.0;
        background.position = ccp( 1.5*size.width, 1.5*size.height);

        [self addChild:background];
        
        
        // Create MenuItem
        [CCMenuItemFont setFontSize:24];
        [CCMenuItemFont setFontName:@"Marker Felt"];
        CCMenuItem *back = [CCMenuItemFont itemWithString:@"Main Menu" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MenuLayer node]]];
        }];
        
        //Create Menu
        CCMenu *menu = [CCMenu menuWithItems: back, nil];
        menu.position = ccp(size.width/2, size.height/8);
        [self addChild:menu];
        
        // Get the file from the resources
        NSString* path = [[NSBundle mainBundle] pathForResource:@"credits" ofType:@"txt"];
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
