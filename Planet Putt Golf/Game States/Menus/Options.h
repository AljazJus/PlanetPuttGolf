//
//  Options.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import "GameState.h"
#import "Retronator.PuttPuttGolf.classes.h"
#import "Menue.h"

NS_ASSUME_NONNULL_BEGIN

@interface Options : Menue{
    Label *title, *colors, *theam;
    
    NSMutableArray<Button *> *buttonArray; // for a mutable array
    NSMutableArray<Button *> *theamArray; // for a mutable array

    Button *theamButtons;
}

@end

NS_ASSUME_NONNULL_END
