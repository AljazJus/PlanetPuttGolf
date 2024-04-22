//
//  Gameplay.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//

#import "Gameplay.h"
#import "Retronator.PuttPuttGolf.h"
#import "GameComponentCollection.h"

#import "GameRenderer.h"
#import "ParticleHalfPlaneCollision.h"
@interface Gameplay ()

- (void) initWithGame:(Game *)theGame LevelClass:(Class)levelClass;

@end

@implementation Gameplay

@synthesize playerCount;

- (id) initMultiplayerWithGame:(Game *)theGame levelClass:(Class)levelClass
{
    self = [super initWithGame:theGame];
    
    
    if (self != nil) {
        [self initWithGame:theGame LevelClass:levelClass];
        self.updateOrder = 10;
        playerCount=2;
        pturn=0;
        NSArray *colors = @[[Color white]];
        [level initBalls:playerCount withColors:colors];
        
        // Create players
        players[0] = [[HumanPlayer alloc] initWithBall:[level getBall:0]scene:level.Ascene  game:self.game];
        players[1] = [[HumanPlayer alloc] initWithBall:[level getBall:1] scene:level.Ascene  game:self.game];
        players[pturn].turn=YES;
    }
    return self;
}

- (id) initSinglePlayerWithGame:(Game *)theGame levelClass:(Class)levelClass
{
    self = [super initWithGame:theGame];
    
    if (self != nil) {
        
        [self initWithGame:theGame LevelClass:levelClass];
        playerCount=1;
        pturn=0;
        NSArray *colors = @[[Color white]];
        [level initBalls:playerCount withColors:colors];

        // Create players
        players[0] = [[HumanPlayer alloc] initWithBall:[level getBall:0] scene:level.Ascene ];
        players[pturn].turn=YES;
    }
    return self;
}

- (id) initAIPlayerWithGame:(Game *)theGame levelClass:(Class)levelClass aiClass:(Class)aiClass
{
    self = [super initWithGame:theGame];
    
    if (self != nil) {
        
        [self initWithGame:theGame LevelClass:levelClass];
        playerCount=2;
        pturn=0;
        NSArray *colors = @[[Color white], [Color red]];
        [level initBalls:playerCount withColors:colors];

        // Create players
        players[0] = [[HumanPlayer alloc] initWithBall:[level getBall:0] scene:level.Ascene ];
        players[1] = [[AIPlayer alloc] initWithBall:[level getBall:1]  scene:level.Ascene ];
        players[pturn].turn=YES;

    }
    return self;
}

- (void) initWithGame:(Game *)theGame LevelClass:(Class)levelClass
{
    // Allocate and initialize a new level and add it to components.
    level = [[levelClass alloc] initWithGame:self.game ];
    
    
    [self.game.components addComponent:level];
    
    // Create a new renderer for the new scene and add it to components.
    renderer = [[GameRenderer alloc] initWithGame:self.game level:level];
    [self.game.components addComponent:renderer];
    
    physics = [[PhysicsEngine alloc] initWithGame:self.game level:level];
    physics.updateOrder = 20;
    [self.game.components addComponent:physics];
    
}

-(void) nextTurn{
    pturn++;
    if (pturn == playerCount)
        pturn=0;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    
    
    [players[pturn] updateWithGameTime:gameTime];
    
    if(players[pturn].turn==NO){
        [self nextTurn];
        players[pturn].turn=YES;
    }
    
    for(int i=0;i<playerCount;i++)
    {
        Ball *ball=[level getBall:i];
        if ([ParticleHalfPlaneCollision detectCollisionBetween:ball and:level.hole]) {
                score[0] += 1;
                NSLog(@"Score: %d", score[0]);
                [level releaseBlocks];
                //todo
                [level generateLevel];
            }
        // Put the ball back to the start if it falls off the level.
        if (ball.position.x < 0 ||ball.position.x > 2500 ) {
            [level reset];
        }
    }
}

- (void) dealloc
{
    [self.game.components removeComponent:level];
    [self.game.components removeComponent:renderer];
    [self.game.components removeComponent:physics];
    [level release];
    [renderer release];
    [physics release];
    
    for (int i=0;i<playerCount;i++){
        [players[i] release];
    }
    
    [super dealloc];
}



@end
