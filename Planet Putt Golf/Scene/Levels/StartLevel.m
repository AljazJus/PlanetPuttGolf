//
//  StartLevel.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import "StartLevel.h"
#import "Retronator.PuttPuttGolf.h"
#import "Color.h"
#import "Rectangle.h"
#import "SimpleScene.h"

@implementation StartLevel
- (void) initialize {
    
    randomBlock=0.5;
    fWidth=2000;
    fHeight=1000;
    bWidth=50;
    [self firstLevel];
}

- (void) reset {
    Pflagg.color=[Color white];
    confetiAnimation.color = [Color white];
    
    for(Ball *ball in balls)
    {
        ball.position.x = roundf(startPoint.x);
        ball.position.y = roundf(startPoint.y);
        ball.velocity.x = 0;
        ball.velocity.y = 0;
        ball.angularVelocity=0;
        ball.rotation=0;
    }
}

- (void) resetBall:(int)i {
    if (i < [balls count]) {
        Ball *ball = [balls objectAtIndex:i];
        ball.position.x = roundf(startPoint.x);
        ball.position.y = roundf(startPoint.y);
        ball.velocity.x = 0;
        ball.velocity.y = 0;
        ball.angularVelocity=0;
        ball.rotation=0;
    } else {
        NSLog(@"Index %d out of bounds for balls array", i);
    }
}

-(void) firstLevel{
    //    ball.velocity.x = -/*200.0*/;
    float bWidth=100.0;
//    float bHeight=50.0;
    float botom=800.0;
    startPoint=[[Vector2 alloc] initWithX:1800 y:botom-100];
    
    star.position.y=500.0;
    star.position.x=[self randomFloatBetweenMin:400 andMax:(float)fWidth-200];
    
    for (int x = 0; x <= fWidth; x += bWidth) {
        if (x==300){
            [self drawHole: [[Vector2 alloc] initWithX:x y:botom]];
        }
        else
        {
            [self drawBlock:[Vector2 vectorWithX:x y:botom] length:bWidth  type:Grass];
        }
    }
    
    for (GroundBlock *block in self.groundBlocksArray) {
        [Ascene addItem:block];
    }
        
    [self reset];
}

-(void) generateLevel{
    
    Pflagg.position.x = 450.0;
    Pflagg.position.y = 900.0;
    star.position.y=-20;
    star.position.x=-20;
    startPoint=[[Vector2 alloc] initWithX:1900 y:750.0];
    
    star.position.x=[self randomFloatBetweenMin:400 andMax:(float)fWidth-200];
    
    for(Ball *ball in balls)
    {
        ball.position.x = roundf(startPoint.x);
        ball.position.y = roundf(startPoint.y);
        ball.velocity.x = 0;
        ball.velocity.y = 0;
        ball.angularVelocity=0;
        ball.rotation=0;
        ball.hasScored=NO;
    }
    
    float step = 400.0;
    float start = 1800.0;
    float hight = 800.0;
    float maxHightStep = 200.0;
    float minHightStep = 50.0;
    bool hole = true;
    float extend=0;
    
    [self drawBlock:[Vector2 vectorWithX:start y:hight] length:step  type:Grass];
    
    for (int x = start; x >= 200; x -= step) {
        // Draw a hole
        if(hole && x<900)
        {
            [self drawHole: [[Vector2 alloc] initWithX:x-step y:hight]];
            hole=false;
            [self drawBlock:[Vector2 vectorWithX:x-step+100 y:hight] length: step-100 type:Grass];
            continue;
        }
        
        //set prev height
        float prevHight = hight;
        
        // 50% for hight change
        if ([self randomFloatBetweenMin:0.0 andMax:1.0] < 2)
        {
            float heightDif = [self randomFloatBetweenMin:minHightStep andMax:maxHightStep];
            
            if ([self randomFloatBetweenMin:0.0 andMax:1.0] < 1.0/2.0)
            {
                if (hight+heightDif<800.0)
                    hight=hight+heightDif;
            }
            else
            {
                if (hight-heightDif>400.0)
                    hight=hight-heightDif;
            }
        }
        
        if(star.position.x<x+step && star.position.x>x)
            star.position.y=[self randomFloatBetweenMin:100 andMax:hight-200];
        
        // if the hight is the same
        if(prevHight==hight)
        {
            int block=Grass;
            if ([self randomFloatBetweenMin:0.0 andMax:1.0] < randomBlock && puttPuttGolf.progress.theam==Defaul)
                block=roundf([self randomFloatBetweenMin:0 andMax:Water]);
            [self drawBlock:[Vector2 vectorWithX:x-step y:prevHight] length:step  type:block];
            extend=0;
        }
        else{

            // zafilam nezapolnjen del
            if(prevHight>hight){
                // Calculate the difference in x and y between the current and previous block
                float dx = step*1/3;
                float dy =  prevHight-hight;
                // Calculate the angle using the atan2 function
                float angle = atan2(dy, dx);
                // Calculate the distance using the Pythagorean theorem
                float distance = sqrt(dx * dx + dy * dy);
                
                // get a random block
                int block=Grass;
                if(theam==Defaul){
                    if ([self randomFloatBetweenMin:0.0 andMax:1.0] < randomBlock)
                        block=roundf([self randomFloatBetweenMin:0 andMax:Concrete]);
                }
                // draw flat block
                [self drawBlock:[Vector2 vectorWithX:x-(step*2/3)-40 y:prevHight] length:step*2/3+42  type:block];
                extend=0;
                // draw angle block
                [self drawBlock:[Vector2 vectorWithX:x-step y:hight] length:distance+20 angle:angle type:block];
                // draw filler dirt
                DirtBlock *dirt = [[DirtBlock alloc] init];
                dirt.block.x = x-step;
                dirt.block.y = prevHight+50;
                dirt.rotation = 0;
                dirt.block.width = step*1/3;
                dirt.block.height = fHeight-prevHight;

                [self.groundBlocksArray addObject:dirt];
            }else{
                // Calculate the difference in x and y between the current and previous block
                float dx = step*1/3+40;
                float dy =  prevHight-hight;
                // Calculate the angle using the atan2 function
                float angle = atan2(dy, dx);
                // Calculate the distance using the Pythagorean theorem
                float distance = sqrt(dx * dx + dy * dy);
                
                // get a random block
                int block=Grass;
                if ([self randomFloatBetweenMin:0.0 andMax:1.0] < randomBlock && theam==Defaul)
                    block=roundf([self randomFloatBetweenMin:0 andMax:Concrete]);
                
                // draw flat block
                [self drawBlock:[Vector2 vectorWithX:x-(step*2/3) y:prevHight] length:step*2/3+2  type:block];
                extend=0;
                // draw angle block
                [self drawBlock:[Vector2 vectorWithX:x-step-40 y:hight] length:distance angle:angle type:block];
                // draw filler dirt
                DirtBlock *dirt = [[DirtBlock alloc] init];
                dirt.block.x = x-step;
                dirt.block.y = hight+25;
                dirt.rotation = 0;
                dirt.block.width = step*1/3;
                dirt.block.height = fHeight-prevHight;

                [self.groundBlocksArray addObject:dirt];
                
                extend=30;
            }
        }
        
    }
    for (GroundBlock *block in self.groundBlocksArray) {
        [Ascene addItem:block];
    }
    
}

-(void) drawBlock:(Vector2 *)position length:(float) length type:(BlockType)type{
    
    Class blockClass= blockType[type];
    
    GroundBlock *groundBlock1 = [[blockClass alloc] init];
    groundBlock1.block.x = position.x;
    groundBlock1.block.y = position.y;
    groundBlock1.rotation = 0;
    groundBlock1.block.width = length;
    groundBlock1.block.height = bWidth+1;
    if(type== Water){
        [self.badBlocks addObject:groundBlock1];
    }
    
    [self.groundBlocksArray addObject:groundBlock1];
    
    DirtBlock *dirt = [[DirtBlock alloc] init];
    dirt.block.x = position.x;
    dirt.block.y = position.y+bWidth;
    dirt.rotation = 0;
    dirt.block.width = length;
    dirt.block.height = fHeight-position.y;
    
        
    [self.groundBlocksArray addObject:dirt];
    
}

-(void) drawBlock:(Vector2 *)position length:(float) length angle:(float)angle type:(BlockType)type{
    
    Class blockClass= blockType[type];

    GroundBlock *groundBlock1 = [[blockClass alloc] init];
    groundBlock1.block.x = position.x;
    groundBlock1.block.y = position.y;
    groundBlock1.rotation = angle;
    groundBlock1.block.width = length;
    groundBlock1.block.height = bWidth+2;
    if(type== Water){
        [self.badBlocks addObject:groundBlock1];
    }
    [self.groundBlocksArray addObject:groundBlock1];
    
    DirtBlock *dirt = [[DirtBlock alloc] init];
    // Calculate the position of the bottom left corner of the GrassBlock after rotation
    float rotatedX = groundBlock1.block.x - groundBlock1.block.height * sin(groundBlock1.rotation);
    float rotatedY = groundBlock1.block.y + groundBlock1.block.height * cos(groundBlock1.rotation);
    dirt.block.x = rotatedX;
    dirt.block.y = rotatedY;
    dirt.rotation = angle;
    dirt.block.width = length;
    dirt.block.height = fHeight - dirt.block.y; // Adjust the height of the DirtBlock based on its new y position

    [self.groundBlocksArray addObject:dirt];
    
}



-(void) drawHole:(Vector2 *)position{
    
    GrassBlock *groundBlock1 = [[GrassBlock alloc] init];
    groundBlock1.block.x = position.x;
    groundBlock1.block.y = position.y;
    groundBlock1.block.width = 15.0;
    groundBlock1.block.height = 150.0;
    [self.groundBlocksArray addObject:groundBlock1];
    
    GrassBlock *groundBlock2 = [[GrassBlock alloc] init];
    groundBlock2.block.x = position.x+85.0;
    groundBlock2.block.y = position.y;
    groundBlock2.block.width = 16.0;
    groundBlock2.block.height = 150.0;
    [self.groundBlocksArray addObject:groundBlock2];
    
    self.hole = [[FlaggBlock alloc] init];
    self.hole.block.x = position.x+15.0;
    self.hole.block.y = position.y+100;
    self.hole.block.width = 70.0;
    self.hole.block.height = bWidth;
    self.hole.color= [Color gray];
    
    
    DirtBlock *dirt = [[DirtBlock alloc] init];
    dirt.block.x = position.x-1;
    dirt.block.y = position.y+149;
    dirt.block.width =102;
    dirt.block.height = fHeight-position.y-2;
    [self.groundBlocksArray addObject:dirt];
    
    
    Pflagg.position.x = position.x+50.0;
    Pflagg.position.y = position.y-100;
    Pflagg.color=[Color red];
    confetiAnimation.position.x = Pflagg.position.x;
    confetiAnimation.position.y = position.y-220;
                
    [self.groundBlocksArray addObject:self.hole];
}

- (float)randomFloatBetweenMin:(float)min andMax:(float)max {
    float random = ((float)arc4random() / 0x100000000);
    float diff = max - min;
    float r = random * diff;
    return min + r;
}

@end
