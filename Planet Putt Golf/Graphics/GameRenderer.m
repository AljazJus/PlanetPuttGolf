//
//  GameRenderer.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//

#import "GameRenderer.h"
#import "Retronator.PuttPuttGolf.h"
#import "Vector2.h"
#import "Color.h"
#import "GameServiceContainer.h"
#import "Rectangle.h"
#import "GameTime.h"
#import "Retronator.Xni.Framework.classes.h"

@implementation GameRenderer

@synthesize zoom,cameraTarget;

- (id) initWithGame:(Game *)theGame level:(Level *)theLevel theam:(TheamType)theamType  {
   
    if (self = [super initWithGame:theGame]) {
        puttPuttGolf = (PuttPuttGolf*)self.game;
        level = theLevel;
        theam=theamType;
        dHeight=theGame.graphicsDevice.viewport.height;
        dWidth=theGame.graphicsDevice.viewport.width;
        zoom=1.398;
        cameraTarget=[[Vector2 alloc] initWithVector2:[puttPuttGolf.scale cameraPos]];
        content = [[ContentManager alloc] initWithServiceProvider:self.game.services];
    }
    return self;
}

- (void) initialize {
    
    [super initialize];
}

- (id)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"spritepos" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void) loadContent {
    
    spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
    
    switch (theam) {
        case Defaul:
            [self loadContentEarth];
            break;
        case Moon:
            [self loadContentMoon];
            break;
        case Jupiter:
            [self loadContentJupiter];
            break;
        default:
            [self loadContentEarth];
            break;
    }
    
    Texture2D *explosionTexture = [[self.game.content load:@"Confetti"] autorelease];
    confetiSprite = [[AnimatedSprite alloc] initWithDuration:0.7];
    confetiSprite.looping = NO;
    for (int i = 0; i < 64; i++) {
        int column = i % 8;
        int row = i / 8;
        Sprite *sprite = [[[Sprite alloc] init] autorelease];
        sprite.texture = explosionTexture;
        sprite.sourceRectangle = [Rectangle rectangleWithX:column * 512 y:row * 512 width:512 height:512];
        sprite.origin = [Vector2 vectorWithX:256 y:256];
        sprite.scale = [Vector2 vectorWithX:1 y:1];
        AnimatedSpriteFrame *frame = [AnimatedSpriteFrame frameWithSprite:sprite start:confetiSprite.duration * (float)i / 64];
        [confetiSprite addFrame:frame];
    }
    confetiSprite.looping=NO;
    
    starSprite = [[Sprite alloc] init];
    NSString *assetName = @"star";
    starSprite.texture = [self.game.content load:assetName];
    starSprite.origin = [Vector2 vectorWithX:0 y:0];
    starSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:868 height:868];
    starSprite.scale=[Vector2 vectorWithX:80.0/868.0 y:80.0/868.0 ];
 
    // Load common sprites from main game content manager.
    NSDictionary *dict = [self JSONFromFile];
    NSDictionary *frames = [dict objectForKey:@"frames"];

    for (NSString *imageName in frames) {
        NSDictionary *imgDict = [frames objectForKey:imageName];
        NSDictionary *cords = [imgDict objectForKey:@"frame"];
        int x = [[cords objectForKey:@"x"] intValue];
        int y = [[cords objectForKey:@"y"] intValue];
        int w = [[cords objectForKey:@"w"] intValue];
        int h = [[cords objectForKey:@"h"] intValue];

        if ([imageName isEqualToString:@"ball.png"]) {
            ballSprite = [[Sprite alloc] init];
            ballSprite.texture = [self.game.content load:@"spritesheet"];
            ballSprite.sourceRectangle = [Rectangle rectangleWithX:x y:y width:w height:h];
            ballSprite.origin = [Vector2 vectorWithX:w/2 y:h/2];
            ballSprite.scale=[Vector2 vectorWithX:([Constants radius]*2)/w y:([Constants radius]*2)/h] ;
//            ballSprite.scale.y=0.5;

        }else if([imageName isEqualToString:@"flag.png"]){
            flagSprite = [[Sprite alloc] init];
            flagSprite.texture = [self.game.content load:@"spritesheet"];
            flagSprite.sourceRectangle = [Rectangle rectangleWithX:x y:y width:w height:h];
            flagSprite.origin = [Vector2 vectorWithX:w/2 y:h/2];
            flagSprite.scale=[Vector2 vectorWithX:0.5 y:0.5];
//            flagSprite.scale.y=0.5;
        }
    }
}

-(void) loadContentEarth{
    
    // Load common sprites from main game content manager.
    NSDictionary *dict = [self JSONFromFile];
    NSDictionary *frames = [dict objectForKey:@"frames"];
    
    gressSprite = [[Sprite alloc] init];
    NSString* assetName = @"grass";
    gressSprite.texture = [self.game.content load:assetName];
    gressSprite.origin = [Vector2 vectorWithX:0 y:0];
    gressSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:gressSprite.texture.width height:gressSprite.texture.height];
    gressSprite.scale=[Vector2 vectorWithX:0.5 y:0.5];
    
    dirtSprite = [[Sprite alloc] init];
    assetName = @"dirt";
    dirtSprite.texture = [self.game.content load:assetName];
    dirtSprite.origin = [Vector2 vectorWithX:0 y:0];
    dirtSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:dirtSprite.texture.width height:dirtSprite.texture.height];
    dirtSprite.scale=[Vector2 vectorWithX:0.5 y:0.5];
    
    sandSprit = [[Sprite alloc] init];
    assetName = @"sand1";
    sandSprit.texture = [self.game.content load:assetName];
    sandSprit.origin = [Vector2 vectorWithX:0 y:0];
    sandSprit.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:sandSprit.texture.width height:sandSprit.texture.height];
    sandSprit.scale=[Vector2 vectorWithX:0.5 y:0.5];
    
    roadSprite = [[Sprite alloc] init];
    assetName = @"road2";
    roadSprite.texture = [self.game.content load:assetName];
    roadSprite.origin = [Vector2 vectorWithX:0 y:0];
    roadSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:roadSprite.texture.width height:roadSprite.texture.height];
    roadSprite.scale=[Vector2 vectorWithX:0.5 y:0.5];
    
    background = [[Sprite alloc] init];
    assetName = @"background";
    background.texture = [self.game.content load:assetName];
    background.origin = [Vector2 vectorWithX:0 y:0];
    background.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:background.texture.width height:background.texture.height];
    background.scale=[Vector2 vectorWithX:[puttPuttGolf.scale background] y:[puttPuttGolf.scale background]];
    
    for (NSString *imageName in frames) {
        NSDictionary *imgDict = [frames objectForKey:imageName];
        NSDictionary *cords = [imgDict objectForKey:@"frame"];
        int x = [[cords objectForKey:@"x"] intValue];
        int y = [[cords objectForKey:@"y"] intValue];
        int w = [[cords objectForKey:@"w"] intValue];
        int h = [[cords objectForKey:@"h"] intValue];

        if ([imageName isEqualToString:@"ball.png"]) {
            ballSprite = [[Sprite alloc] init];
            ballSprite.texture = [self.game.content load:@"spritesheet"];
            ballSprite.sourceRectangle = [Rectangle rectangleWithX:x y:y width:w height:h];
            ballSprite.origin = [Vector2 vectorWithX:w/2 y:h/2];
            ballSprite.scale=[Vector2 vectorWithX:([Constants radius]*2)/w y:([Constants radius]*2)/h] ;
//            ballSprite.scale.y=0.5;

        }else if([imageName isEqualToString:@"flag.png"]){
            flagSprite = [[Sprite alloc] init];
            flagSprite.texture = [self.game.content load:@"spritesheet"];
            flagSprite.sourceRectangle = [Rectangle rectangleWithX:x y:y width:w height:h];
            flagSprite.origin = [Vector2 vectorWithX:w/2 y:h/2];
            flagSprite.scale=[Vector2 vectorWithX:0.5 y:0.5];
//            flagSprite.scale.y=0.5;
        }
    }
    
}

-(void) loadContentMoon{
    
    background = [[Sprite alloc] init];
    NSString *assetName = @"moon";
    background.texture = [self.game.content load:assetName];
    background.origin = [Vector2 vectorWithX:0 y:0];
    background.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:background.texture.width height:background.texture.height];
    float scale=dWidth/background.texture.width;
    background.scale=[Vector2 vectorWithX:scale y:scale];
    
    gressSprite = [[Sprite alloc] init];
    assetName = @"moonBack3";
    gressSprite.texture = [self.game.content load:assetName];
    gressSprite.origin = [Vector2 vectorWithX:0 y:0];
    gressSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:gressSprite.texture.width height:gressSprite.texture.height];
    gressSprite.scale=[Vector2 vectorWithX:0.5 y:0.5];
    
    dirtSprite = [[Sprite alloc] init];
    assetName = @"moonBack2";
    dirtSprite.texture = [self.game.content load:assetName];
    dirtSprite.origin = [Vector2 vectorWithX:0 y:0];
    dirtSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:dirtSprite.texture.width height:dirtSprite.texture.height];
    dirtSprite.scale=[Vector2 vectorWithX:0.5 y:0.5];
    
    
}


-(void) loadContentJupiter{
    
    background = [[Sprite alloc] init];
    NSString *assetName = @"jupiter";
    background.texture = [self.game.content load:assetName];
    background.origin = [Vector2 vectorWithX:0 y:0];
    background.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:background.texture.width height:background.texture.height];
    float scale=dWidth/background.texture.width;
    background.scale=[Vector2 vectorWithX:scale y:scale];
    
    gressSprite = [[Sprite alloc] init];
    assetName = @"jupyter-textutr1";
    gressSprite.texture = [self.game.content load:assetName];
    gressSprite.origin = [Vector2 vectorWithX:0 y:0];
    gressSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:gressSprite.texture.width height:gressSprite.texture.height];
    gressSprite.scale=[Vector2 vectorWithX:0.5 y:0.5];
    
    dirtSprite = [[Sprite alloc] init];
    assetName = @"jupyter-texture3";
    dirtSprite.texture = [self.game.content load:assetName];
    dirtSprite.origin = [Vector2 vectorWithX:0 y:0];
    dirtSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:dirtSprite.texture.width height:dirtSprite.texture.height];
    dirtSprite.scale=[Vector2 vectorWithX:0.5 y:0.5];
    
}

- (void) drawWithGameTime:(GameTime *)gameTime {
    [self.graphicsDevice clearWithColor:[Color white]];
    
    [spriteBatch beginWithSortMode:SpriteSortModeBackToFront BlendState:nil];
    
    // Calculate the top left point
//    float topLeftX = (dWidth / 2.0) - (background.sourceRectangle.width / 2.0);
//    float topLeftY = (dHeight / 2.0) - (background.sourceRectangle.height / 2.0);
    
    [spriteBatch draw:background.texture to:[puttPuttGolf.scale backgroundPosition] fromRectangle:nil tintWithColor:[Color white]
             rotation:0 origin:[Vector2 zero] scaleUniform:[puttPuttGolf.scale background] effects:SpriteEffectsNone layerDepth:0.9];
    
    for (id item in level.Ascene) {
       
//        NSLog(@"Item: %@", item);
        id<IPosition> itemWithPosition = [item conformsToProtocol:@protocol(IPosition)] ? item : nil;
        
        id<IBlock> blockItem = [item conformsToProtocol:@protocol(IBlock)] ? item : nil;
        
        id<IAnimation> animationItem = [item conformsToProtocol:@protocol(IAnimation)] ? item : nil;

        
        //Sprite *shadowSprite = nil;
        Sprite *sprite = nil;
        SpriteEffects effects = SpriteEffectsNone;
        float layer=0.1;
        
        if ([item isKindOfClass:[Ball class]]) {
            sprite = ballSprite;
        } else if ([item isKindOfClass:[Flagg class]]) {
            sprite = flagSprite;
        }else if ([item isKindOfClass:[GrassBlock class]]||[item isKindOfClass:[WaterBlock class]]){
            sprite = gressSprite;
        }else if ([item isKindOfClass:[ConcreteBlock class]]){
            sprite=roadSprite;
        }else if ([item isKindOfClass:[SandBlock class]]){
            sprite=sandSprit;
        }else if ([item isKindOfClass:[DirtBlock class]]){
            sprite = dirtSprite;
            layer=0.2;
        }else if ([item isKindOfClass:[FlaggBlock class]]){
            sprite = gressSprite;
        }else if ([item isKindOfClass:[Star class]]){
            sprite = starSprite;
            
        }if ([item isKindOfClass:[Confetti class]]){
            if (animationItem.isActive){
                confetiSprite.looping = YES;
            }
            sprite = [confetiSprite spriteLoop:gameTime.totalGameTime];
            if (!sprite) {
                confetiSprite.looping = NO;
                animationItem.isActive = NO;
            }
        }
//        cameraTarget=[Vector2 vectorWithX:100 y:100];
        Vector2 *renderPosition = nil;
        if (itemWithPosition)
        {
//            renderPosition=itemWithPosition.position;
            renderPosition = [Vector2 subtract:itemWithPosition.position by:cameraTarget];
            [renderPosition multiplyBy:zoom];
        }
        Rectangle *renderPositionB = nil;
        if(blockItem){
            renderPositionB= [Rectangle rectangleWithRectangle:blockItem.block];
            renderPositionB.x= (blockItem.block.x -cameraTarget.x)*zoom;
            renderPositionB.y= (blockItem.block.y -cameraTarget.y)*zoom;
            renderPositionB.width= blockItem.block.width*zoom;
            renderPositionB.height= blockItem.block.height*zoom;

        }
        
        
        if (blockItem && sprite) {
            [spriteBatch
             draw:sprite.texture
             toRectangle:renderPositionB
             fromRectangle:sprite.sourceRectangle
             tintWithColor:blockItem.color
             rotation:blockItem.rotation
             origin:[Vector2 zero]
             effects:0
             layerDepth:layer];
        }
        else if (itemWithPosition && sprite) {
            
            [spriteBatch
             draw:sprite.texture
             to:renderPosition
             fromRectangle:sprite.sourceRectangle
             tintWithColor:itemWithPosition.color
             rotation:itemWithPosition.rotation
             origin:sprite.origin
             scale:[Vector2 multiply:sprite.scale by:zoom]
             effects:effects
             layerDepth:0.1];
        }
    }
    
    [spriteBatch end];
}

- (void) unloadContent {
    
    
}

- (void) dealloc
{
    //[malletSprite release];
    [ballSprite release];
    [flagSprite release];
    [background release];
    [gressSprite release];
    [dirtSprite release];
    [content release];
    [spriteBatch release];
    
    [super dealloc];
    
}


@end
