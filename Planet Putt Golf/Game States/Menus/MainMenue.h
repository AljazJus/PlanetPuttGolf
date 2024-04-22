//
//  MainMenue.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import "GameState.h"
#import "Retronator.PuttPuttGolf.classes.h"
#import "Menue.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainMenue : Menue{
    
    Label *title, *subtitle, *copyright;
    
    Button *singleplayer, *multiplayer, *options,*stats;
}

@end

NS_ASSUME_NONNULL_END
