//
//  GameOverLayer.m
//  NeeditFeeditCocos
//
//  Created by Haley Erickson on 6/19/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "GameOverLayer.h"
#import "MenuLayer.h"
#import "LevelManager.h"

@implementation GameOverLayer

+(CCScene *) sceneWithWon:(BOOL)won {
    CCScene *scene = [CCScene node];
    GameOverLayer *layer = [[GameOverLayer alloc] initWithWon:won];
    [scene addChild: layer];
    return scene;
}

- (id)initWithWon:(BOOL)won {
    if (self = [super init]) {
        
        NSString * message;
        if (won) {
            message = @"You Won!";
        }
        else {
            message = @"You Lost!";
        }
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite* background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background z:-1];
        
        CCLabelTTF * label = [CCLabelTTF labelWithString:message fontName:@"Arial" fontSize:32];
        label.color = ccc3(0,0,0);
        label.position = ccp(size.width/2, size.height/2);
        [self addChild:label];
        
        [self runAction:
         [CCSequence actions:
          [CCDelayTime actionWithDuration:3],
          [CCCallBlockN actionWithBlock:^(CCNode *node) {
             [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
         }],
          nil]];
    }
    return self;
}

@end
