//
//  Resource.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "Resource.h"


@implementation Resource{
    int xOffset, yOffset;
}

-(id) initWithString: (NSString*) name{
    if (self = [super init]) {
        //Converts the name to picture format and loads the sprite
        NSString* currentOrg = [[NSString alloc] initWithFormat:@"%@.png",name];
        _image = [CCSprite spriteWithFile:currentOrg];
        [self addChild:_image];
        
        //Sets necessary variables
        _name = name;
        _touch = [[UITouch alloc]init];
        _touch = nil;
        self.touchEnabled = YES;
        
        self.contentSize = CGSizeMake(_image.contentSize.width, _image.contentSize.height);
        
        return self;
    }
    return nil;
}
-(void) setOffsetX:(int) xoffSet andOffsetY: (int) yoffSet{
    xOffset = xoffSet;
    yOffset = yoffSet;
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Makes sure that the same touch is being tracked throughout the drag
    if (_touch!=nil){
        CGPoint pt = [self convertToWorldSpace:[self convertTouchToNodeSpace:_touch]];
        self.position = CGPointMake(pt.x - xOffset, pt.y - yOffset);
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //At end it checks ccTouchesMoved one more time to make sure resource is in the right location
    if (_touch!=nil){
        [self ccTouchesMoved:touches withEvent:event];
        
        //Tells the GameController that a resource has been dropped
        if (self.dragDelegate)
            [self.dragDelegate resource:self didDragToPoint:[self convertToWorldSpace: [self convertTouchToNodeSpace: _touch]]];
    }
    
    //Resets touches to nil so that a new touch is treated correctly
    _touch = nil;
}


@end
