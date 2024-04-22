//
//  PuttPuttGolf.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 8. 11. 23.
//

#import "Game.h"
#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.Graphics.h"
#import <GameKit/GameKit.h>
#import "Retronator.PuttPuttGolf.classes.h"



@interface PuttPuttGolf : Game{
    // graphics
    GraphicsDeviceManager *graphics;
    
    // Levels
    Class levelClasses[LevelTypes];
    
    // Opponents
    Class opponentClasses[OpponentTypes];
    
    ScaleConstants *scale;
    
    // Game state
    NSMutableArray *stateStack;
    
    GameProgress *progress;
}

@property (nonatomic, readonly) GameProgress *progress;
@property (nonatomic, readonly) ScaleConstants *scale;



- (void) pushState:(GameState*)gameState;
- (void) popState;
- (void) doublePopState;

- (Class) getLevelClass:(LevelType)type;
- (Class) getOpponentClass:(OpponentType)type;

@end
