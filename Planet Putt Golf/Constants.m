//
//  Constants.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 30. 11. 23.
//

#import "Constants.h"
#import "Color.h"
@implementation Constants

+(float) radius{
    return 25.0;
}

+(float) hitMultyplyer{
    return 7.0;
}
+(float) hitLimit{
    return 550.0;
}

+(float) grassFriction{
    return 0.015;
}
+(float) grassBounce{
    return  0.7;
}

+(float) sandBounce{
    return  0.6;
}
+(float) sandFriction{
    return 0.035;
}

+(float) concreteBounce{
    return  0.8;
}
+(float) concreteFriction{
    return 0.01;
}

+(float) earthGravity{
    return 6500.8;
}

+(float) moonGravity{
    return 3500.8;
}

+(float) jupiterGravity{
    return 9500.8;
}

+(float) maxSpeed{
    return 340.0*100.0;
}

+(float)coefficientOfRestitution{
    return 0.7;
}

+(NSArray<Color *> *)colorOptions{
    NSArray<Color *> *colorArray = @[
        [Color white],
        [Color black],
        [Color red],
        [Color green],
        [Color blue],
        [Color yellow],
        [Color orange],
        [Color purple],
        [Color gold]
    ];
    return colorArray;
}

+(NSArray<NSString *> *)theamOptions{
    NSArray<NSString *> *colorArray = @[
        @"background",
        @"moon",
        @"jupiter"
    ];
    return colorArray;
}

+ (NSString*) progressFilePath {
    return @"PuttPuttGolfSave";
}

@end
