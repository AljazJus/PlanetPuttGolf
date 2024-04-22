//
//  MultiplayerMenue.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 7. 01. 24.
//

#import "MultiplayerMenue.h"

#import "Retronator.PuttPuttGolf.h"
#import "Rectangle.h"
@implementation MultiplayerMenue

- (void) initialize {
    [super initialize];
 
    float width =puttPuttGolf.graphicsDevice.viewport.width;
    float height =puttPuttGolf.graphicsDevice.viewport.height;
    
    // Text
    title = [[Label alloc] initWithFont:retrotype text:@"Multiplayer" position:[Vector2 vectorWithX:width/2 y:-100]];
    title.horizontalAlign = HorizontalAlignCenter;
    title.scale = [Vector2 vectorWithX:2 y:2];
    title.color=[Color black];
    [scene addItem:title];
    
    
    float bWindth=600;
    float bHeight=bWindth/4;
    float scale=bWindth/buttonBackground.width;
    back= [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width/2-bWindth/2 y:height*4/5 width:bWindth height:bHeight]
                                 background:buttonBackground font:retrotype text:@"Back"];
    
    
    [back.backgroundImage setScaleUniform:scale];
    [scene addItem:back];
    
    human= [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width/3-bWindth/2 y:height*2/5 width:bWindth height:bHeight]
                                 background:buttonBackground font:retrotype text:@"VS Human"];
    [human.backgroundImage setScaleUniform:scale];
    [scene addItem:human];
    
    ai= [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width*2/3-bWindth/2 y:height*2/5 width:bWindth height:bHeight]
                                 background:buttonBackground font:retrotype text:@"VS AI"];
    [ai.backgroundImage setScaleUniform:scale];
    [scene addItem:ai];

}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    
    GameState *newState = nil;
    
    if (ai.wasReleased) {
        newState = [[[AiSelect alloc] initWithGame:self.game] autorelease];
    } else if (human.wasReleased) {
        Class levelClass = [puttPuttGolf getLevelClass:LevelStart];
        newState = [[[GameplayMulti alloc] initMultiplayerWithGame:self.game levelClass:levelClass] autorelease];
    }
    
    if (newState) {
        
        [puttPuttGolf pushState:newState];
    }
}

- (void) dealloc
{
    
    [title release];
    [super dealloc];
}

@end
