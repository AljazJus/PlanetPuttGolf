//
//  MultiplayerMenue.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 7. 01. 24.
//

#import "GameState.h"
#import "Retronator.PuttPuttGolf.classes.h"
#import "Menue.h"

NS_ASSUME_NONNULL_BEGIN

@interface MultiplayerMenue : Menue{
    Label *title;
    
    Button *human,*ai;
}

@end

NS_ASSUME_NONNULL_END
