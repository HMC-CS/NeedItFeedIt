//
//  CounterLabel.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/29/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//
// This class was adapted from a Ray Weinderlich tutorial to fit into Cocos2D
// http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3

#import "CounterLabel.h"


@implementation CounterLabel{
    int endValue;
    double delta;
}

+(instancetype)labelWithFont:(NSString*)font position:(CGPoint)pt value:(int)v andString: (NSString*) title{
    CounterLabel* label = [[CounterLabel alloc] init];
    if (label!=nil) {
        label.fontName = font;
        label.fontSize = 50;
        label.position = pt;
        label.value = v;
        label.name = [[NSString alloc] initWithFormat: title];
    }
    return label;
}

-(void) setValue:(int)value{
    _value = value;
    self.string = [NSString stringWithFormat:@"%@ %i", self.name, self.value];
}

-(void) setName:(NSString *)name{
    _name = name;
    self.string = [NSString stringWithFormat:@"%@ %i", self.name, self.value];
}
 
-(void) updateValueBy: (NSNumber*) valueDelta{
    //1 update the property
    self.value += [valueDelta intValue];
    
    //2 check for reaching the end value
    if ([valueDelta intValue] > 0) {
        if (self.value > endValue) {
            self.value = endValue;
            return;
        }
    } else {
        if (self.value < endValue) {
            self.value = endValue;
            return;
        }
    }
    
    //3 if not - do it again
    [self performSelector:@selector(updateValueBy:) withObject:valueDelta afterDelay:delta];
}

-(void)countTo:(int)to withDuration:(float) t afterDelay: (float) delay{
    //1 detect the time for the animation
    delta = t/(abs(to-self.value)+1);
    if (delta < 0.01) delta = 0.01;
    
    //2 set the end value
    endValue = to;
    
    //3 cancel previous scheduled actions
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    //4 detect which way counting goes
    if (to-self.value>0) {
        //count up
        [self performSelector:@selector(updateValueBy:) withObject:@3 afterDelay:delay];
    } else {
        //count down
        [self performSelector:@selector(updateValueBy:) withObject:@-3 afterDelay:delay];
    }
}


@end
