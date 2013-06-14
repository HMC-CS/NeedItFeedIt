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

-(id) initWithString:(NSString*) name;
-(BOOL) isSatisfied;
-(BOOL) isDead;
-(void) updateHeath;

@end
