//
//  SoundEngine.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 5. 01. 24.
//

#import "SoundEngine.h"

#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.PuttPuttGolf.h"
#import "GameComponentCollection.h"

SoundEngine *instance;

@implementation SoundEngine

+ (void) initializeWithGame:(Game*)game {
    instance = [[SoundEngine alloc] initWithGame:game];
    [game.components addComponent:instance];
}

- (void) initialize {
    soundEffects[SoundEffectTypeGround] = [self.game.content load:@"ball_gorund3"];
    soundEffects[SoundEffectTypeHit1] = [self.game.content load:@"Hit1"];
    soundEffects[SoundEffectTypeHit2] = [self.game.content load:@"Hit2"];
    soundEffects[SoundEffectTypeHit3] = [self.game.content load:@"Hit3"];
    soundEffects[SoundEffectTypeWin] = [self.game.content load:@"Win"];
}

- (void) play:(SoundEffectType)type withPan:(float)pan {
    [soundEffects[type] playWithVolume:1 pitch:0 pan:pan];
}

+ (void) play:(SoundEffectType)type {
    [SoundEngine play:type withPan:0];
}

+ (void) play:(SoundEffectType)type withPan:(float)pan {
    [instance play:type withPan:pan];
}

- (void) dealloc
{
    for (int i = 0; i < SoundEffectTypes; i++) {
        [soundEffects[i] release];
    }
    [super dealloc];
}


@end

