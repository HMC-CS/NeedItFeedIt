//
//  Organism.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "Organism.h"


@implementation Organism

-(id) initWithString: (NSString*) name{
    if (self = [super init]) {
        //Load the image and initialize the property values
        NSString* currentOrg = [[NSString alloc] initWithFormat:@"%@.png",name];
        _orgImage = [CCSprite spriteWithFile:currentOrg];
        _orgName = name;
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
