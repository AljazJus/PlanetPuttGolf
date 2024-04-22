//
//  Options.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import "Options.h"
#import "Retronator.PuttPuttGolf.h"
#import "Rectangle.h"
#import "Vector2.h"
@implementation Options

- (void) initialize {
    [super initialize];
    
    // Background
    Texture2D *backgroundTexture = [[self.game.content load:@"background"] autorelease];
    Texture2D *moonImg = [[self.game.content load:@"moon"] autorelease];
    Texture2D *jupyterImg = [[self.game.content load:@"jupiter"] autorelease];

    float extra=puttPuttGolf.graphicsDevice.viewport.width*0;
    float dWidth=puttPuttGolf.graphicsDevice.viewport.width;
    float dHeight=puttPuttGolf.graphicsDevice.viewport.height;
    float width =dWidth+extra*2;
    float height =dHeight+extra*2;
    float scale=width/backgroundTexture.width;
    
    
    Texture2D *colorButton = [self.game.content load:@"indicator"];

    // Text
    title = [[Label alloc] initWithFont:retrotype text:@"Settings" position:[Vector2 vectorWithX:width/2 y:100]];
    title.horizontalAlign = HorizontalAlignCenter;
    [title setScaleUniform:[puttPuttGolf.scale titleFont]];
    title.color=[Color black];
    [scene addItem:title];
    
    buttonArray = [[NSMutableArray<Button *> alloc] init];
    theamArray =  [[NSMutableArray<Button *> alloc] init];

    // Buttons
    float bWindth=[puttPuttGolf.scale colorButtonSize];
    float bHeight=bWindth;
    scale=bWindth/colorButton.width;
    
    NSArray<Color *> *colorArray = [Constants colorOptions];
    
    float buttonW=[puttPuttGolf.scale colorButtonW];
    float buttonGap=[puttPuttGolf.scale colorButtonGpa];
    
    for (ColourType i = 0; i < ColourTypes; i++) {
        Button *button = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:buttonW+i*buttonGap y:[puttPuttGolf.scale colorButtonY] width:bWindth height:bHeight] background:colorButton font:retrotype text:@""];
        
        [button.backgroundImage setScaleUniform:scale];
        [button.backgroundColor set:[colorArray objectAtIndex:i]];
        
        if([puttPuttGolf.progress isColourUnlocked:i]){
            button.enabled=YES;
        }
        else{
            button.enabled = NO;
            button.backgroundColor=[Color darkGray];
        }
        [buttonArray addObject:button];
        [scene addItem:button];
    }
    
    for (TheamType i = 0; i < TheamTypes; i++) {
        
        
        
        Texture2D *image=backgroundTexture;
        if(i==Moon){
            image=moonImg;
        } else if(i==Jupiter){
            image=jupyterImg;
        }
        bWindth=[puttPuttGolf.scale iconeButtonSize];
        bHeight=bWindth*(float)((float)image.height/(float)image.width);
        scale=bWindth/image.width;
        
        float iconeW=[puttPuttGolf.scale iconeButtonW];
        float iconeGap=[puttPuttGolf.scale iconeButtonGpa];
        Button *button = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:iconeW+i*iconeGap y:[puttPuttGolf.scale iconeButtonY] width:bWindth height:bHeight] background:image font:retrotype text:@""];
        
        [button.backgroundImage setScaleUniform:scale];
        //[puttPuttGolf.progress isTheamUnlocked:i]
        if([puttPuttGolf.progress isTheamUnlocked:i]||TRUE){
            button.enabled=YES;
            
        }
        else{
            NSLog(@"THEAM NOT %d",i);
            button.enabled = NO;
            button.backgroundColor=[Color colorWithRed:45 green:45 blue:45 alpha:255];
        }
        
        [theamArray addObject:button];
        [scene addItem:button];
    }
    
    bWindth=width/4;;
    bHeight=bWindth/4;
    scale=bWindth/buttonBackground.width;
    back= [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width/2-bWindth/2 y:height*4/5 width:bWindth height:bHeight]
                                 background:buttonBackground font:retrotype text:@"Back"];
    
    [back.backgroundImage setScaleUniform:scale];
    [back.label setScaleUniform:[puttPuttGolf.scale buttonFont]];
    [scene addItem:back];

}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    
    ColourType newColor=ColourTypes;
    for (ColourType i = white; i < ColourTypes; i++) {
        if (buttonArray[i].wasReleased) {
            newColor = i;
        }
    }
    if(newColor!=ColourTypes){
        [puttPuttGolf.progress setPlayerColor:newColor];
    }
    
    TheamType newTheam=TheamTypes;
    for (TheamType i = Defaul; i < TheamTypes; i++) {
        if (theamArray[i].wasReleased) {
            newTheam = i;
        }
    }
    if(newTheam!=TheamTypes){
        [puttPuttGolf.progress setTheam:newTheam];
    }
    
    
    
}

- (void) dealloc
{
    [title release];
    [super dealloc];
}


@end
