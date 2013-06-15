//
//  ResourceFactory.h
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ResourceFactory : CCNode {
    
}
@property(strong, nonatomic) NSMutableArray* displayResources;
@property(strong, nonatomic) NSMutableArray* orgsAndResources;

-(id) initWithOrganisms: (NSMutableArray*) organisms;

@end
