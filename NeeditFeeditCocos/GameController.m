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

@implementation GameController{
    NSMutableArray* organismList;
    NSMutableArray* organisms;
    NSArray* resourceList;
    NSMutableArray* resources;
    NSMutableArray* resourceBars;
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
        
        self.touchEnabled = YES;
        
        //Initialize any necessary variables
        organisms = [[NSMutableArray alloc] init];
        resources = [[NSMutableArray alloc] init];
        resourceBars = [[NSMutableArray alloc] init];
        
        //Add all organisms and resources
        [self loadOrganisms: 3];
        [self addOrganismsAndResources];
        
        //Schedule new resources to be added every 2 sec
        [self schedule:@selector(update:) interval:2.0];
        return self;
    }
    return nil;
}

-(void) update:(ccTime)delta{
    [self moveResources];
}

-(void) loadOrganisms: (int) num{
    //Initiates a new OrganismFactory and gets back num organisms
    OrganismFactory *orgFac = [[OrganismFactory alloc]initGivenLevel:2];
    organismList = [[NSMutableArray alloc] init];
    organismList = [orgFac getOrganisms:num];
}

-(void) addOrganismsAndResources{
    //Initialtes a resource factory
    ResourceFactory* resFac = [[ResourceFactory alloc] initWithOrganisms:organismList];
    resourceList = [[NSMutableArray alloc] init];
    
    //resourceList is assigned to be all resources that need to be displayed
    resourceList = resFac.displayResources;
    
    //Creates new organisms with resources and frequencies
    NSArray* orgTemps = [[NSArray alloc] initWithArray:resFac.orgsAndResources];
    float offset = winSize.width / organismList.count;
    for (int i=0; i<organismList.count; i++) {
        Organism *newOrg = [[Organism alloc] initWithString: organismList[i] andResources:orgTemps[i]];
        newOrg.position = ccp(offset*i +newOrg.orgImage.contentSize.width/2 +50, winSize.height/4);
        [self addChild:newOrg z:0];
        [organisms addObject:newOrg];
        ResourceBar *newBar = [[ResourceBar alloc] init];
        newBar.position = ccp(newOrg.position.x , winSize.height/8);
        [self addChild:newBar];
        [resourceBars addObject:newBar];
    }
}

//This way of moving comes from a Ray Weinderlich Tutorial that we made some adaptions to:
//http://www.raywenderlich.com/25736/how-to-make-a-simple-iphone-game-with-cocos2d-2-x-tutorial

-(void) moveResources{
    
    //Get one of the objects in resourceList
    int i = arc4random() % resourceList.count;
    NSString* name = [[NSString alloc] initWithFormat: resourceList[i]];
    Resource *newResource =  [[Resource alloc] initWithString:name];
    newResource.dragDelegate = self;
    [resources addObject:newResource];


    // Determine where to spawn the resource along the Y axis
    int minY = 3*winSize.height/4 - newResource.image.contentSize.height / 2;
    int maxY = winSize.height - newResource.image.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the resource slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    newResource.position = ccp(-newResource.contentSize.width/2, actualY);
    [self addChild:newResource z:1];
    
    // Determine speed of the resource
    int minDuration = 7.0;
    int maxDuration = 10.0;
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

-(void) resource:(Resource*) resource didDragToPoint:(CGPoint)pt{
    //Loops over all organisms and checks if this resource is within its boundingBox
    Organism *targetOrg = nil;
    for (Organism* org in organisms){
        if (CGRectIntersectsRect(org.boundingBox, resource.boundingBox)) {
            targetOrg = org;
            break;
        }
    }
    
    //If a target org is selected, checks if the resource is one of the needed resources
    if (targetOrg!=nil) {
        for (int i=0; i<targetOrg.neededResources.count; i++) {
            NSArray* temp = targetOrg.neededResources[i];
            if ([temp[0] isEqualToString:resource.name]) {
                NSLog(@"%@ was fed", targetOrg.orgName);
                [resources removeObject:resource];
                [resource removeFromParentAndCleanup:YES];
                [targetOrg highlight];
                break;
            }
        }
        [self animateRemoveResource:resource];
    }
    else
        [self animateRemoveResource:resource];
}

-(void) animateRemoveResource: (Resource*) resource{
    float distanceY = MAX(-(3*winSize.height/4 - resource.position.y), 3*winSize.height/4 - resource.position.y);
    float distanceX = MAX(0, winSize.width - resource.position.x);
    NSLog(@"distanceY: %f distanceX: %f", distanceY, distanceX);
    CCMoveTo* moveUp = [CCMoveTo actionWithDuration: distanceY/150 position:CGPointMake(resource.position.x, 3*winSize.height/4)];
    CCMoveTo* moveOver = [CCMoveTo actionWithDuration: distanceX/150
                                             position:CGPointMake(winSize.width+resource.contentSize.width/2, 3*winSize.height/4)];
    CCCallBlockN * moveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [resources removeObject:resource];
        [node removeFromParentAndCleanup:YES];
    }];
    [resource runAction:[CCSequence actions:moveUp, moveOver, moveDone, nil]];
}
            
-(BOOL) allSatisfied{
    return NO;
}

-(BOOL) checkIntersectResource: (Resource*) resource{
    return NO;
}

@end
