//
//  AiSelect.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 7. 01. 24.
//

#import "AiSelect.h"

#import "Retronator.PuttPuttGolf.h"
#import "Rectangle.h"

@implementation AiSelect

- (void) initialize {
    [super initialize];

    float width =puttPuttGolf.graphicsDevice.viewport.width;
    float height =puttPuttGolf.graphicsDevice.viewport.height;
    // Calculate the top left point

    
    // Text
    title = [[Label alloc] initWithFont:retrotype text:@"AI Opponent" position:[Vector2 vectorWithX:width/2 y:-100]];
    title.horizontalAlign = HorizontalAlignCenter;
    title.scale = [Vector2 vectorWithX:4 y:4];
    title.color=[Color black];
    [scene addItem:title];
    
    
    float bWindth=600;
    float bHeight=bWindth/4;
    float scale=bWindth/buttonBackground.width;
    back= [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width/2-bWindth/2 y:height*4/5 width:bWindth height:bHeight]
                                 background:buttonBackground font:retrotype text:@"Back"];
    
    
    [back.backgroundImage setScaleUniform:scale];
    [scene addItem:back];
    
    easy= [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width/3-bWindth/2 y:height*2/5 width:bWindth height:bHeight]
                                 background:buttonBackground font:retrotype text:@"EASy"];
    [easy.backgroundImage setScaleUniform:scale];
    [scene addItem:easy];
    
    medium= [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width*2/3-bWindth/2 y:height*2/5 width:bWindth height:bHeight]
                                 background:buttonBackground font:retrotype text:@"MEDIUM"];
    [medium.backgroundImage setScaleUniform:scale];
    [scene addItem:medium];
    
    hard= [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width/2-bWindth/2 y:height*3/5 width:bWindth height:bHeight]
                                 background:buttonBackground font:retrotype text:@"HARD"];
    [hard.backgroundImage setScaleUniform:scale];
    [scene addItem:hard];

}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    GameState *newState = nil;
    
    if (easy.wasReleased) {
        Class levelClass = [puttPuttGolf getLevelClass:LevelStart];
        Class aiClass=[puttPuttGolf getOpponentClass:badAi];
        newState = [[[GameplayMulti alloc] initAIPlayerWithGame:self.game levelClass:levelClass aiClass:aiClass ] autorelease];
        
    } else if (medium.wasReleased) {
        newState = [[[MultiplayerMenue alloc] initWithGame:self.game] autorelease];
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
