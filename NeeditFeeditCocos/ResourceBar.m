//
//  ResourceBar.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "ResourceBar.h"

static const int ORGANISM_WIDTH = 204;
static const int BAR_WIDTH = ORGANISM_WIDTH * 0.9;
static const int BAR_HEIGHT = 18;
static const int MAX_HEALTH = 100;
static const int SATISFIED_HEALTH = 85;

@implementation ResourceBar{
    CCSprite* backBar;
    CCSprite* innerBar;
    CCSprite* fillBar;
    int percentage;
}

-(id) init{
    if (self = [super init]) {
        //Loads the background sprite for the resource bar
        backBar = [CCSprite spriteWithFile:@"backbar.png"];
        backBar.anchorPoint = ccp(0,0.5);
        backBar.position = CGPointMake(-ORGANISM_WIDTH/2,0);//-backBar.boundingBox.size.width/2, 0);
        //backBar.color = ccc3(0x00, 0x00, 0x00);
        [backBar setTextureRect:CGRectMake(0, 0, ORGANISM_WIDTH, BAR_HEIGHT)];
        
        fillBar = [CCSprite spriteWithFile:@"fillBar.png"];
        //fillBar.scaleX = 0.85;
        //fillBar.scaleY = 0.5;
        fillBar.anchorPoint = ccp(0,0.5);
        fillBar.position = CGPointMake(-BAR_WIDTH/2,0);//-fillBar.boundingBox.size.width/2, 0);
        //fillBar.color = ccc3(0xff, 0x00, 0x00);
        [fillBar setTextureRect:CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT * 0.5)];
        
        innerBar = [CCSprite spriteWithFile:@"innerBar.png"];
        //innerBar.scaleX = 0.85;
        //innerBar.scaleY = 0.5;
        innerBar.anchorPoint = ccp(0,0.5);
        innerBar.position = CGPointMake(-BAR_WIDTH/2,0);//-innerBar.boundingBox.size.width/2, 0);
        //innerBar.color = ccc3(0x00, 0x00, 0x00);
        
        [innerBar setTextureRect: CGRectMake(0, 0, BAR_WIDTH * 0.5, BAR_HEIGHT * 0.5)];//innerBar.contentSize.width/2, innerBar.contentSize.height)];
        //[innerBar setTextureRect:CGRectMake(0, 0, 50, BAR_HEIGHT - 2)];
        //innerBar.position = CGPointMake(-58, fillBar.position.y);
        
        [super addChild: backBar];
        [super addChild:fillBar];
        [super addChild:innerBar];
        
//        healthBarBackground.x = healthBarOutline.x + 2;
//        healthBarBackground.y = healthBarOutline.y + 1;
//        healthBar.x = healthBarBackground.x;
//        healthBar.y = healthBarBackground.y;
        
        [self updatePercentageToValue:percentage];
        
        return self;
    }
    return nil;
}

-(void) increaseSelf{
    
}

-(void) decreaseSelf: (id) sender{
    NSLog(@"decreased");
}

-(void)updatePercentageToValue:(int)newValue
{
    percentage = newValue;
    
    // Fill up the bar, but maximize the width at 100%
    //if( percentage > 100)
        //innerBar.boundingBox.size.width = BAR_WIDTH;
    //else
        //innerBar.boundingBox.size.width = percentage * BAR_WIDTH / 100;
    
    //int barColor = [self colorFromRed:[self redAmount] Green:[self greenAmount] Blue:0];
    
    //innerBar.color = barColor;
    //fillBar.color = barColor;
}


// Generates an int representing a color.
// redFrac, greenFrac, blueFrac should be values from 0-1.
-(uint)colorFromRed: (float)redFrac Green: (float)greenFrac Blue: (float)blueFrac
{
    // Unfortunately, the math has to be done in hexadecimal.
    // Fortunately, I actually found myself enjoying doing math in hexadecimal. Math/CS major FTW :)
    uint red = 0xff * redFrac;
    uint green = 0xff * greenFrac;
    uint blue = 0xff * blueFrac;
    
    // You see, it's LIKE math, except in base 256, and represented in base 16!
    return red * 0x10000 + green * 0x100 + blue;
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
        return 1 - (float)percentage / SATISFIED_HEALTH;
}

@end
