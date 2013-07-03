//
//  InstructionsLayer.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/19/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "InstructionsLayer.h"
#import "MenuLayer.h"
#import "SimpleAudioEngine.h"


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
        CCSprite *background = [CCSprite spriteWithFile:@"background5.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background];
        
        
        // Create MenuItem
        CCMenuItemImage *back = [CCMenuItemImage itemWithNormalImage:@"menu1.png" selectedImage:@"menu2.png" block:^(id sender)  {
            [[SimpleAudioEngine sharedEngine] playEffect:@"menu.wav"];
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
        CCLabelTTF *label = [CCLabelTTF labelWithString:fileContents fontName:@"Hobo" fontSize:34];
        label.color = ccc3(40, 0, 92);
        label.position = ccp(size.width/2,size.height/3);
        [self addChild:label];
        
        
        // Add screenshot image
        CCSprite *screenshot = [CCSprite spriteWithFile:@"screenshot.png"];
        screenshot.position = ccp(size.width/2 - 50, 2*size.height/3 + 20);
        [self addChild:screenshot];
        
    }
    return self;
}

@end
