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
#import "SimpleAudioEngine.h"


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
        CCSprite *background = [CCSprite spriteWithFile:@"background3.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background];
        
        
        // Create MenuItem
        CCMenuItem *back = [CCMenuItemImage itemWithNormalImage:@"menu1.png" selectedImage:@"menu2.png" block:^(id sender) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"menu.wav"];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MenuLayer node]]];
        }];
        
        //Create Menu
        CCMenu *menu = [CCMenu menuWithItems: back, nil];
        menu.position = ccp(size.width/2, size.height/8);
        [self addChild:menu];
        
        CCMenuItemImage *Forest = nil;
        CCMenuItemImage *Ocean = nil;
        CCMenuItemImage *Desert = nil;
        CCMenuItemImage *Savanna = nil;
        CCMenuItemImage *Arctic = nil;
        
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Data.plist"]];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath: path]){
            NSLog(@"File don't exists at path %@", path);
            
            NSString *plistPathBundle = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
            
            [fileManager copyItemAtPath:plistPathBundle toPath: path error:&error];
        }else{
            NSLog(@"File exists at path:%@", path);
        }

        NSDictionary* plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSDictionary* forest = plistDictionary[@"Forest"];
        if ([forest[@"unlocked"] boolValue]) {
            Forest = [CCMenuItemImage itemWithNormalImage:@"forest1.png" selectedImage:@"forestsel.png" target:self selector:@selector(goToForest)];
        }
        NSDictionary* ocean = plistDictionary[@"Ocean"];
        if ([ocean[@"unlocked"] boolValue]) {
            Ocean = [CCMenuItemImage itemWithNormalImage:@"ocean1.png" selectedImage:@"oceansel.png" target:self selector:@selector(goToOcean)];
        }
        NSDictionary* desert = plistDictionary[@"Desert"];
        if ([desert[@"unlocked"] boolValue]) {
            Desert = [CCMenuItemImage itemWithNormalImage:@"desert1.png" selectedImage:@"desertsel.png" target:self selector:@selector(goToDesert)];
        }
        NSDictionary* savanna = plistDictionary[@"Savanna"];
        if ([savanna[@"unlocked"]boolValue]) {
            Savanna = [CCMenuItemImage itemWithNormalImage:@"savanna1.png" selectedImage:@"savannasel.png" target:self selector:@selector(goToSavanna)];
        }
        NSDictionary* arctic = plistDictionary[@"Arctic"];
        if ([arctic[@"unlocked"] boolValue]) {
            Arctic = [CCMenuItemImage itemWithNormalImage:@"arctic1.png" selectedImage:@"arcticsel.png" target:self selector:@selector(goToArctic)];
        }
        
        CCMenu* menu2 = [CCMenu menuWithItems:Forest, Ocean, Desert, Savanna, Arctic, nil];
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
    [[SimpleAudioEngine sharedEngine] playEffect:@"menu.wav"];
    [[LevelManager sharedInstance] startAtLevel:@"Forest"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameController node]]];
}

-(void) goToOcean{
    [[SimpleAudioEngine sharedEngine] playEffect:@"menu.wav"];
    [[LevelManager sharedInstance] startAtLevel:@"Ocean"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameController node]]];
}

-(void) goToDesert{
    [[SimpleAudioEngine sharedEngine] playEffect:@"menu.wav"];
    [[LevelManager sharedInstance] startAtLevel:@"Desert"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameController node]]];
}

-(void) goToSavanna{
    [[SimpleAudioEngine sharedEngine] playEffect:@"menu.wav"];
    [[LevelManager sharedInstance] startAtLevel:@"Savanna"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameController node]]];
}

-(void) goToArctic{
    [[SimpleAudioEngine sharedEngine] playEffect:@"menu.wav"];
    [[LevelManager sharedInstance] startAtLevel:@"Arctic"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameController node]]];
}

@end
