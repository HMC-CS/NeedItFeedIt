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
static const int NUM_RESOURCEBARS = 2;
static const double ICON_SCALE = 0.2;

@implementation ResourceBar{
    CCSprite* backBar;
    CCSprite* innerBar;
    CCSprite* fillBar;
    CCSprite* icon;
    int percentage;
}

-(id) init{
    if (self = [super init]) {
        
        //Loads the sprites for the resource bars
        for (int i=0; i<NUM_RESOURCEBARS; i++)
        {
            percentage = 50;
            
            backBar = [CCSprite spriteWithFile:@"backbar.png"];
            backBar.anchorPoint = ccp(0,0.5);
            backBar.position = CGPointMake(-ORGANISM_WIDTH/2,-OFFSET*i);
            [backBar setTextureRect:CGRectMake(0, 0, ORGANISM_WIDTH, BAR_HEIGHT)];
            
            fillBar = [CCSprite spriteWithFile:@"fillBar.png"];
            fillBar.anchorPoint = ccp(0,0.5);
            fillBar.position = CGPointMake(-BAR_WIDTH/2,-OFFSET*i);
            [fillBar setTextureRect:CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT * 0.5)];
            
            innerBar = [CCSprite spriteWithFile:@"innerBar.png"];
            innerBar.anchorPoint = ccp(0,0.5);
            innerBar.position = CGPointMake(-(BAR_WIDTH/2 + 1),-OFFSET*i);
            [innerBar setTextureRect: CGRectMake(0, 0, BAR_WIDTH * 0.5, BAR_HEIGHT * 0.5)];
            
            icon = [CCSprite spriteWithFile:@"bunny.png"];
            icon.position = CGPointMake(backBar.position.x - OFFSET, -OFFSET*i);
            [icon setScale:ICON_SCALE];
            
            [super addChild: backBar];
            [super addChild:fillBar];
            [super addChild:innerBar];
            [super addChild:icon];
            
            [self updatePercentageToValue:percentage];

        }
        
        
        
        return self;
    }
    return nil;
}

-(void)updatePercentageToValue:(int)newValue
{
    
    percentage = newValue;
    
    // Fill up the bar, but maximize the width at 100%
    if( percentage > 100)
        [innerBar setTextureRect: CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT * 0.5)];
    else
        [innerBar setTextureRect: CGRectMake(0, 0, BAR_WIDTH * percentage / 100, BAR_HEIGHT * 0.5)];
    
    ccColor3B barColor = [self colorFromRed:[self redAmount] Green:[self greenAmount] Blue:0];
    
    innerBar.color = barColor;
    //fillBar.color = barColor;
}


-(void) decreaseSelf: (id) sender{
    NSLog(@"decreased");
}



// Generates an unsigned int representing a color.
// redFrac, greenFrac, blueFrac should be values from 0-1.
-(ccColor3B)colorFromRed: (float)redFrac Green: (float)greenFrac Blue: (float)blueFrac
{
    uint red = 0xff * redFrac;
    uint green = 0xff * greenFrac;
    uint blue = 0xff * blueFrac;
    
    return ccc3(red, green, blue);
}


// Increase green linearly: from 0 at 0 health to 1 at satisfied health
-(float)greenAmount
{
    if(percentage >= SATISFIED_HEALTH)
        return 1;
    else
        return (float)percentage / SATISFIED_HEALTH;
}


// Decrease red linearly: from 1 at 0 health to 0 at satisfied health
-(float)redAmount
{
    if(percentage >= SATISFIED_HEALTH)
        return 0;
    else
        //NSLog(@"%f", 1 - (float)percentage / SATISFIED_HEALTH);
        return 1 - (float)percentage / SATISFIED_HEALTH;
}

@end
