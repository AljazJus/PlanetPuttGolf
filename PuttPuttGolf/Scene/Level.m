//
//  Level.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import "Level.h"
#import "Retronator.PuttPuttGolf.h"

@implementation Level


@synthesize Pflagg, gravity, Ascene,hole,balls;
- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        Ascene = [[SimpleScene alloc] init];
        
        
        balls = [[NSMutableArray alloc] init];
        
        Pflagg= [[Flagg alloc] init];
        
        // Initialize the groundBlocksArray
        self.groundBlocksArray = [[NSMutableArray alloc] init];
        
        [Ascene addItem:Pflagg];
        
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
}

- (Ball *)getBall:(int)index {
    if(index >= balls.count) {
        NSLog(@"Index out of bounds");
        return nil;
    }
    return balls[index];
}

- (void) dealloc
{
    [Pflagg release];
    [balls release];
    [Ascene release];
    [super dealloc];
}



@end
