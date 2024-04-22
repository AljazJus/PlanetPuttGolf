//
//  PauseMenue.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 24. 12. 23.
//

#import "PauseMenue.h"
#import "GameComponent.h"
#import "Retronator.PuttPuttGolf.h"
#import "Rectangle.h"
@implementation PauseMenue

- (void) initialize {
    [super initialize];
    float width =puttPuttGolf.graphicsDevice.viewport.width;
    float height =puttPuttGolf.graphicsDevice.viewport.height;
    // Calculate the top left point
    
    // Text
    title = [[Label alloc] initWithFont:retrotype text:@"Pause Menu" position:[Vector2 vectorWithX:width/2 y:100]];
    title.horizontalAlign = HorizontalAlignCenter;
    [title setScaleUniform:[puttPuttGolf.scale titleFont]];
    [scene addItem:title];

    // Buttons
    float bWindth=width/4;
    float bHeight=bWindth/4;
    float scale=bWindth/buttonBackground.width;
   
    mainMenue = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width/2-bWindth/2 y:height*3/5 width:bWindth height:bHeight]
                                     background:buttonBackground font:retrotype text:@"Main menu"];
    [mainMenue.backgroundImage setScaleUniform:scale];
    [mainMenue.label setScaleUniform:[puttPuttGolf.scale buttonFont]];
    [scene addItem:mainMenue];

//    options = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width/2-bWindth/2 y:height*3/5 width:bWindth height:bHeight]
//                                     background:buttonBackground font:retrotype text:@"Settings"];
//    [options.backgroundImage setScaleUniform:scale];
//    [scene addItem:options];

    back= [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width/2-bWindth/2 y:height*4/5 width:bWindth height:bHeight]
                                 background:buttonBackground font:retrotype text:@"Back"];
    [back.backgroundImage setScaleUniform:scale];
    [back.label setScaleUniform:[puttPuttGolf.scale buttonFont]];
    [scene addItem:back];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    
    GameState *newState = nil;
    
    if (mainMenue.wasReleased) {
        [puttPuttGolf doublePopState];
    }
    
    if (newState){
        [puttPuttGolf pushState:newState];
    }
}

- (void) dealloc
{
    [title release];
    [mainMenue release];
    [options release];
    [background release];    
    [super dealloc];
    
}

@end
