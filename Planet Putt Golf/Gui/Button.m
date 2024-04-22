//
//  Button.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import "Button.h"
#import "Retronator.PuttPuttGolf.h"
#import "Rectangle.h"
#import "TouchCollection.h"
#import "GameWindow.h"

@implementation Button

- (id) initWithInputArea:(Rectangle*)theInputArea
             background:(Texture2D*)background
                   font:(SpriteFont*)font
                   text:(NSString*)text
{
    self = [super init];
    if (self != nil) {
        
        inputArea = [theInputArea retain];
        enabled = YES;
                
        backgroundImage = [[Image alloc] initWithTexture:background position:[Vector2 vectorWithX:inputArea.x y:inputArea.y]];
        label = [[Label alloc] initWithFont:font
                                       text:text
                                   position:[Vector2 vectorWithX:inputArea.x + inputArea.width*0.1 y:inputArea.y + inputArea.height/2]];
        label.verticalAlign = VerticalAlignMiddle;
        label.scale = [Vector2 vectorWithX:1.3 y:1.3];
        
        self.backgroundColor = [Color white];
        self.backgroundHoverColor = [Color dimGray];
        
        self.labelColor = [Color black];
        self.labelHoverColor = [Color white];
        
    }
    return self;
}

@synthesize inputArea, enabled, isDown, wasPressed, wasReleased, scene, backgroundImage, label;
@synthesize labelColor, labelHoverColor, backgroundColor, backgroundHoverColor;

- (void) setLabelColor:(Color *)value {
    [value retain];
    [labelColor release];
    labelColor = value;
    label.color = labelColor;
}

- (void) setBackgroundColor:(Color *)value {
    [value retain];
    [backgroundColor release];
    backgroundColor = value;
    backgroundImage.color = backgroundColor;
}

- (void) addedToScene:(id <IScene>)theScene {
    // Add child items to scene.
    [theScene addItem:backgroundImage];
    [theScene addItem:label];
}

- (void) removedFromScene:(id <IScene>)theScene {
    // Remove child items.
    [theScene removeItem:backgroundImage];
    [theScene removeItem:label];
}

- (void) updateWithInverseView:(Matrix *)inverseView  {
    if (!enabled) {
        return;
    }
    
    TouchCollection *touches = [TouchPanelHelper getState];
    
    if (touches.count==0) {
        return;
    }
        
    BOOL wasDown = isDown;
    
    isDown = NO;
    wasPressed = NO;
    wasReleased = NO;

    for (TouchLocation *touch in touches) {
        Vector2* touchInScene =touch.position ;
        
        if ([inputArea containsVector:touchInScene] && touch.state != TouchLocationStateInvalid) {
            
            if (touch.state == TouchLocationStatePressed) {
                pressedID = touch.identifier;
                wasPressed = YES;
            }
            
            // Only act to the touch that started the push.
            if (touch.identifier == pressedID) {
                if (touch.state == TouchLocationStateReleased) {
                    wasReleased = YES;
                } else {
                    isDown = YES;
                }
            }
        }
    }
        
    if (isDown && !wasDown) {
        backgroundImage.color = backgroundHoverColor;
        label.color = labelHoverColor;
    } else if (!isDown && wasDown) {
        backgroundImage.color = backgroundColor;
        label.color = labelColor;
    }
}

- (void) handlePress{
    wasReleased = NO;
}

- (void) dealloc
{
    [backgroundImage release];
    [label release];
    [inputArea release];
    [super dealloc];
}

@end
