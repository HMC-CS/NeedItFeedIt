//
//  OrganismFactory.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "OrganismFactory.h"


@implementation OrganismFactory{
    NSArray* factoryList;
}

-(id) init{
    if (self= [super init]) {
        factoryList = [[NSArray alloc] init];
        [self loadFactoryList];
        return self;
    }
    return nil;
}

-(void) loadFactoryList {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Organisms" ofType:@"plist"];
    NSDictionary* plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    factoryList = [plistDictionary allValues];
}

-(NSMutableArray*) getOrganisms:(int)num {
    NSMutableArray* copyList = [[NSMutableArray alloc] initWithArray:factoryList copyItems:YES];
    NSMutableArray* returns = [[NSMutableArray alloc] init];
    if ((num-1)<= copyList.count ) {
        for (int i = 0; i<num; i++) {
            int j = arc4random()%copyList.count;
            [returns addObject:[copyList objectAtIndex:j]];
            [copyList removeObjectAtIndex:j];
        }
    }
    return returns;
}

@end
