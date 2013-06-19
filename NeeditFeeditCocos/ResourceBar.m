//
//  ResourceBar.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "ResourceBar.h"
#import "GameOverLayer.h"

static const int ORGANISM_WIDTH = 204;
static const int BAR_WIDTH = ORGANISM_WIDTH * 0.9;
static const int BAR_HEIGHT = 18;
static const int MAX_HEALTH = 100;
static const int SATISFIED_HEALTH = 85;
static const int ICON_HEIGHT = 170;
static const int OFFSET = 30;
static const double ICON_SCALE = 0.2;
static const ccTime DELTA = 1.0;
static const int PERCENT_DECAY = 10;


@implementation ResourceBar{
    CCSprite* backBar;
    CCSprite* innerBar;
    CCSprite* fillBar;
    CCSprite* icon;
    float percentage;
    NSTimer* timer;
    ccTime* delta;
    NSArray* resources;
}

-(id) initGivenResources:(NSArray*) resource {
    if (self = [super init]) {
        
        resources = [[NSArray alloc] initWithArray:resource];
        
        //Loads the sprites for the resource bars
        backBar = [CCSprite spriteWithFile:@"backbar.png"];
        backBar.anchorPoint = ccp(0,0.5);
        backBar.position = CGPointMake(-ORGANISM_WIDTH/2,0);
        [backBar setTextureRect:CGRectMake(0, 0, ORGANISM_WIDTH, BAR_HEIGHT)];
        
        fillBar = [CCSprite spriteWithFile:@"fillBar.png"];
        fillBar.anchorPoint = ccp(0,0.5);
        fillBar.position = CGPointMake(-BAR_WIDTH/2,0);
        [fillBar setTextureRect:CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT * 0.5)];
        
        innerBar = [CCSprite spriteWithFile:@"innerBar.png"];
        innerBar.anchorPoint = ccp(0,0.5);
        innerBar.position = CGPointMake(-(BAR_WIDTH/2 + 1),0);
        [innerBar setTextureRect: CGRectMake(0, 0, BAR_WIDTH * 0.5, BAR_HEIGHT * 0.5)];
        
        NSString* name = [[NSString alloc] initWithFormat:@"%@.png", resources[0]];
        icon = [CCSprite spriteWithFile:name];
        icon.position = CGPointMake(backBar.position.x - OFFSET, 0);
        [icon setScale:ICON_SCALE];
        
        [super addChild: backBar];
        [super addChild:fillBar];
        [super addChild:innerBar];
        [super addChild:icon];
        
        //Starts bar at 50%
        [self updateBar:50.0];
        
        //Schedule decreasing of resource bars
        [self schedule:@selector(decreaseUpdate:) interval:DELTA];
        
        return self;
    }
    return nil;
}

-(void) decreaseUpdate:(ccTime)delta{
    if (percentage>=PERCENT_DECAY) {
        [self updateBar:-PERCENT_DECAY];
    }
    
    //Check for success
    [self checkSuccess];
    
}

-(void)updateBar:(float)addedPercentage
{
    // Update percentage with current value
    percentage += addedPercentage;
    
    // Set color of bars
    ccColor3B barColor = [self colorFromRed:[self redAmount] Green:[self greenAmount] Blue:0];
    innerBar.color = barColor;
    
    if( percentage >= 100) {    // max bar width = %100
        [innerBar setTextureRect: CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT * 0.5)];
        percentage = 100;
    }
    else
        [innerBar setTextureRect: CGRectMake(0, 0, BAR_WIDTH * percentage / 100, BAR_HEIGHT * 0.5)];
}

-(ccColor3B)colorFromRed: (float)redFrac Green: (float)greenFrac Blue: (float)blueFrac
{
    uint red = 0xff * redFrac;
    uint green = 0xff * greenFrac;
    uint blue = 0xff * blueFrac;
    
    return ccc3(red, green, blue);
}

-(float)greenAmount
{
    if(percentage >= SATISFIED_HEALTH)
        return 1;
    else
        return (float)percentage / SATISFIED_HEALTH;
}

-(float)redAmount
{
    if(percentage >= SATISFIED_HEALTH)
        return 0;
    else
        return 1 - (float)percentage / SATISFIED_HEALTH;
}

-(void) checkSuccess {
    if (percentage <= 0) {
        CCScene *loseScene = [GameOverLayer sceneWithWon:NO];
        [[CCDirector sharedDirector] replaceScene:loseScene];
    }
    if (percentage >= 99) {
        CCScene *winScene = [GameOverLayer sceneWithWon:YES];
        [[CCDirector sharedDirector] replaceScene:winScene];
    }

}


@end
