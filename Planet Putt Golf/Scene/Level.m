//
//  Level.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import "Level.h"
#import "Retronator.PuttPuttGolf.h"
#import "Rectangle.h"
@implementation Level


@synthesize Pflagg, gravity, Ascene,hole,balls,startPoint,confetiAnimation,star,groundBlocksArray,badBlocks,theam;

- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        Ascene = [[SimpleScene alloc] init];
        puttPuttGolf = (PuttPuttGolf*)self.game;
        balls = [[NSMutableArray alloc] init];
        
        Pflagg= [[Flagg alloc] init];
        star=[[Star alloc]init];
        star.color=[Color white];
        [Ascene addItem:star];
        // Initialize the groundBlocksArray
        self.groundBlocksArray = [[NSMutableArray alloc] init];
        self.badBlocks = [[NSMutableArray alloc] init];

//        dHeight=theGame.graphicsDevice.viewport.height;
//        dWidth=theGame.graphicsDevice.viewport.width;
        
        gravity=[Constants earthGravity];
                
        blockType[Grass] = [GrassBlock class];
        blockType[Water] = [WaterBlock class];
        blockType[Sand] = [SandBlock class];
        blockType[Concrete] = [ConcreteBlock class];
        
        [Ascene addItem:Pflagg];
        
        confetiAnimation= [[Confetti alloc] init];
        [Ascene addItem:confetiAnimation];
        
    }
    return self;
}

- (void)initBalls:(int)count withColors:(NSArray *)colors {
    for (int i = 0; i < count; i++) {
        Ball *ball = [[Ball alloc] init];
        if (i < [colors count]) {
            ball.color = colors[i];
        } else {
            ball.color = [Color white]; // Default color if there are less colors than balls
        }
        [balls addObject:ball];
        [Ascene addItem:ball];
    }
}

- (void) initialize {
    if(gravity){
        return;
    }
    [self firstLevel];
    [self reset];
    [super initialize];
    
}

-(void) reset {}
-(void) firstLevel{}
-(void) generateLevel{}

-(void) releaseBlocks{
    NSMutableArray *objectsToRemove = [NSMutableArray array];
    for (id object in Ascene) {
        if ([object conformsToProtocol:@protocol(IBlock)]) {
            [objectsToRemove addObject:object];
        }
    }
    
    for (id object in objectsToRemove) {
        [Ascene removeItem:object];
    }
    
    [self.groundBlocksArray removeAllObjects];
    [self.badBlocks removeAllObjects];
}

- (Ball *)getBall:(int)index {
    if(index >= balls.count) {
        NSLog(@"Index out of bounds");
        return nil;
    }
    return balls[index];
}

- (void) resetBall:(int)i {}

- (void) dealloc
{
    [star release];
    [Pflagg release];
    [balls release];
    [Ascene release];
    [super dealloc];
}

@end
