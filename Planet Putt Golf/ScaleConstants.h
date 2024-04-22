//
//  ScaleConstants.h
//  Planet Putt Golf
//
//  Created by Aljaž Justin on 20. 4. 24.
//

#import <Foundation/Foundation.h>
#import "Color.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScaleConstants : NSObject{
    float width,height;
    int size;
}

- (id) init:(float)w height:(float)h ;

-(float) buttonFont;
-(float) background;
-(float) titleFont;
-(Vector2*) backgroundPosition;
-(float) colorButtonW;
-(float) colorButtonY;
-(float) colorButtonSize;
-(float) colorButtonGpa;

-(float) iconeButtonW;
-(float) iconeButtonY;
-(float) iconeButtonSize;
-(float) iconeButtonGpa;


-(float) textScore;
-(float) scoreGap;

-(float) zoom;

-(float) scoreFont;

-(float) menuButtonW;
-(float) menuButtonY;
-(float) menuButtonSize;
-(Vector2*) cameraPos;
@end

NS_ASSUME_NONNULL_END
