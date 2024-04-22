//
//  Menue.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import "Menue.h"
#import "Retronator.PuttPuttGolf.h"
#import "SimpleScene.h"
#import "FontTextureProcessor.h"
#import "Game.h"
#import "GameComponentCollection.h"
#import "Rectangle.h"
#import "Matrix.h"
@implementation Menue

@synthesize scene;
- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        
        scene = [[SimpleScene alloc] init];
        renderer = [[GuiRenderer alloc] initWithGame:self.game scene:scene];
    }
    return self;
}

- (void) activate {
    [self.game.components addComponent:renderer];
    
}

- (void) deactivate {
    [self.game.components removeComponent:renderer];
}

- (void) initialize {
    // Fonts
    FontTextureProcessor *fontProcessor = [[[FontTextureProcessor alloc] init] autorelease];
    retrotype = [self.game.content load:@"font1" processor:fontProcessor];
    fivexfive = [self.game.content load:@"font1" processor:fontProcessor];
    fivexfive.lineSpacing = 72;
    
    // Buttons
    buttonBackground = [self.game.content load:@"button"];

    NSString *backName=[puttPuttGolf.progress getTheamType];
    Texture2D *backgroundTexture = [[self.game.content load:backName] autorelease];
    
    float scale=[puttPuttGolf.scale background];

    background = [[Image alloc] initWithTexture:backgroundTexture position:[puttPuttGolf.scale backgroundPosition]];
    [background setScaleUniform: scale];
    
    [scene addItem:background];
    
    back = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:0 y:200 width:1000 height:1402]
                                  background:buttonBackground font:retrotype text:@"Back"];
    
    back.labelColor = [Color white];
    back.labelHoverColor = [Color gray];
    
    back.label.horizontalAlign = HorizontalAlignCenter;
    
    
    [super initialize];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    
    // Update all buttons.
    Matrix *inverseView = [Matrix invert:renderer.camera];

    for (id item in scene) {
        Button *button = [item isKindOfClass:[Button class]] ? item : nil;
        if (button) {
            [button updateWithInverseView:inverseView] ;
        }
    }
    
    if (back.wasReleased) {
        [puttPuttGolf popState];
    }
    
}

- (void) dealloc
{
    [back release];
    [buttonBackground release];
    [retrotype release];
    [fivexfive release];
    [scene release];
    [renderer release];
    [super dealloc];
}

@end
