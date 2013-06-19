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
        _resourceProbs = [[NSMutableArray alloc] init];
        
        //Finds the Resources file and loads it into a dictionary format
        NSString* fileName = [NSString stringWithFormat:@"Resources.plist"];
        NSString* resourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        NSDictionary* resourceDict = [NSDictionary dictionaryWithContentsOfFile:resourcePath];
        
        //Copies all information about the passsed organisms from Resources.plist into _orgsAndResources
        for (int i= 0; i<organisms.count; i++) {
            NSString* currOrganisms = [[NSString alloc] initWithString: organisms[i]];
            NSArray* currResources = [[NSArray alloc] initWithArray:resourceDict[currOrganisms]];
            [_orgsAndResources addObject: currResources];
            
            //Then goes through and adds all resources with no repeats
            for (int j=0; j<currResources.count; j++) {
                NSArray* temp = [[NSArray alloc] initWithArray: currResources[j]];
                BOOL newResource = FALSE;
                for (int k=0; k<_displayResources.count; k++){
                    if ([temp[0] isEqualToString:_displayResources[k]]){
                        
                        //If the resources repeat the frequencies are added up
                        NSNumber *freq = temp[1];
                        NSNumber *currentFreq = _resourceProbs[k];
                        NSNumber *newFreq = [NSNumber numberWithFloat: (freq.floatValue + currentFreq.floatValue)];
                        [_resourceProbs replaceObjectAtIndex:k withObject: newFreq];
                        newResource = TRUE;
                    }
                }
                //If the resource is not already accounted for it is added here
                if (!newResource){
                    [_displayResources addObject: temp[0]];
                    [_resourceProbs addObject:temp[1]];
                }
            }
            
        }
        
        //Adds the each frequency to the one before it so that the frequencies act as ranges
        //The higher the frequency, the larger the range, and the more likely that resource will be picked
        for (int k=1; k<_resourceProbs.count; k++) {
            NSNumber *back = _resourceProbs[k-1];
            NSNumber *currentFreq = _resourceProbs[k];
            NSNumber *newFreq = [NSNumber numberWithFloat: (back.floatValue + currentFreq.floatValue)];
            [_resourceProbs replaceObjectAtIndex:k withObject:newFreq];
        }
    }
    return self;
}

@end
