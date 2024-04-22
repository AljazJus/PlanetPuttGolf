//
//  GameHud.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import "GameHud.h"
#import "Retronator.PuttPuttGolf.h"
#import "SimpleScene.h"
#import "GameTime.h"
#import "FontTextureProcessor.h"
#import "GameComponent.h"
#import "Game.h"
#import "GameComponentCollection.h"
#import "Rectangle.h"

@implementation GameHud

- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        scene = [[SimpleScene alloc] init];
        puttPuttGolf = (PuttPuttGolf*)self.game;
    }
    return self;
}

@synthesize scene,menue;

- (void) initialize {
    if(menue){
        return;
    }
    // Buttons
    Texture2D *menueImg = [self.game.content load:@"menu"];
    
    FontTextureProcessor *fontProcessor = [[[FontTextureProcessor alloc] init] autorelease];
    SpriteFont *font = [[self.game.content load:@"textB" processor:fontProcessor] autorelease];
    
    indicatorCount=7;
    indicators=[[NSMutableArray alloc] initWithCapacity:indicatorCount];
    
    float bWindth=[puttPuttGolf.scale menuButtonSize];
    float bHeight=bWindth;
    float scale=bWindth/menueImg.width;
    menue = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:[puttPuttGolf.scale menuButtonW] y:[puttPuttGolf.scale menuButtonY] width:bWindth height:bHeight]
                                  background:menueImg font:font text:@""];
    
    [menue.backgroundImage setScaleUniform:scale];
    
    [menue.backgroundColor set:[Color multiply:[Color white] withScalar:0.5]];
    [scene addItem:menue];
    
    
    Texture2D *indicatorTexture = [[self.game.content load:@"indicator5"] autorelease];
    bWindth=50;
    indicatorScale=bWindth/indicatorTexture.width;
    
    offset =[[Vector2 alloc] init];
    offset.x = indicatorTexture.width/2*scale;
    offset.y = indicatorTexture.height/2*scale;
    float wid=25.0;
    
    for (int i=0;i<indicatorCount;i++){
        Image *ind = [[Image alloc] initWithTexture:indicatorTexture position:[Vector2 vectorWithX:0 y:0]];
        ind.sourceRectangle = [Rectangle rectangleWithX:0 y:0 width:indicatorTexture.width height:indicatorTexture.height];
        [ind setScaleUniform: indicatorScale];
        [ind setColor:[Color multiply:[Color white] withScalar:0.7]];
        [ind setLayerDepth:10];
        [ind setScaleUniform: wid/indicatorTexture.width];
        [indicators addObject:ind];
        [scene addItem:ind];
    }
}

-(void) initPlayerScore:(int) playerCount{
    
    pCount=playerCount;

    playerColor = [[NSMutableArray alloc] initWithCapacity:playerCount];
    playerScore = [[NSMutableArray alloc] initWithCapacity:playerCount];
    playerOpacity = [[NSMutableArray alloc] initWithCapacity:playerCount];
    
    FontTextureProcessor *fontProcessor = [[[FontTextureProcessor alloc] init] autorelease];
    SpriteFont *font = [self.game.content load:@"font1" processor:fontProcessor];
    for (int i = 0; i < playerCount; i++) {
       // Initialize Color, Label, and NSNumber objects and add them to the arrays
       Color *color = [Color red];
       Vector2 *position = [Vector2 vectorWithX:500 y:40];
       Label *label = [[Label alloc] initWithFont:font text:@"Score: 0" position:position];
        [label setScaleUniform:[puttPuttGolf.scale scoreFont]];
       NSNumber *opacity = @1;

       [playerColor addObject:color];
       [playerScore addObject:label];
       [playerOpacity addObject:opacity];
       [scene addItem:label];
   }
}
-(void) initPlayerHits:(int) playerCount hits:(int)hits{
    
    pCount=playerCount;

    playerHits = [[NSMutableArray alloc] initWithCapacity:playerCount];
    
    FontTextureProcessor *fontProcessor = [[[FontTextureProcessor alloc] init] autorelease];
    SpriteFont *font = [self.game.content load:@"font1" processor:fontProcessor];

    Color *color = [Color white];
    Vector2 *position = [Vector2 vectorWithX:200 y:40];
    Label *label = [[Label alloc] initWithFont:font text:[NSString stringWithFormat:@"Puttts: %i", hits] position:position];
    [label setScaleUniform:[puttPuttGolf.scale scoreFont]];
    label.color=color;
    [playerHits addObject:label];
    [scene addItem:label];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    
    [super updateWithGameTime:gameTime];
    
    TouchCollection *touches = [TouchPanelHelper getState];
    for (TouchLocation *touch in touches) {
        if (firstTouch ==nil) {
            firstTouch =[[Vector2 alloc] init];
            firstTouch.x = touch.position.x;
            firstTouch.y = touch.position.y;
        }
        if (firstTouch !=nil) {
            currentTouch =[[Vector2 alloc] init];
            currentTouch.x = touch.position.x;
            currentTouch.y = touch.position.y;
            float distance = [Vector2 subtract:firstTouch by:touch.position].length;
            if(distance>[Constants hitLimit])
                distance=[Constants hitLimit];
            
            // Calculate the slope and y-intercept for the line
            float m = (currentTouch.y - firstTouch.y) / (currentTouch.x - firstTouch.x);
            // Initialize the x and y coordinates of the first point
            float x = firstTouch.x;
            float y = firstTouch.y;

            // The distance you want between points
            float d = 50.0;
            
            float indShow=[Constants hitLimit]*0.9/indicatorCount;
            for (int i=0;i<indicatorCount;i++) {
                
                Image *ind=indicators[i];
                if(distance/indShow>i)
                    [ind setLayerDepth:1];
                else
                    [ind setLayerDepth:10];
                // Calculate the change in x and y
                float dx = d / sqrt(m * m + 1);
                float dy = m * dx;
                // Calculate the coordinates of the next point
                if(firstTouch.x-currentTouch.x>0){
                    x += dx;
                    y += dy;
                }else{
                    x -= dx;
                    y -= dy;
                }
                // Create a new Vector2 object for the current point
                Vector2 *point = [[Vector2 alloc] init];
                point.x = x;
                point.y = y;
                // Do something with the point (e.g., add it to an array)
                [ind setPosition:point];
            }
        }
        if(touch.state == TouchLocationStateReleased)
        {
            firstTouch=nil;
            currentTouch=nil;
            for (Image *ind in indicators) {
                [ind setLayerDepth:10];
            }
            
        }
    }
    
}

- (void) changePlayerScoreFor:(int)playerNum to:(int)value {
    
    playerScore[playerNum].text = [NSString stringWithFormat:@"Score: %i", value];
    playerOpacity[playerNum] = @(1);
    [playerColor[playerNum] set:[Color green]];
    [playerScore[playerNum] setScaleUniform:1];
    lastScore = playerNum;
}

- (void) changePlayerHitsFor:(int)playerNum to:(int)value {
    playerHits[playerNum].text = [NSString stringWithFormat:@"Hits: %i", value];
}

- (void) dealloc
{

    [super dealloc];
}


@end
