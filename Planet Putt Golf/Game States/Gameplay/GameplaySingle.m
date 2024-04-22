//
//  GameplaySingle.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 19. 01. 24.
//

#import "GameplaySingle.h"
#import "Retronator.PuttPuttGolf.h"
#import "GameComponentCollection.h"

#import "GameRenderer.h"
#import "ParticleHalfPlaneCollision.h"
#import "Matrix.h"
#include "GameTime.h"
#import "Rectangle.h"

#import <GameKit/GameKit.h>
#import <GameKit/GKScore.h>

@implementation GameplaySingle


- (id) initSinglePlayerWithGame:(Game *)theGame levelClass:(Class)levelClass
{
    self = [super initWithGame:theGame];
    
    if (self != nil) {
        
        [self startInitWithLevelClass:levelClass];
        
        playerCount=1;
        pturn=0;
                
        Color *pColor = [puttPuttGolf.progress getPlayerColor];
        
        NSArray *colors = @[pColor];
        
        [level initBalls:playerCount withColors:colors];
        
        if(puttPuttGolf.progress.theam==Jupiter)
            level.gravity=[Constants jupiterGravity];
        else if (puttPuttGolf.progress.theam==Moon)
            level.gravity=[Constants moonGravity];
        else
            level.gravity=[Constants earthGravity];
        
        waitTime=-1;
        // Create players
        players[0] = [[HumanPlayer alloc] initWithBall:[level getBall:0] scene:level.Ascene ];
        
        players[pturn].turn=YES;
        
        [self finishInit];
        
    }
    return self;
}


- (void) updateWithGameTime:(GameTime *)gameTime {
    
    Ball *ball=[level getBall:0];
    
    //change camera possition
    renderer.zoom=[puttPuttGolf.scale zoom];
    // check for bad blocks hit
    for(id item in level.badBlocks){
        if([ParticleHalfPlaneCollision detectCollisionBetween:ball and:item]){
            [level resetBall:0];
        }
    }
    
    // End Game Loss
    if(players[0].hitNum == 0 && !ball.Mooving){
        NSLog(@"%d",players[0].hitNum);
        [self saveProgres:score[0]];
        [hud.menue handlePress];
        [self deactivate];
        [self unlocks_sheck];
        
        GameState *newState = nil;
        newState = [[[EndGame alloc] initWithGame:self.game score:score[0]] autorelease];
        [puttPuttGolf popState];
        [puttPuttGolf pushState:newState];
//        [puttPuttGolf popState];
        return;
    }
    
    [hud changePlayerHitsFor:0 to:players[0].hitNum];
    
    //end the round
    if(pturn ==0 && endTurn){
        if(waitTime < 0){
            waitTime=gameTime.totalGameTime+0.6;
        }
        if(waitTime<gameTime.totalGameTime){
            waitTime=-1;
            endTurn=NO;
            [level releaseBlocks];
            [level generateLevel];
        }
    }
    
    // Update all buttons.
    Matrix *inverseView = [Matrix invert:hudRenderer.camera];
    for (id item in hud.scene) {
        Button *button = [item isKindOfClass:[Button class]] ? item : nil;
        if (button) {
            [button updateWithInverseView:inverseView] ;
        }
    }
    
    // menue button
    if (hud.menue.wasReleased) {
        [puttPuttGolf.progress addScore:score[0]];
        [hud.menue handlePress];
        [self deactivate];
        [self unlocks_sheck];
        GameState *newState = nil;
        newState = [[[PauseMenue alloc] initWithGame:self.game] autorelease];
        [puttPuttGolf pushState:newState];
//        [puttPuttGolf popState];
        return;
    }
    
    [players[pturn] updateWithGameTime:gameTime];
    if(players[pturn].turn==NO){
        [self nextTurn];
        players[pturn].turn=YES;
    }
    
    if(!endTurn){
        // hit the star
        if ([ParticleParticleCollision detectCollisionBetween:ball and:level.star]) {
            players[pturn].hitNum+=2;
            [SoundEngine play:SoundEffectTypeWin];
            level.star.position.x=-1000;
            level.star.position.y=-1000;
            NSLog(@"star");
        }
        // hit in the whole score
        if ([ParticleHalfPlaneCollision detectCollisionBetween:ball and:level.hole]) {
            score[pturn] += 1;
            players[pturn].hitNum+=2;
            level.confetiAnimation.isActive=YES;
            [SoundEngine play:SoundEffectTypeWin];
            [hud changePlayerScoreFor:pturn to:score[pturn]];
            endTurn=YES;
        }
    }
    
    // position out of bounds
    if(isnan(ball.position.x ) || isnan(ball.position.y) ){
        [level resetBall:pturn];
    }
    // Put the ball back to the start if it falls off the level.
    if (ball.position.x < 0 ||ball.position.x > 2500 ) {
        [level resetBall:pturn];
    }
    if (ball.position.y > 1500 ) {
        [level resetBall:pturn];
    }
}

-(void)unlocks_sheck{
    if (score[0]>10){
        [puttPuttGolf.progress unlockColour:orange];
    }
    if(score[0]>10 && puttPuttGolf.progress.theam==Jupiter){
        [puttPuttGolf.progress unlockColour:gold];
    }
    if(score[0]>10 && puttPuttGolf.progress.theam==Moon){
        [puttPuttGolf.progress unlockColour:purple];
    }
    if (score[0]>15){
        [puttPuttGolf.progress unlockTheam:Moon];
    }
    if(score[0]>15 && puttPuttGolf.progress.theam==Moon){
        [puttPuttGolf.progress unlockTheam:Jupiter];
    }
}

-(void) saveProgres:(int)score{
    [puttPuttGolf.progress addScore:score];
    NSLog(@"loading %i",score);
    NSInteger scoreValue = score; // Replace with your score value
    NSUInteger contextValue = 1; // Replace with your context value
    GKPlayer *player = [GKLocalPlayer localPlayer]; // The player for whom you're submitting the score
    NSArray<NSString *> *leaderboardIDs = @[@"top_scores_all"];

    [GKLeaderboard submitScore:scoreValue context:contextValue player:player leaderboardIDs:leaderboardIDs completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error submitting score: %@", error.localizedDescription);
        } else {
            NSLog(@"Score submitted successfully");
        }
    }];
}
@end
