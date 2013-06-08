//
//  GameController.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "GameController.h"
#import "Resource.h"

@implementation GameController{
    NSMutableArray* organisms;
    NSMutableArray* displayedOrganisms;
    NSMutableArray* resources;
    CGSize winSize;
    NSTimer* timer;
}

-(id) init{
    if (self = [super init]) {
        // ask director for the window size
		winSize = [[CCDirector sharedDirector] winSize];
        
        //Create and add background
        CCSprite* background = [CCSprite spriteWithFile:@"background1.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-1];
        
        organisms = [[NSMutableArray alloc] initWithObjects:@"grass", @"moss", @"flower", nil];
        
        [self addOrganisms];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                          target:self
                                                        selector:@selector(moveResources)
                                                        userInfo:nil
                                                         repeats:YES];
        
        return self;
    }
    return nil;
}

-(void) update:(ccTime)delta{
    [self moveResources];
}

-(void) addOrganisms{
    float offset = winSize.width / organisms.count;
    for (int i=0; i<organisms.count; i++) {
        NSString* currentOrg = [[NSString alloc] initWithFormat:@"%@.png",organisms[i]];
        CCSprite* temp = [CCSprite spriteWithFile:currentOrg];
        temp.position = ccp(offset*i +temp.contentSize.width/2 , winSize.height/6);
        [self addChild:temp z:0];
        [displayedOrganisms addObject:temp];
    }
}

-(void) addResources{
    NSArray* resourceList = [[NSArray alloc] initWithObjects:@"water", @"sun", @"air", nil];
    for (int i=0; i<resourceList.count; i++) {
        NSString* currentOrg = [[NSString alloc] initWithFormat:@"%@.png",resourceList[i]];
        CCSprite* temp = [CCSprite spriteWithFile:currentOrg];
        [resources addObject:temp];
    }
}

-(void) moveResources{
    NSArray* resourceList = [[NSArray alloc] initWithObjects:@"water", @"sun", @"air", nil];
    
    int i = arc4random() % 3;
    NSString* currentOrg = [[NSString alloc] initWithFormat:@"%@.png",resourceList[i]];
    
    CCSprite* temp = [CCSprite spriteWithFile:currentOrg];
    
    // Determine where to spawn the monster along the Y axis
    int minY = 3*winSize.height/4 - temp.contentSize.height / 2;
    int maxY = winSize.height - temp.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    temp.position = ccp(-temp.contentSize.width/2, actualY);
    [self addChild:temp];
    
    // Determine speed of the monster
    int minDuration = 6.0;
    int maxDuration = 10.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(winSize.width+ temp.contentSize.width/2, actualY)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
    }];
    [temp runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(BOOL) allSatisfied{
    return NO;
}

-(BOOL) checkIntersectResource: (Resource*) resource{
    return NO;
}

@end
