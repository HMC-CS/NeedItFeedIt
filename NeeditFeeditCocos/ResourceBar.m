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
}

-(id) init{
    if (self = [super init]) {
        //Loads the background sprite for the resource bar
        backBar = [CCSprite spriteWithFile:@"backbar.png"];
        [super addChild: backBar];
        
        innerBar = [CCSprite spriteWithFile:@"innerBar.png"];
        innerBar.scaleX = 0.85;
        innerBar.scaleY = 0.5;
        CCTexture2D* fill = [[CCTextureCache sharedTextureCache] addImage:@"fillBar.png"];
        [innerBar setTexture:fill];
        [innerBar setTextureRect:CGRectMake(innerBar.position.x, innerBar.position.y,
                                           innerBar.contentSize.width/2, innerBar.contentSize.height)];
        
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
