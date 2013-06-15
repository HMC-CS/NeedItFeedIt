//
//  Organism.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "Organism.h"


@implementation Organism{
    NSArray* resource1;
    NSArray* resource2;
    NSArray* resource3;
}

-(id) initWithString: (NSString*) name andResource1: (NSArray*) res1
        andResource2: (NSArray*) res2 andResource3: (NSArray*) res3 {
    if (self = [super init]) {
        //Load the image and initialize the property values
        NSString* currentOrg = [[NSString alloc] initWithFormat:@"%@.png",name];
        _orgImage = [CCSprite spriteWithFile:currentOrg];
        _orgName = name;
        
        //Set all of the resources as those passed to the organism
        resource1 = [[NSArray alloc] initWithArray:res1];
        resource2 = [[NSArray alloc] initWithArray:res2];
        resource3 = [[NSArray alloc] initWithArray:res3];
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
