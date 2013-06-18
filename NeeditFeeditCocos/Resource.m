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
    UITouch* touch;
}

-(id) initWithString: (NSString*) name{
    if (self = [super init]) {
        //Converts the name to picture format and loads the sprite
        NSString* currentOrg = [[NSString alloc] initWithFormat:@"%@.png",name];
        _image = [CCSprite spriteWithFile:currentOrg];
        [self addChild:_image];
        
        //Sets necessary variables
        _name = name;
        touch = [[UITouch alloc]init];
        touch = nil;
        self.touchEnabled = YES;
        
        self.contentSize = CGSizeMake(_image.contentSize.width, _image.contentSize.height);
        
        return self;
    }
    return nil;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Gets the point at which the touch occured and checks if it is within this resource object
    UITouch* thisTouch = [touches anyObject];
    CGRect boundingBox = CGRectOffset([self boundingBox], -self.contentSize.width/2, -self.contentSize.height/2);
    CGPoint pt = [self convertToWorldSpace:[self convertTouchToNodeSpace:thisTouch]];
    if (CGRectContainsPoint(boundingBox, pt)){
        touch = thisTouch;
        [self stopAllActions];
        
        //Setting an offset makes the dragging look more natural
        xOffset = pt.x - self.position.x;
        yOffset = pt.y - self.position.y;
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Makes sure that the same touch is being tracked throughout the drag
    if (touch!=nil){
        CGPoint pt = [self convertToWorldSpace:[self convertTouchToNodeSpace:touch]];
        self.position = CGPointMake(pt.x - xOffset, pt.y - yOffset);
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //At end it checks ccTouchesMoved one more time to make sure resource is in the right location
    if (touch!=nil){
        [self ccTouchesMoved:touches withEvent:event];
        
        //Tells the GameController that a resource has been dropped
        if (self.dragDelegate)
            [self.dragDelegate resource:self didDragToPoint:[self convertToWorldSpace: [self convertTouchToNodeSpace: touch]]];
    }
    
    //Resets touches to nil so that a new touch is treated correctly
    touch = nil;
}


@end
