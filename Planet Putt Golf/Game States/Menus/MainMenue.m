//
//  MainMenue.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import "MainMenue.h"
#import "Retronator.PuttPuttGolf.h"
#import "Rectangle.h"
#import <GameKit/GameKit.h>
@implementation MainMenue

- (void) initialize {
    [super initialize];
    
    
    
    // Background
    
    
    
    
    float width =puttPuttGolf.graphicsDevice.viewport.width;
    float height=puttPuttGolf.graphicsDevice.viewport.height;
    float scale;
    
    
    // Text
    title = [[Label alloc] initWithFont:retrotype text:@"Planet Putt Golf" position:[Vector2 vectorWithX:width/2 y:100]];
    title.horizontalAlign = HorizontalAlignCenter;
    [title setScaleUniform:[puttPuttGolf.scale titleFont]];
    
    
    title.color=[Color black];
    [scene addItem:title];
    
    subtitle = [[Label alloc] initWithFont:fivexfive text:@"by Aljaz" position:[Vector2 vectorWithX:width/4 y:height*4/5]];
    subtitle.horizontalAlign = HorizontalAlignRight;
    [subtitle setScaleUniform:[puttPuttGolf.scale titleFont]*2/3];
    
    [scene addItem:subtitle];
    
    
    // Buttons
    float bWindth=width/4;
    float bHeight=bWindth/4;
    scale=bWindth/buttonBackground.width;
    
    singleplayer = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width*2/3 y:height*3/12 width:bWindth height:bHeight]
                                          background:buttonBackground font:retrotype text:@"Singleplayer"];
    [singleplayer.backgroundImage setScaleUniform:scale];
    
    [singleplayer.label setScaleUniform: [puttPuttGolf.scale buttonFont]];
    [scene addItem:singleplayer];
    
    multiplayer = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width*2/3 y:height*5/12 width:bWindth height:bHeight]
                                         background:buttonBackground font:retrotype text:@"Multiplayer"];
    [multiplayer.backgroundImage setScaleUniform:scale];
    [multiplayer.label setScaleUniform: [puttPuttGolf.scale buttonFont]];
    [scene addItem:multiplayer];
    
    options = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width*2/3 y:height*7/12 width:bWindth height:bHeight]
                                     background:buttonBackground font:retrotype text:@"Settings"];
    [options.backgroundImage setScaleUniform:scale];
    [options.label setScaleUniform: [puttPuttGolf.scale buttonFont]];
    [scene addItem:options];
    
    stats = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width*2/3 y:height*9/12 width:bWindth height:bHeight]
                                   background:buttonBackground font:retrotype text:@"Statistics"];
    [stats.backgroundImage setScaleUniform:scale];
    [stats.label setScaleUniform: [puttPuttGolf.scale buttonFont]];
    [scene addItem:stats];
    
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    
    GameState *newState = nil;
    
    if (singleplayer.wasReleased) {
        Class levelClass = [puttPuttGolf getLevelClass:LevelStart];
        newState = [[[GameplaySingle alloc] initSinglePlayerWithGame:self.game levelClass:levelClass ] autorelease];
    } else if (multiplayer.wasReleased) {
        Class levelClass = [puttPuttGolf getLevelClass:LevelStart];
        newState = [[[GameplayMulti alloc] initMultiplayerWithGame:self.game levelClass:levelClass] autorelease];
//        newState = [[[MultiplayerMenue alloc] initWithGame:self.game] autorelease];
    } else if (options.wasReleased) {
        newState = [[[Options alloc] initWithGame:self.game] autorelease];
    } else if (stats.wasReleased) {
        newState = [[[TopScore alloc] initWithGame:self.game] autorelease];
        [stats handlePress];
    }
    
    if (newState) {
        GKAccessPoint.shared.active = false;

        [puttPuttGolf pushState:newState];
    }
}

- (void) dealloc
{
    [title release];
    [subtitle release];
    [copyright release];
    
    [singleplayer release];
    [multiplayer release];
    [options release];
    
    [super dealloc];
}

@end
