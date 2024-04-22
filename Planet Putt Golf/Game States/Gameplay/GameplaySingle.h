//
//  GameplaySingle.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 19. 01. 24.
//

#import "Gameplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameplaySingle : Gameplay

- (id) initSinglePlayerWithGame:(Game*)theGame levelClass:(Class)levelClass;

@end

NS_ASSUME_NONNULL_END
