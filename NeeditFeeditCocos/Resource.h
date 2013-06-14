//
//  Resource.h
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Resource;
@protocol ResourceDragProtocol <NSObject>

-(void) resource:(Resource*) resource didDragToPoint:(CGPoint) pt;

@end



@interface Resource : CCLayer

@property(strong, nonatomic) CCSprite* image;
@property(strong, nonatomic) NSString* name;
@property(nonatomic) int frequency;
@property(weak, nonatomic) id <ResourceDragProtocol> dragDelegate;

-(id) initWithString: (NSString*) name andFrequency: (int) freq;

@end
