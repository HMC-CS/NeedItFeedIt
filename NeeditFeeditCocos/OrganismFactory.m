//
//  OrganismFactory.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "OrganismFactory.h"
#import "Level.h"
#import "LevelManager.h"


static const int NUMORGS = 3;

@implementation OrganismFactory{
    NSArray* factoryList;
}

-(id) init{
    if (self= [super init]) {
        //Loads the list of all organismss into factory list
        factoryList = [[NSArray alloc] init];
        
        NSString* fileName = [[NSString alloc] initWithFormat:@"OrganismsLevel2"];
        //NSString* fileName = [[NSString alloc] initWithFormat:@"Levels"];
        NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        NSDictionary* plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        factoryList = [plistDictionary allValues];
        
        //NSArray* temp = [[NSArray alloc] initWithArray: plistDictionary[[LevelManager sharedInstance].curLevel.ecosystem];
        //factoryList = temp[[LevelManager sharedInstance].curLevel.ecosystem];
        
        return self;
    }
    return nil;
}

-(NSMutableArray*) getOrganisms{
    //Choses random organisms and returns num of them
    
    //Duplicate or create variables that will be messed with later
    NSMutableArray* copyList = [[NSMutableArray alloc] initWithArray:factoryList copyItems:YES];
    NSMutableArray* returns = [[NSMutableArray alloc] init];
    
    //Go through copy list num times, pick out a random organisms, add it to returns
    //and remove the organism from copyList
    NSAssert(copyList.count>NUMORGS, @"Not enough organisms in factoryList to fulfill NUMORGS");
    for (int i = 0; i<NUMORGS; i++) {
        int j = arc4random()%copyList.count;
        [returns addObject:[copyList objectAtIndex:j]];
        [copyList removeObjectAtIndex:j];
        }
    return returns;
}

@end
