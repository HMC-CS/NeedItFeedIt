//
//  Organism.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "Organism.h"
#import "ResourceBar.h"


@implementation Organism{
    CCSprite* glow;
}

-(id) initWithString: (NSString*) name andResources: (NSArray*) resources {
    if (self = [super init]) {

        //Load the image and initialize the property values
        NSString* currentOrg = [[NSString alloc] initWithFormat:@"%@.png",name];
        _orgImage = [CCSprite spriteWithFile:currentOrg];
        _orgName = name;
        
        //Loads the glowing background and sets transparency to 0
        NSString* glowOrg = [[NSString alloc] initWithFormat:@"%@Glow.png", name];
        glow = [CCSprite spriteWithFile:glowOrg];
        glow.opacity = 0;
        
        //Set all of the resources as those passed to the organism
        _neededResources = [[NSArray alloc] initWithArray: resources];
       // NSLog(@"r1: %@", _neededResources[0][0]);
       // NSLog(@"r2: %@", _neededResources[1]);
        
        
        //Adds the glow and the orgImage to the layer
        [self addChild: glow z:-1];
        [self addChild: _orgImage z:0];
        
        self.contentSize = CGSizeMake(_orgImage.textureRect.size.width, _orgImage.textureRect.size.height);
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
    //if (ResourceBar.percentage == 100)
        return NO;
}

-(BOOL) isDead{
    //if (ResourceBar.percentage == 0)
    return NO;
}

-(void) updateHealth{
    
}

@end
