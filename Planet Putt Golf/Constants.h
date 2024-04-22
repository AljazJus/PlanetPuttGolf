//
//  Constants.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 30. 11. 23.
//

#import <Foundation/Foundation.h>
#import "Color.h"

NS_ASSUME_NONNULL_BEGIN

@interface Constants : NSObject{}

+(float) radius;

+(float) hitMultyplyer;
+(float) hitLimit;
+(float) earthGravity;
+(float) moonGravity;
+(float) jupiterGravity;

+(float) grassFriction;
+(float) grassBounce;

+(float) sandBounce;
+(float) sandFriction;

+(float) concreteBounce;
+(float) concreteFriction;

+(float) maxSpeed;

+(float)coefficientOfRestitution;

+(NSArray<Color *> *)colorOptions;
+(NSArray<NSString *> *)theamOptions;


+ (NSString*) progressFilePath;

@end

NS_ASSUME_NONNULL_END
