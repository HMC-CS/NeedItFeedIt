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
        
        innerBar = [CCSprite spriteWithFile:@"innerBar.png"];
        innerBar.scaleX = 0.85;
        innerBar.scaleY = 0.5;
        
        
        

        fillBar = [CCSprite spriteWithFile:@"fillBar.png"];
        fillBar.scaleX = 0.85;
        fillBar.scaleY = 0.5;
        NSLog(@"%f", fillBar.contentSize.width);
        [innerBar setTextureRect: CGRectMake( 0, 0, innerBar.contentSize.width/2, innerBar.contentSize.height)];
        innerBar.position = CGPointMake(-58, fillBar.position.y);
        
        [super addChild: backBar];
        [super addChild:fillBar];
        [super addChild:innerBar];
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
