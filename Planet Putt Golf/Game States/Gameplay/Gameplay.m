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
#import "Matrix.h"

@implementation Gameplay

@synthesize playerCount;


- (void) startInitWithLevelClass:(Class)levelClass
{
    // Allocate and initialize a new level and add it to components.
    level = [[levelClass alloc] initWithGame:self.game];
    
}

- (void) finishInit
{
    endTurn=NO;
    // Create a new renderer for the new scene and add it to components.
    
    TheamType theam=puttPuttGolf.progress.theam;
    renderer = [[GameRenderer alloc] initWithGame:self.game level:level theam:theam];
    renderer.drawOrder=1;
    physics = [[PhysicsEngine alloc] initWithGame:self.game level:level];
    physics.updateOrder = 20;
    hud = [[GameHud alloc] initWithGame:self.game];
    hudRenderer = [[GuiRenderer alloc] initWithGame:self.game scene:hud.scene];
    level.theam=theam;
    [level reset];
    hudRenderer.drawOrder = 2;
    
    [hud initPlayerScore:playerCount];
    
    if(playerCount==1){
        [hud initPlayerHits:playerCount hits:players[0].hitNum];
    }

}

-(void) nextTurn
{
    pturn++;
    if (pturn == playerCount)
        pturn=0;
}

- (void) activate {
    [self.game.components addComponent:level];
    [self.game.components addComponent:hud];
    [self.game.components addComponent:hudRenderer];
    [self.game.components addComponent:renderer];
    [self.game.components addComponent:physics];
    for (int i = 0; i < playerCount; i++) {
        [self.game.components addComponent:players[i]];
    }
}

- (void) deactivate {
    [self.game.components removeComponent:hud];
    [self.game.components removeComponent:hudRenderer];
    [self.game.components removeComponent:level];
    [self.game.components removeComponent:renderer];
    [self.game.components removeComponent:physics];
    for (int i = 0; i < playerCount; i++) {
        [self.game.components removeComponent:players[i]];
    }
}

- (void)endGame{
    endTurn=YES;
}

- (void) dealloc
{
    [hud release];
    [hudRenderer release];
    [level release];
    [renderer release];
    [physics release];
    for (int i=0;i<playerCount;i++){
        [players[i] release];
    }
    [super dealloc];
}



@end
