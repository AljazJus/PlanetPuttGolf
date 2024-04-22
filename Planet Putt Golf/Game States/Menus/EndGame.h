//
//  EndGame.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 24. 01. 24.
//

#import "Menue.h"
#import "GameState.h"
#import "Retronator.PuttPuttGolf.classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface EndGame : Menue{
    Label *title;
    Label *lable;
    int score;
}
@property (nonatomic) int score;
- (id)initWithGame:(Game *)theGame score:(int)theScore;

@end

NS_ASSUME_NONNULL_END
