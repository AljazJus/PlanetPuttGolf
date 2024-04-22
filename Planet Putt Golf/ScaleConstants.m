//
//  ScaleConstants.m
//  Planet Putt Golf
//
//  Created by Aljaž Justin on 20. 4. 24.
//

#import "ScaleConstants.h"
#import "Vector2.h"
@implementation ScaleConstants


- (id) init:(float)w height:(float)h {
    if (self = [super init]) {
        width=w;
        height=h;
        
        size=2;
        if (width >2700.0){
            size=1;
        }else if (width<2500.0){
            size=3;
        }
            
        NSLog(@"DISPLAY SIZE %f %f %d",width,height,size);
//        iphone plus: 2.796,0000 1.290,0000
//        iphpne : 2.556,0000 1.179,0000
//        iphone SE: 1.334,0000 750,0000
    }
    return self;
}

-(float) buttonFont{
    switch (size) {
        case 1:
            return 1.5;
            break;
        case 2:
            return 1.3; break;
        default:
            return 0.7;
            break;
    }
}

-(float) background{
    switch (size) {
        case 1:
            return 0.6990;
            break;
        case 2:
            return 0.6390; break;
        default:
            return 0.4169;
            break;
    }
}

-(float) titleFont{
    switch (size) {
        case 1:
            return 2;
            break;
        case 2:
            return 2;break;
        default:
            return 1;
            break;
    }
}

-(Vector2*) backgroundPosition{
    switch (size) {
        case 1:
            return [Vector2 vectorWithX:0 y:0]; break;
        case 2:
            return [Vector2 vectorWithX:0 y:0]; break;
        default:
            return [Vector2 vectorWithX:-width*0.1 y:0];
            break;
    }
}

-(float) colorButtonW{
    switch (size) {
        case 1:
            return 450.0; break;
        case 2:
            return 420.0;break;
        default:
            return 50.0;
            break;
    }
}

-(float) colorButtonY{
    switch (size) {
        case 1:
            return 250.0; break;
        case 2:
            return 250.0; break;
        default:
            return 220.0;
            break;
    }
}

-(float) colorButtonSize{
    switch (size) {
        case 1:
            return 150.0;   break;
        case 2:
            return 150.0;   break;
        default:
            return 100.0;
            break;
    }
}

-(float) colorButtonGpa{
    switch (size) {
        case 1:
            return 450.0/2;   break;
        case 2:
            return 420.0/2;   break;
        default:
            return 140.0;
            break;
    }
}

-(float) iconeButtonW{
    switch (size) {
        case 1:
            return 450.0; break;
        case 2:
            return 450.0; break;
        default:
            return 150.0;
            break;
    }
}

-(float) iconeButtonY{
    switch (size) {
        case 1:
            return 550.0;   break;
        case 2:
            return 450.0;break;
        default:
            return 400.0;
            break;
    }
}

-(float) iconeButtonSize{
    switch (size) {
        case 1:
            return 500.0; break;
        case 2:
            return 450.0; break;
        default:
            return 300.0;
            break;
    }
}

-(float) iconeButtonGpa{
    switch (size) {
        case 1:
            return 450.0*1.5;   break;
        case 2:
            return 450.0*1.2;   break;
        default:
            return 370.0;
            break;
    }
}

-(float) textScore{
    switch (size) {
        case 1:
            return 1.7;   break;
        case 2:
            return 1.7;   break;
        default:
            return 0.7;
            break;
    }
}

-(float) scoreGap{
    switch (size) {
        case 1:
            return 100;   break;
        case 2:
            return 100;   break;
        default:
            return 50;
            break;
    }
}

-(float) zoom{
    switch (size) {
        case 1:
            return 1.4;   break;
        case 2:
            return 1.25;   break;
        default:
            return 0.7;
            break;
    }
}

-(float) scoreFont{
    switch (size) {
        case 1:
            return 1;   break;
        case 2:
            return 1;   break;
        default:
            return 0.7;
            break;
    }
}

-(float) menuButtonW{
    switch (size) {
        case 1:
            return 2530;   break;
        case 2:
            return 2330;   break;
        default:
            return 1230;
            break;
    }
}

-(float) menuButtonY{
    switch (size) {
        case 1:
            return 50;   break;
        case 2:
            return 50;   break;
        default:
            return 30;
            break;
    }
}

-(float) menuButtonSize{
    switch (size) {
        case 1:
            return 150;   break;
        case 2:
            return 150;   break;
        default:
            return 90;
            break;
    }
}


-(Vector2*) cameraPos{
    switch (size) {
        case 1:
            return [Vector2 vectorWithX:0 y:0]; break;
        case 2:
            return [Vector2 vectorWithX:0 y:0]; break;
        default:
            return [Vector2 vectorWithX:0 y:-width*0.06];
            break;
    }
}


@end
