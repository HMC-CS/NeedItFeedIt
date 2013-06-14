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
        NSString* fileName = [NSString stringWithFormat:@"Resources.plist"];
        NSString* resourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        NSDictionary* resourceDict = [NSDictionary dictionaryWithContentsOfFile:resourcePath];
        for (int i= 0; i<organisms.count; i++) {
            NSString* currOrganisms = [[NSString alloc] initWithString: organisms[i]];
            _resources = resourceDict[currOrganisms];
        }
    }
    return self;
}

@end
