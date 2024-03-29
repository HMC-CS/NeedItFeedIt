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
static const double ICON_SCALE = 0.25;
static const int PERCENT_DECAY = 5;


@implementation ResourceBar{
    CCSprite* backBar;
    CCSprite* innerBar;
    CCSprite* fillBar;
    CCSprite* icon;
    float percentage;
    NSArray* resources;
}

-(id) initGivenResources:(NSArray*) resource andDecay: (int) decay{
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
        
        [self schedule:@selector(decreaseUpdate) interval:decay];
        
        return self;
    }
    return nil;
}

-(void) decreaseUpdate{
    [self updateBar:-PERCENT_DECAY];
    
    //Check for death
    [self checkDeath];
    
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
        if (percentage<0) {
            percentage = 0;
        }
        [innerBar setTextureRect: CGRectMake(0, 0, BAR_WIDTH * percentage / 100, BAR_HEIGHT * 0.5)];
}

-(float) getPercentage{
    return percentage;
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

-(BOOL) checkSuccess {
    if (percentage >= 99) {
        return true;
    }
    return false;

}

-(void) checkDeath{
    if (percentage<=0) {
        CCScene *loseScene = [GameOverLayer sceneWithWon:NO andScore:0 andBonus:0];
        [[CCDirector sharedDirector] replaceScene:loseScene];
    }
}


@end
