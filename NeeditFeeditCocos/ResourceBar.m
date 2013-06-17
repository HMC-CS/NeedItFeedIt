//
//  ResourceBar.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "ResourceBar.h"


@implementation ResourceBar{
    CCSprite* backBar;
    CCSprite* innerBar;
    CCSprite* fillBar;
}

-(id) init{
    if (self = [super init]) {
        //Loads the background sprite for the resource bar
        backBar = [CCSprite spriteWithFile:@"backbar.png"];
        backBar.anchorPoint = ccp(0,0.5);
        backBar.position = CGPointMake(-backBar.boundingBox.size.width/2, 0);
        
        fillBar = [CCSprite spriteWithFile:@"fillBar.png"];
        fillBar.scaleX = 0.85;
        fillBar.scaleY = 0.5;
        fillBar.anchorPoint = ccp(0,0.5);
        fillBar.position = CGPointMake(-fillBar.boundingBox.size.width/2, 0);
        
        innerBar = [CCSprite spriteWithFile:@"innerBar.png"];
        innerBar.scaleX = 0.85;
        innerBar.scaleY = 0.5;
        innerBar.anchorPoint = ccp(0,0.5);
        innerBar.position = CGPointMake(-innerBar.boundingBox.size.width/2, 0);
        
        [innerBar setTextureRect: CGRectMake(0, 0, innerBar.contentSize.width/2, innerBar.contentSize.height)];
        //innerBar.position = CGPointMake(-58, fillBar.position.y);
        
        [super addChild: backBar];
        [super addChild:fillBar];
        [super addChild:innerBar];
        
        innerBar.scaleX = 1.5;
        
        return self;
    }
    return nil;
}

-(void) increaseSelf{
    
}

-(void) decreaseSelf: (id) sender{
    NSLog(@"decreased");
}

@end
