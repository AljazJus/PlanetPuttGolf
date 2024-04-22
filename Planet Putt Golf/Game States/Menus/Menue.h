//
//  Menue.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import "GameState.h"
#import "Retronator.PuttPuttGolf.classes.h"


NS_ASSUME_NONNULL_BEGIN

@interface Menue : GameState{
    
    Image *background;
    SimpleScene *scene;
    GuiRenderer *renderer;
    
    SpriteFont *retrotype, *fivexfive;
    Texture2D *buttonBackground;
    
    Button *back;
}

@property (nonatomic, retain) SimpleScene *scene;

@end

NS_ASSUME_NONNULL_END
