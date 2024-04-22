//
//  Gameplay.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//

#import <Foundation/Foundation.h>
#import "GameComponent.h"


#import "Retronator.PuttPuttGolf.classes.h"
#import "GameState.h"

NS_ASSUME_NONNULL_BEGIN

@interface Gameplay : GameState{
    Level *level;
    int playerCount;
    int pturn;    //tells whos turn is it 
    Player *players[2];
    int score[2];
    GameRenderer *renderer;
    PhysicsEngine *physics;
    
}

- (id) initMultiplayerWithGame:(Game*)theGame levelClass:(Class)levelClass;
- (id) initSinglePlayerWithGame:(Game*)theGame levelClass:(Class)levelClass;
- (id) initAIPlayerWithGame:(Game*)theGame levelClass:(Class)levelClass aiClass:(Class)aiClass;

@property (nonatomic) int playerCount;



@end

NS_ASSUME_NONNULL_END
