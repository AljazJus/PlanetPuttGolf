//
//  GameHud.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import "GameComponent.h"
#import "Retronator.PuttPuttGolf.classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameHud : GameComponent{
    SimpleScene *scene;
    PuttPuttGolf *puttPuttGolf;
    Button *menue;
    
    Vector2 *firstTouch,*currentTouch,*offset;
    float indicatorScale;
    int indicatorCount;
    NSMutableArray<Image *> *indicators;
    NSMutableArray<Color *> *playerColor;
    NSMutableArray<Label *> *playerScore;
    NSMutableArray<Label *> *playerHits;

    NSMutableArray<NSNumber *> *playerOpacity;
    
    int lastScore,pCount;
    
}

@property (nonatomic, readonly) id<IScene> scene;
@property (nonatomic, readonly) Button *menue;

- (void) changePlayerScoreFor:(int)playerNum to:(int)value;
-(void) initPlayerScore:(int) playerCount;

- (void) changePlayerHitsFor:(int)playerNum to:(int)value;
-(void) initPlayerHits:(int) playerCount hits:(int)hits;
@end

NS_ASSUME_NONNULL_END
