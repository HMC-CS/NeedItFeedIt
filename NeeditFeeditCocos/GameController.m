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

@implementation GameController{
    NSMutableArray* organismList;
    NSMutableArray* organisms;
    NSArray* resourceList;
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
        
        self.touchEnabled = YES;
        
        //Initialize any necessary variables
        organisms = [[NSMutableArray alloc] init];
        resources = [[NSMutableArray alloc] init];
        
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
    OrganismFactory *orgFac = [[OrganismFactory alloc]initGivenLevel:1];
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
        NSArray* temp = [[NSArray alloc] initWithArray: orgTemps[i]];
        Organism *newOrg = [[Organism alloc] initWithString: organismList[i]
                            andResource1:temp[0] andResource2:temp[1] andResource3:temp[2]];
        newOrg.orgImage.position = ccp(offset*i +newOrg.orgImage.contentSize.width/2 , winSize.height/6);
        [self addChild:newOrg.orgImage z:0];
        [organisms addObject:newOrg];
    }
}

-(void) moveResources{
    
    //Get one of the objects in resourceList
    int i = arc4random() % 3;
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
    newResource.position = ccp(-newResource.image.contentSize.width/2, actualY);
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
        if (CGRectContainsPoint(org.orgImage.boundingBox, pt)) {
            targetOrg = org;
            break;
        }
    }
    
    if (targetOrg!=nil) {
        //Here we will update the resource bar and possibly score
    }
    
    [resources removeObject:resource];
    [resource removeFromParentAndCleanup:YES];
}
            
-(BOOL) allSatisfied{
    return NO;
}

-(BOOL) checkIntersectResource: (Resource*) resource{
    return NO;
}

@end
