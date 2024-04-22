//
//  PuttPuttGolf.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 8. 11. 23.
//

#import "PuttPuttGolf.h"
#import "Retronator.PuttPuttGolf.h"
#import "Color.h"
#import "GameComponentCollection.h"
#import "GraphicsDeviceManager.h"
#import <GameKit/GameKit.h>

@implementation PuttPuttGolf

@synthesize progress,scale;

- (id) init {
    if (self = [super init]) {
        graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
        
        [self.components addComponent:[[[TouchPanelHelper alloc] initWithGame:self] autorelease]];
        
        stateStack = [[NSMutableArray alloc] init];
        
        [SoundEngine initializeWithGame:self];
        
        progress = [[GameProgress loadProgress] retain];
        
        [self authenticateLocalPlayer];
        
    }
    
    return self;
}


-(void)initialize{
    // Add all level classes.
    scale=[[ScaleConstants alloc] init:self.graphicsDevice.viewport.width height:self.graphicsDevice.viewport.height];
    levelClasses[LevelStart] = [StartLevel class];

    opponentClasses[badAi] = [AIPlayer class];

    
    //start in main menue
    MainMenue *mainMenu = [[[MainMenue alloc] initWithGame:self] autorelease];
    [self pushState:mainMenu];
    
    // Initialize all components.
    [super initialize];
    
    
}

- (void) pushState:(GameState *)gameState {
    
    GameState *currentActiveState = [stateStack lastObject];
    
    [currentActiveState deactivate];
    
    [self.components removeComponent:currentActiveState];
    
    [stateStack addObject:gameState];
    [self.components addComponent:gameState];
    
    [gameState activate];
}



- (void) popState {
    
    GameState *currentActiveState = [stateStack lastObject];
    
    [stateStack removeLastObject];
    [currentActiveState deactivate];
    
    [self.components removeComponent:currentActiveState];
    currentActiveState = [stateStack lastObject];
    [self.components addComponent:currentActiveState];
    [currentActiveState activate];
}

- (void) doublePopState {
    if ([stateStack count] < 2) {
        NSLog(@"Error: Trying to pop two states from stateStack, but it has fewer than two elements.");
        return;
    }
    
    GameState *currentActiveState = [stateStack lastObject];
    [stateStack removeLastObject];
    [stateStack removeLastObject];
    [currentActiveState deactivate];
    
    [self.components removeComponent:currentActiveState];
    currentActiveState = [stateStack lastObject];
    [self.components addComponent:currentActiveState];
    [currentActiveState activate];
    
}

-(void)authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];

    //Block is called each time GameKit automatically authenticates
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error)
    {
//        [self setLastError:error];
        if (viewController)
        {
//            self.authenticationViewController = viewController;
            [self disableGameCenter];
        }
        else if (localPlayer.isAuthenticated)
        {
            [self authenticatedPlayer];
        }
        else
        {
            [self disableGameCenter];
        }
    };
}

-(void)authenticatedPlayer
{
     GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
//    [[NSNotificationCenter defaultCenter]postNotificationName:AUTHENTICATED_NOTIFICATION object:nil];
    NSLog(@"Local player:%@ authenticated into game center",localPlayer.gamePlayerID);
}

-(void)disableGameCenter
{
    //A notification so that every observer responds appropriately to disable game center features
//    [[NSNotificationCenter defaultCenter]postNotificationName:UNAUTHENTICATED_NOTIFICATION object:nil];
    NSLog(@"Disabled game center");
}



- (Class) getLevelClass:(LevelType)type {
    return levelClasses[type];
}

- (Class) getOpponentClass:(OpponentType)type {
    return opponentClasses[type];
}


- (void) dealloc
{
    [graphics release];
    [super dealloc];
}
@end
