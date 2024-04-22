//
//  GameState.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 6. 12. 23.
//

#import "GameComponent.h"
#import "Retronator.PuttPuttGolf.classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameState : GameComponent{
    PuttPuttGolf *puttPuttGolf;
}

- (void) activate;
- (void) deactivate;
@end

NS_ASSUME_NONNULL_END
