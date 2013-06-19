//
//  Organism.h
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Organism : CCLayer {
    
}
@property(strong, nonatomic) CCSprite* orgImage;
@property(strong, nonatomic) NSString* orgName;
@property(strong, nonatomic) NSArray* neededResources;
@property(strong, nonatomic) NSArray* resourceBars;

-(id) initWithString: (NSString*) name andResources: (NSArray*) resources;
-(void) highlight;
-(BOOL) isSatisfied;
-(BOOL) isDead;
-(void) updateHealth;

@end
