//
//  SoundEngine.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 5. 01. 24.
//

#import "GameComponent.h"
#import "Retronator.Xni.Framework.Audio.h"
#import "Retronator.PuttPuttGolf.classes.h"
#import "SoundEffect.h"
#import "SoundEffectInstance.h"

@interface SoundEngine : GameComponent {
    SoundEffect *soundEffects[SoundEffectTypes];
}

+ (void) initializeWithGame:(Game*)game;
+ (void) play:(SoundEffectType)type;
+ (void) play:(SoundEffectType)type withPan:(float)pan;

@end

