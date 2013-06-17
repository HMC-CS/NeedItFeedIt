//
//  Organism.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "Organism.h"


@implementation Organism

-(id) initWithString: (NSString*) name andResources: (NSArray*) resources {
    if (self = [super init]) {
        //Load the image and initialize the property values
        NSString* currentOrg = [[NSString alloc] initWithFormat:@"%@.png",name];
        _orgImage = [CCSprite spriteWithFile:currentOrg];
        _orgName = name;
        
        //Set all of the resources as those passed to the organism
        _neededResources = [[NSArray alloc] initWithArray: resources];
        return self;
    }
    return nil;
}

-(void) highlight{
    
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
