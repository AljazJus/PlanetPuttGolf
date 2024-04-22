//
//  EndGame.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 24. 01. 24.
//

#import "EndGame.h"

#import "Retronator.PuttPuttGolf.h"
#import "Rectangle.h"

@implementation EndGame

@synthesize score;

// In EndGame.m
- (id)initWithGame:(Game *)theGame score:(int)theScore {
    self = [super initWithGame:theGame];
    if (self) {
        // Initialize your state here
        score = theScore;
    }
    return self;
}

- (void) initialize {
    [super initialize];

    float width =puttPuttGolf.graphicsDevice.viewport.width;
    float height =puttPuttGolf.graphicsDevice.viewport.height;

    //declear color for text
    Color *textColor = [Color white];

    // Text
    title = [[Label alloc] initWithFont:retrotype text:@"END GAME" position:[Vector2 vectorWithX:width/2 y:100]];
    title.horizontalAlign = HorizontalAlignCenter;
    [title setScaleUniform: [puttPuttGolf.scale titleFont]];
    title.color=textColor;
    [scene addItem:title];
    
    
    NSString *scoreString = [NSString stringWithFormat:@"YOUR SCORE %d", score];
    lable =[[Label alloc] initWithFont:retrotype text:scoreString position:[Vector2 vectorWithX:width/2 y:height/2]];
    lable.horizontalAlign = HorizontalAlignCenter;
    [lable setScaleUniform: [puttPuttGolf.scale titleFont]];
    lable.color=textColor;
    [scene addItem:lable];
    
    
    float bWindth=width/4;
    float bHeight=bWindth/4;
    float scale=bWindth/buttonBackground.width;
    back= [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width/2-bWindth/2 y:height*4/5 width:bWindth height:bHeight]
    background:buttonBackground font:retrotype text:@"Back"];
    
    [back.label setScaleUniform:[puttPuttGolf.scale buttonFont]];
    [back.backgroundImage setScaleUniform:scale];
    [scene addItem:back];

}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    
}


- (void) dealloc
{
    [title release];
    [lable release];
    
    [super dealloc];
}
@end
