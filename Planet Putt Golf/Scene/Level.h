//
//  Level.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import "GameComponent.h"

#import "Retronator.PuttPuttGolf.classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Level : GameComponent{
    Vector2 *startPoint;
    PuttPuttGolf *puttPuttGolf;
    Confetti *confetiAnimation;
    Flagg *Pflagg;
    Star *star;
    FlaggBlock *hole;
    
    Class blockType[BlockTypes];
    
    TheamType theam;
    
    int blockNumber;
    
    NSMutableArray *balls;
    NSMutableArray<GroundBlock *> *groundBlocksArray;
    NSMutableArray<GroundBlock *> *badBlocks;

    SimpleScene *Ascene;
    
    float gravity;
    float fWidth,fHeight;
}


@property (nonatomic, strong) NSMutableArray<GroundBlock *> *groundBlocksArray;
@property (nonatomic, strong) NSMutableArray<GroundBlock *> *badBlocks;

@property (nonatomic, strong) NSMutableArray *balls;
@property (nonatomic, readonly) id<IScene> Ascene;
@property (nonatomic, readonly) Flagg *Pflagg;
@property (nonatomic, readonly) Confetti *confetiAnimation;
@property (nonatomic, strong) Star *star;
@property (nonatomic)  TheamType theam;


@property (nonatomic, strong) FlaggBlock *hole;
@property (nonatomic, strong) Vector2 *startPoint;


//@property (nonatomic, readonly) GroundBlock *groundBlock;
@property (nonatomic) float gravity;


- (void) reset;
- (void) resetBall:(int)i;
-(void) releaseBlocks;
-(void) generateLevel;
-(void) firstLevel;
- (void)initBalls:(int)count withColors:(NSArray *)colors ;

- (Ball *)getBall:(int)index;

@end

NS_ASSUME_NONNULL_END
