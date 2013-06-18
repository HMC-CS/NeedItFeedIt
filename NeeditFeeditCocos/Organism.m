//
//  Organism.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "Organism.h"


@implementation Organism{
    CCSprite* glow;
}

-(id) initWithString: (NSString*) name andResources: (NSArray*) resources {
    if (self = [super init]) {
        //Load the image and initialize the property values
        NSString* currentOrg = [[NSString alloc] initWithFormat:@"%@.png",name];
        _orgImage = [CCSprite spriteWithFile:currentOrg];
        _orgName = name;
        
        NSString* glowOrg = [[NSString alloc] initWithFormat:@"%@Glow.png", name];
        glow = [CCSprite spriteWithFile:glowOrg];
        glow.opacity = 0;
        
        //Set all of the resources as those passed to the organism
        _neededResources = [[NSArray alloc] initWithArray: resources];
        
        [super addChild: glow z:-1];
        [super addChild: _orgImage z:0];
        
        self.contentSize = CGSizeMake(_orgImage.contentSize.width, _orgImage.contentSize.height);
        
        return self;
    }
    return nil;
}

-(void) highlight{
    CCFadeTo* fadeIn = [CCFadeTo actionWithDuration:0.2 opacity:250];
    CCFadeTo* fadeOut = [CCFadeTo actionWithDuration:0.5 opacity:0];
    [glow runAction:[CCSequence actions:fadeIn, fadeOut, nil]];
}

-(BOOL) isSatisfied{
    return NO;
}

-(BOOL) isDead{
    return NO;
}

-(void) updateHealth{
    
}

@end
