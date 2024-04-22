//
//  GameplayMulti.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 19. 01. 24.
//

#import "GameplayMulti.h"
#import "Retronator.PuttPuttGolf.h"
#import "GameComponentCollection.h"

#import "GameRenderer.h"
#import "ParticleHalfPlaneCollision.h"
#import "Matrix.h"
#include "GameTime.h"

@implementation GameplayMulti

- (id) initMultiplayerWithGame:(Game *)theGame levelClass:(Class)levelClass
{
    self = [super initWithGame:theGame];
    
    if (self != nil) {
        
        [self startInitWithLevelClass:levelClass];
        self.updateOrder = 10;
        playerCount=2;
        pturn=0;
        NSArray *colors = @[[Color blue], [Color red]];
        [level initBalls:playerCount withColors:colors];
        
        if(puttPuttGolf.progress.theam==Jupiter)
            level.gravity=[Constants jupiterGravity];
        else if (puttPuttGolf.progress.theam==Moon)
            level.gravity=[Constants moonGravity];
        else
            level.gravity=[Constants earthGravity];
        
        // Create players
        players[0] = [[HumanPlayer alloc] initWithBall:[level getBall:0]scene:level.Ascene  game:self.game];
        players[1] = [[HumanPlayer alloc] initWithBall:[level getBall:1] scene:level.Ascene  game:self.game];
        players[pturn].turn=YES;
        
        
        [self finishInit];
    }
    return self;
}


- (id) initAIPlayerWithGame:(Game *)theGame levelClass:(Class)levelClass aiClass:(Class)aiClass
{
    self = [super initWithGame:theGame];
    
    if (self != nil) {
        
        [self startInitWithLevelClass:levelClass];
        playerCount=2;
        pturn=0;
        NSArray *colors = @[[Color white], [Color red]];
        [level initBalls:playerCount withColors:colors];

        // Create players
        players[0] = [[HumanPlayer alloc] initWithBall:[level getBall:0] scene:level.Ascene ];
        players[1] = [[AIPlayer alloc] initWithBall:[level getBall:1]  scene:level.Ascene ];
        players[pturn].turn=YES;
        
        [self finishInit];
    }
    return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    renderer.zoom=[puttPuttGolf.scale zoom];

    
    //! change
    level.star.position.x=-1000;
    
    if(players[pturn].turn==NO){
        [self nextTurn];
        players[pturn].turn=YES;
    }
    
    // Update all buttons.
    Matrix *inverseView = [Matrix invert:hudRenderer.camera];

    for (id item in hud.scene) {
        Button *button = [item isKindOfClass:[Button class]] ? item : nil;
        if (button) {
            [button updateWithInverseView:inverseView] ;
        }
    }
    
    if (hud.menue.wasReleased) {
        [hud.menue handlePress];
        [self deactivate];
        GameState *newState = nil;
        newState = [[[PauseMenue alloc] initWithGame:self.game] autorelease];
        [puttPuttGolf pushState:newState];
//        [puttPuttGolf popState];
        return;
    }
    
    
    [players[pturn] updateWithGameTime:gameTime];
    
    Ball *ball=[level getBall:pturn];
    
    if(pturn ==playerCount-1 && endTurn)
    {
        if(ball.Mooving)
            return;
        if(waitTime < 0)
        {
            waitTime=gameTime.totalGameTime+0.6;
        }
        if(waitTime<gameTime.totalGameTime){
            waitTime=-1;
            endTurn=NO;
            pturn=0;
            [level releaseBlocks];
            [level generateLevel];
        }
        return;
    }
    
    if(ball.hasScored)
        return;
    
    if ([ParticleHalfPlaneCollision detectCollisionBetween:ball and:level.hole]) {
        score[pturn] += 1;
        level.confetiAnimation.isActive=YES;
        [SoundEngine play:SoundEffectTypeWin];
        [hud changePlayerScoreFor:pturn to:score[pturn]];
        endTurn=YES;
        ball.hasScored=YES;
    }
    
    if(isnan(ball.position.x ) || isnan(ball.position.y) )
    {
        [level resetBall:pturn];
    }
    // Put the ball back to the start if it falls off the level.
    if (ball.position.x < 0 ||ball.position.x > 2500 ) {
        [level resetBall:pturn];
    }
    if (ball.position.y > 1500 ) {
        [level resetBall:pturn];
    }
    
    if(score[pturn]==5){
        [puttPuttGolf.progress addScore:score[0]];
        [hud.menue handlePress];
        [self deactivate];
        GameState *newState = nil;
        newState = [[[EndGameMultiplayer alloc] initWithGame:self.game score:pturn] autorelease];
        [puttPuttGolf popState];
        [puttPuttGolf pushState:newState];
//        [puttPuttGolf popState];
        return;
    }
}

@end
