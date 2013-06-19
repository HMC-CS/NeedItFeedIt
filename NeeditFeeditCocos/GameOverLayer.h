//
//  GameOverLayer.h
//  NeeditFeeditCocos
//
//  Created by Haley Erickson on 6/19/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameOverLayer : CCLayerColor {
    
}

+(CCScene *) sceneWithWon:(BOOL)won;
- (id)initWithWon:(BOOL)won;

@end
