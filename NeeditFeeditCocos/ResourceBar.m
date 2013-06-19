//
//  ResourceBar.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "ResourceBar.h"
#import "Organism.h"

static const int ORGANISM_WIDTH = 204;
static const int BAR_WIDTH = ORGANISM_WIDTH * 0.9;
static const int BAR_HEIGHT = 18;
static const int MAX_HEALTH = 100;
static const int SATISFIED_HEALTH = 85;
static const int ICON_HEIGHT = 170;
static const int OFFSET = 30;
static const double ICON_SCALE = 0.2;
static const ccTime DELTA = 1.0;
static const int PERCENT_DECAY = 1;


@implementation ResourceBar{
    CCSprite* backBar;
    CCSprite* innerBar;
    CCSprite* fillBar;
    CCSprite* icon;
    int percentage;
    NSTimer* timer;
    ccTime* delta;
}

-(id) init{
    if (self = [super init]) {
        //Set initial percentage, bars are initially half full
        percentage = 50;
        
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
        
        //icon = [CCSprite spriteWithFile:@"%@", Organism._neededresources[i][0]];
        icon = [CCSprite spriteWithFile:@"bunny.png"];
        icon.position = CGPointMake(backBar.position.x - OFFSET, 0);
        [icon setScale:ICON_SCALE];
        
        [super addChild: backBar];
        [super addChild:fillBar];
        [super addChild:innerBar];
        [super addChild:icon];
        
        //percentage += frequency/10;
        
        [self updateBar:percentage];
        
        //Schedule decreasing of resource bars
        [self schedule:@selector(update:) interval:DELTA];
        
        return self;
    }
    return nil;
}

-(void) update:(ccTime)delta{
    [self updateBar:percentage];
    [self decreasePercentage];
    
}

-(void)updateBar:(int)newPercentage
{
    // Set color of bars
    ccColor3B barColor = [self colorFromRed:[self redAmount] Green:[self greenAmount] Blue:0];    
    innerBar.color = barColor;

    // Update percentage with current value
    percentage = newPercentage;
    
    if( percentage >= 100) {    // max bar width = %100
        [innerBar setTextureRect: CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT * 0.5)];
        percentage = 100;
    }
    else
        [innerBar setTextureRect: CGRectMake(0, 0, BAR_WIDTH * percentage / 100, BAR_HEIGHT * 0.5)];
}

-(void) decreasePercentage {
    percentage -= PERCENT_DECAY;
    
    if (percentage <= 0)    // min percentage = %0
        percentage = 0;
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

@end
