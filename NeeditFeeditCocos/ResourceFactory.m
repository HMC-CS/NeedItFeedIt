//
//  ResourceFactory.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "ResourceFactory.h"


@implementation ResourceFactory

-(id) initWithOrganisms:(NSMutableArray *)organisms{
    if (self = [super init]) {
        //Initialize necessary variables
        _orgsAndResources = [[NSMutableArray alloc] init];
        _displayResources = [[NSMutableArray alloc] init];
        
        //Finds the Resources file and loads it into a dictionary format
        NSString* fileName = [NSString stringWithFormat:@"Resources.plist"];
        NSString* resourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        NSDictionary* resourceDict = [NSDictionary dictionaryWithContentsOfFile:resourcePath];
        
        //Goes through each of the organisms and loads the information
        //about resources and frequencies into _orgsAndResources
        for (int i= 0; i<organisms.count; i++) {
            NSString* currOrganisms = [[NSString alloc] initWithString: organisms[i]];
            NSArray* currResources = [[NSArray alloc] initWithArray:resourceDict[currOrganisms]];
            [_orgsAndResources addObject: currResources];
            
            //Then goes through and adds all resources to _displayResources allow multiples
            //of resources
            for (int j=0; j<currResources.count; j++) {
                NSArray* temp = [[NSArray alloc] initWithArray: currResources[j]];
                [_displayResources addObject: temp[0]];
            }
        }
    }
    return self;
}

@end
