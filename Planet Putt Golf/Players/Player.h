//
//  Player.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//

#import "GameComponent.h"
#import "Retronator.PuttPuttGolf.classes.h"


NS_ASSUME_NONNULL_BEGIN

@interface Player : GameComponent{
    Ball *ball;
    id<IScene> scene;
    int hitNum;
}

- (id) initWithBall:(Ball*)theBall scene:(id<IScene>)theScene;

- (void) updateWithGameTime:(GameTime*)gameTime;

@property (nonatomic) BOOL turn;
@property (nonatomic) int hitNum;

@end

NS_ASSUME_NONNULL_END
