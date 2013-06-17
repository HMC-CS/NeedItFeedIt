//
//  ResourceBar.h
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ResourceBar : CCLayer {
    
}

-(id) init;
-(void) increaseSelf;
-(void)updatePercentageToValue:(int)newValue;

@end
