//
//  TopScore.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 7. 01. 24.
//

#import "GameState.h"
#import "Retronator.PuttPuttGolf.classes.h"
#import "Menue.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopScore : Menue{
    Label *title;
    
    NSMutableArray<Label *> *scoreArray; // for a mutable array
}

@end

NS_ASSUME_NONNULL_END
