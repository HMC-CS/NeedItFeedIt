//
//  ResourceBar.h
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@class ResourceBar;
@protocol OrgDeadProtocol <NSObject>

-(void) stopStopwatch;

@end


@interface ResourceBar : CCLayer {
    
}

@property(weak, nonatomic) id <OrgDeadProtocol> deadDelegate;


-(id) initGivenResources:(NSArray*) resource andDecay: (int) decay;

// Fill up the bars depending on percentage
-(void)updateBar:(float)addedPercentage;

-(BOOL) checkSuccess;

@end
