//
//  GameProgress.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 24. 12. 23.
//

#import <Foundation/Foundation.h>
#import "Retronator.PuttPuttGolf.classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameProgress : NSObject<NSCoding> {
    BOOL theamsUnlocked[TheamTypes];
    BOOL coloursUnlocked[ColourTypes];
    
    int palyerColor;
    TheamType theam;
    int topScoreHoles[5];
    int topScoreStars[5];

    int topScore[5];

    NSArray<Color *> *colorArray;

}
@property (nonatomic) TheamType theam;
@property (nonatomic) int palyerColor;


+ (GameProgress *) loadProgress;
+ (void) deleteProgress;
- (void) saveProgress;

- (Color *) getPlayerColor;
- (void) setPlayerColor:(ColourType)color;

- (BOOL) isTheamUnlocked:(TheamType)type;
- (BOOL) isColourUnlocked:(ColourType)type;

- (void) unlockColour:(ColourType)type;
- (void) unlockTheam:(TheamType)type;

-(void) addScore:(int)score;
-(void) addScoreHoles:(int)score;
-(void) addScoreStars:(int)score;

-(NSString *)getTheamType;

- (int *)getTopScoreStars;
- (int *)getTopScoreHoles;
- (int *)getTopScore;


@end

NS_ASSUME_NONNULL_END
