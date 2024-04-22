//
//  GameplayMulti.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 19. 01. 24.
//


#import <Foundation/Foundation.h>
#import "GameComponent.h"
#import "Retronator.PuttPuttGolf.classes.h"
#import "Gameplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameplayMulti : Gameplay

- (id) initMultiplayerWithGame:(Game *)theGame levelClass:(Class)levelClass;

- (id) initAIPlayerWithGame:(Game *)theGame levelClass:(Class)levelClass aiClass:(Class)aiClass;

@end

NS_ASSUME_NONNULL_END
