//
//  GuiRenderer.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 21. 12. 23.
//

#import "GuiRenderer.h"
#import "Retronator.PuttPuttGolf.h"

#import "GameWindow.h"
#import "Rectangle.h"
#import "Matrix.h"
#import "Vector3.h"
#import "Image.h"
#import "Label.h"

@implementation GuiRenderer

@synthesize camera;

- (id) initWithGame:(Game*)theGame scene:(id<IScene>)theScene
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        scene = theScene;
    }
    return self;
}

- (void) initialize {
    float scaleX = (float)self.game.gameWindow.clientBounds.width;
    float scaleY = (float)self.game.gameWindow.clientBounds.height;
    camera = [[Matrix createScale:[Vector3 vectorWithX:scaleX y:scaleY z:1]] retain];
    [super initialize];
}

- (void) loadContent {
    spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
}

- (void) drawWithGameTime:(GameTime *)gameTime {
    
    [spriteBatch beginWithSortMode:SpriteSortModeBackToFront BlendState:nil];
//    [spriteBatch beginWithSortMode:SpriteSortModeDeffered
//                        BlendState:nil
//                      SamplerState:[SamplerState pointClamp]
//                 DepthStencilState:nil
//                   RasterizerState:nil
//                            Effect:nil
//                   TransformMatrix:camera];
    
    for (id item in scene) {
        
        Label *label = [item isKindOfClass:[Label class]] ? item : nil;
        Image *image = [item isKindOfClass:[Image class]] ? item : nil;
        
        if ([item isKindOfClass:[Button class]]) {
            Button *button = [item isKindOfClass:[Button class]] ? item : nil;
            label = button.label;
            image = button.backgroundImage;
        }

        
        if (image) {
            [spriteBatch draw:image.texture to:image.position fromRectangle:image.sourceRectangle tintWithColor:image.color
                     rotation:image.rotation origin:image.origin scale:image.scale effects:SpriteEffectsNone layerDepth:image.layerDepth];
        }
        if (label) {
            [spriteBatch drawStringWithSpriteFont:label.font text:label.text to:label.position tintWithColor:label.color
                        rotation:label.rotation origin:label.origin scale:label.scale effects:SpriteEffectsNone layerDepth:label.layerDepth];
        }
    }
    
    [spriteBatch end];
}

- (void) unloadContent {
    [spriteBatch release];
}
@end
