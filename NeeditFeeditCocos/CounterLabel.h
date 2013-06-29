//
//  CounterLabel.h
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/29/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CounterLabel : CCLabelTTF {
    
}
@property (assign, nonatomic) int value;
@property (strong, nonatomic) NSString* name;

+(instancetype)labelWithFont:(NSString*)font position:(CGPoint)pt value:(int)v andString: (NSString*) string;
-(void)countTo:(int)to withDuration:(float)t afterDelay: (float) delay;

@end
