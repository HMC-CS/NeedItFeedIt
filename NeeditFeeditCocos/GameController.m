//
//  GameController.m
//  NeeditFeeditCocos
//
//  Created by Paige Garratt on 6/8/13.
//  Copyright 2013 Haley Erickson. All rights reserved.
//

#import "GameController.h"
#import "ResourceFactory.h"
#import "Resource.h"
#import "OrganismFactory.h"
#import "Organism.h"
#import "ResourceBar.h"
#import "Level.h"
#import "LevelManager.h"
#import "GameOverLayer.h"
#import "SimpleAudioEngine.h"


@implementation GameController{
    NSMutableArray* organismList;
    NSMutableArray* organisms;
    NSArray* resourceList;
    NSMutableArray* resources;
    NSArray* resourceProbs;
    CGSize winSize;
    int seconds;
    Level* level;
    int decay;
}

static const int POINTS_PER_RESOURCE = 10;

-(id) init{
    if (self = [super init]) {
        
        // ask director for the window size
		winSize = [[CCDirector sharedDirector] winSize];
        
        //Create and add background
        Level* curLevel = [[LevelManager sharedInstance] currentLevel];
        NSString* backPic = [[NSString alloc] initWithFormat:@"%@.png", curLevel.ecosystem];
        CCSprite* background = [CCSprite spriteWithFile:backPic];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-1];
        
        self.touchEnabled = YES;
        
        //Initialize any necessary variables
        organisms = [[NSMutableArray alloc] init];
        resources = [[NSMutableArray alloc] init];
        
        _userLayer =[[UserLayer alloc] init];
        _userLayer.endDelegate = self;
        _userLayer.position = ccp(0, winSize.height*0.93);
        [self addChild:_userLayer];
        
        seconds = 60;
        
        //Add all organisms and resources
        [self loadOrganisms];
        [self addOrganismsAndResources];
        
        //Schedule new resources to be added at specific time interval
        [self schedule:@selector(update:) interval:0.70];
        
        //Start the timer
        [self startStopwatch];
        
        return self;
    }
    return nil;
}

-(void) update:(ccTime)delta{
    [self moveResources];
}

-(void) loadOrganisms{
    //Initiates a new OrganismFactory and gets back num organisms
    OrganismFactory *orgFac = [[OrganismFactory alloc] init];
    organismList = [[NSMutableArray alloc] init];
    organismList = [orgFac getOrganisms];
    decay = orgFac.decay;
}

-(void) addOrganismsAndResources{
    //Initialtes a resource factory
    ResourceFactory* resFac = [[ResourceFactory alloc] initWithOrganisms:organismList];
    resourceList = [[NSMutableArray alloc] initWithArray:resFac.displayResources];
    
    //Get the probability at which the resources should appear
    resourceProbs = [[NSArray alloc] initWithArray:resFac.resourceProbs];
    
    //Creates new organisms with resources and frequencies
    NSArray* orgTemps = [[NSArray alloc] initWithArray:resFac.orgsAndResources];
    float offset = winSize.width / organismList.count;
    for (int i=0; i<organismList.count; i++) {
        Organism *newOrg = [[Organism alloc] initWithString: organismList[i] andResources:orgTemps[i]];
        newOrg.position = ccp(offset*i +newOrg.orgImage.contentSize.width/2 + 90, winSize.height/4);
        [self addChild:newOrg z:0];
        [organisms addObject:newOrg];
        
        //Creates all the resource bars and adds them as a property of the organism
        NSMutableArray* resBars = [[NSMutableArray alloc] init];
        for (int j=0; j<2; j++) {
            ResourceBar *newBar = [[ResourceBar alloc] initGivenResources:orgTemps[i][j] andDecay:decay];
            newBar.position = ccp(newOrg.position.x , winSize.height/8 - (50*j) - 15);
            [self addChild:newBar];
            [resBars addObject:newBar];
        }
        [newOrg setResourceBars:resBars];
    }
}

//This way of moving comes from a Ray Weinderlich Tutorial that we made some adaptions to:
//http://www.raywenderlich.com/25736/how-to-make-a-simple-iphone-game-with-cocos2d-2-x-tutorial

-(void) moveResources{
    
    //Gets a random number in the range of frequencies in resourceProbs 
    NSNumber* countNum = resourceProbs[resourceProbs.count-1];
    int mod = (int) roundf(countNum.floatValue);
    int i = arc4random() % mod;
    
    //Finds the correct range that contains the random number
    int setResource = resourceProbs.count-1;
    for (int j = 0; j<resourceProbs.count; j++) {
        NSNumber *counter = resourceProbs[j];
        if (counter.floatValue > i ) {
            setResource = j;
            break;
        }
    }
    
    //Makes a new resource that corresponds to the number picked
    NSString* name = [[NSString alloc] initWithFormat: resourceList[setResource]];
    Resource *newResource =  [[Resource alloc] initWithString:name];
    newResource.dragDelegate = self;
    [resources insertObject:newResource atIndex:0];

    // Determine where to spawn the resource along the Y axis
    int minY = winSize.height*.65 - newResource.image.contentSize.height/2;
    int maxY = winSize.height*.88 - newResource.image.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the resource slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    newResource.position = ccp(-newResource.contentSize.width/2, actualY);
    newResource.scale = 0.65;
    [self addChild:newResource z:1];
    
    // Determine speed of the resource
    int minDuration = 7.0;
    int maxDuration = 9.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                      position:ccp(winSize.width+ newResource.contentSize.width/2, actualY)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [resources removeObject:newResource];
        [node removeFromParentAndCleanup:YES];
    }];
    [newResource runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Gets the point at which the touch occured and checks if it is within this resource object
    UITouch* thisTouch = [touches anyObject];
    for(Resource* resource in resources){
        CGRect boundingBox = CGRectOffset([resource boundingBox], -resource.boundingBox.size.width/1.75, -resource.boundingBox.size.height/1.75);
        CGPoint pt = [self convertToWorldSpace:[self convertTouchToNodeSpace:thisTouch]];
        if (CGRectContainsPoint(boundingBox, pt)){
            resource.touch = thisTouch;
            [resource stopAllActions];
            [resource setOffsetX:(pt.x - resource.position.x) andOffsetY:(pt.y - resource.position.y)];
            resource.scale= 0.75;
            break;
        }
    }
}

-(void) resource:(Resource*) resource didDragToPoint:(CGPoint)pt{
    //Loops over all organisms and checks if this resource is within its boundingBox
    Organism *targetOrg = nil;
    for (Organism* org in organisms){
        CGRect orgRect = CGRectMake(org.boundingBox.origin.x, org.boundingBox.origin.y - org.boundingBox.size.height/2, org.boundingBox.size.width, 3*org.boundingBox.size.height/2);
        if (CGRectIntersectsRect(orgRect, resource.boundingBox)) {
            targetOrg = org;
            break;
        }
    }
    
    //If a target org is selected, checks if the resource is one of the needed resources
    if (targetOrg!=nil) {
        BOOL fed = NO;
        for (int i=0; i<targetOrg.neededResources.count; i++) {
            NSArray* temp = targetOrg.neededResources[i];
            if ([temp[0] isEqualToString:resource.name]) {
                fed = YES;
                [[SimpleAudioEngine sharedEngine]playEffect:@"munch.wav"];
                [resources removeObject:resource];
                [resource removeFromParentAndCleanup:YES];
                [targetOrg highlight];
                [self.userLayer highlight];
                if ([resource.name isEqualToString: @"human"]) {
                    for (ResourceBar* res in targetOrg.resourceBars){
                        [res updateBar: 10];
                        self.userLayer.points += POINTS_PER_RESOURCE;
                        [_userLayer updatePoints:self.userLayer.points];
                    }
                }else{
                    ResourceBar* current = targetOrg.resourceBars[i];
                    if (![current checkSuccess]){
                        NSNumber *freq = temp[1];
                        [current updateBar: (100.0-freq.floatValue)/8.0];
                        self.userLayer.points += POINTS_PER_RESOURCE;
                        [_userLayer updatePoints:self.userLayer.points];
                    }
                }
                break;
            }
        }
        BOOL allSatisfied = true;
        for (Organism* org in organisms) {
            NSArray* storeBars = [[NSArray alloc] initWithArray: org.resourceBars];
            for (ResourceBar* bar in storeBars) {
                if (![bar checkSuccess]) {
                    allSatisfied = false;
                    break;
                }
            }
        }
        if (allSatisfied) {
            [self stopStopWatch];
            CCScene *loseScene = [GameOverLayer sceneWithWon:YES andScore:self.userLayer.points andBonus: 300];
            [[CCDirector sharedDirector] replaceScene:loseScene];
        }
        if (!fed) {
            [self.userLayer redhighlight];
            self.userLayer.points -= POINTS_PER_RESOURCE/2;
            [_userLayer updatePoints:self.userLayer.points];
            [self animateRemoveResource:resource];
        }
        
    }
    else
        [self animateRemoveResource:resource];
}

-(void) animateRemoveResource: (Resource*) resource{
    float distanceY = MAX(-(3*winSize.height/4 - resource.position.y), 3*winSize.height/4 - resource.position.y);
    float distanceX = MAX(0, winSize.width - resource.position.x);
    CCMoveTo* moveUp = [CCMoveTo actionWithDuration: distanceY/150 position:CGPointMake(resource.position.x, 3*winSize.height/4)];
    CCMoveTo* moveOver = [CCMoveTo actionWithDuration: distanceX/150
                                             position:CGPointMake(winSize.width+resource.contentSize.width/2, 3*winSize.height/4)];
    CCCallBlockN * moveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [resources removeObject:resource];
        [node removeFromParentAndCleanup:YES];
    }];
    [resource runAction:[CCSequence actions:moveUp, moveOver, moveDone, nil]];
}

-(void) startStopwatch{
    [self schedule:@selector(tick) interval:1.0];
}

-(void) tick {
    seconds--;
    [_userLayer updateTimer:seconds];
    if (seconds == 0) {
        [self stopStopWatch];
        CCScene *loseScene = [GameOverLayer sceneWithWon:YES andScore:self.userLayer.points andBonus:0];
        [[CCDirector sharedDirector] replaceScene:loseScene];
    }
}

-(void) stopStopWatch{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(tick) object:nil];
}

-(void) endAllTouches{
    for (Resource* res in resources){
        if (res.touch!=nil) {
            NSSet* set = [[NSSet alloc] initWithObjects:res.touch, nil];
            [res ccTouchesEnded:set withEvent:nil];
        }
    }
}

@end
