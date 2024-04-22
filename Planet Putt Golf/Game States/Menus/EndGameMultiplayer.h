//
//  EndGameMultiplayer.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 24. 01. 24.
//

#import "Menue.h"

NS_ASSUME_NONNULL_BEGIN

@interface EndGameMultiplayer : Menue{
    Label *title;
    Label *lable;
    int pNum;
}
@property (nonatomic) int score;
- (id)initWithGame:(Game *)theGame score:(int)player;

@end

NS_ASSUME_NONNULL_END
