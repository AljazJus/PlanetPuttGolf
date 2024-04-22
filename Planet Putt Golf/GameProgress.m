//
//  GameProgress.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 24. 12. 23.
//

#import "GameProgress.h"
#import "Retronator.PuttPuttGolf.h"
#import "Color.h"

@implementation GameProgress
@synthesize  theam,palyerColor;
- (id) init
{
    self = [super init];
    if (self != nil) {
        // Unlock first opponent and level type.
        theamsUnlocked[Defaul] = YES;
        
        coloursUnlocked[white] = YES;
        coloursUnlocked[black] = YES;
        coloursUnlocked[red] = YES;
        coloursUnlocked[green] = YES;
        coloursUnlocked[blue] = YES;
        coloursUnlocked[yellow] = YES;
        
        palyerColor=white;
        theam=Defaul;
        
        colorArray = [Constants colorOptions];
        
        
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {
        for (int i = 0; i < LevelTypes; i++) {
            theamsUnlocked[i] = [aDecoder decodeBoolForKey:[NSString stringWithFormat:@"theamsUnlocked%i", i]];
        }
        for (int i = 0; i < ColourTypes; i++) {
            coloursUnlocked[i] = [aDecoder decodeBoolForKey:[NSString stringWithFormat:@"coloursUnlocked%i", i]];
        }
        for (int i = 0; i < 5; i++) {
            topScore[i] = [aDecoder decodeIntForKey:[NSString stringWithFormat:@"topScore%i", i]];
        }
        for (int i = 0; i < 5; i++) {
            topScoreHoles[i] = [aDecoder decodeIntForKey:[NSString stringWithFormat:@"topScoreHoles%i", i]];
        }
        for (int i = 0; i < 5; i++) {
            topScoreStars[i] = [aDecoder decodeIntForKey:[NSString stringWithFormat:@"topScoreStars%i", i]];
        }
        palyerColor = [aDecoder decodeIntForKey:[NSString stringWithFormat:@"playerColor"]];
        
        theam = [aDecoder decodeIntForKey:[NSString stringWithFormat:@"playerTheam"]];

    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    for (int i = 0; i < LevelTypes; i++) {
        [aCoder encodeBool:theamsUnlocked[i] forKey:[NSString stringWithFormat:@"theamsUnlocked%i", i]];
    }
    for (int i = 0; i < ColourTypes; i++) {
        [aCoder encodeBool:coloursUnlocked[i] forKey:[NSString stringWithFormat:@"coloursUnlocked%i", i]];
    }
    for (int i = 0; i < 5; i++) {
        [aCoder encodeInt:topScore[i] forKey:[NSString stringWithFormat:@"topScore%i", i]];
    }
    for (int i = 0; i < 5; i++) {
        [aCoder encodeInt:topScoreHoles[i] forKey:[NSString stringWithFormat:@"topScoreHoles%i", i]];
    }
    for (int i = 0; i < 5; i++) {
        [aCoder encodeInt:topScoreStars[i] forKey:[NSString stringWithFormat:@"topScoreStars%i", i]];
    }
    
    [aCoder encodeInt:palyerColor forKey:[NSString stringWithFormat:@"playerColor"]];
    
    [aCoder encodeInt:theam forKey:[NSString stringWithFormat:@"playerTheam"]];

}

+ (GameProgress *) loadProgress {
    // Load game progress from file.
    
    GameProgress *progress = nil;
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *archivePath = [rootPath stringByAppendingPathComponent:[Constants progressFilePath]];
    
    progress = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
    
    // If there is no progress file, create a fresh instance.
    if (!progress) {
        progress = [[[GameProgress alloc] init] autorelease];
    }
    
    return progress;
}

+ (void) deleteProgress {
    // Delete game progress file.
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *archivePath = [rootPath stringByAppendingPathComponent:[Constants progressFilePath]];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:archivePath error:&error];
}

- (void) saveProgress {
    // Save game progress to file.
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *archivePath = [rootPath stringByAppendingPathComponent:[Constants progressFilePath]];
    [NSKeyedArchiver archiveRootObject:self toFile:archivePath];
}

- (BOOL) isTheamUnlocked:(TheamType)type {
    return theamsUnlocked[type];
}

- (BOOL) isColourUnlocked:(ColourType)type {
   
    if (coloursUnlocked[type])
        return YES;
    else
        return NO;
    
}

-(NSString *)getTheamType{
    return [Constants theamOptions][theam];
}

- (Color *) getPlayerColor{
    return [Constants colorOptions][palyerColor];
}

- (void) setTheam:(TheamType)t{
    theam=t;
    [self saveProgress];
}

- (void) setPlayerColor:(ColourType)color{
    palyerColor=color;
    [self saveProgress];
}

- (void) unlockTheam:(TheamType)type {
    theamsUnlocked[type] = YES;
    [self saveProgress];
}

- (void) unlockColour:(ColourType)type {
    coloursUnlocked[type] = YES;
    [self saveProgress];
}

-(void) addScore:(int)score{
    if(score<topScore[4]){
        return;
    }
    for(int i=0;i<5;i++){
        if(score>topScore[i]){
            for(int j=4;j>i;j--){
                topScore[j]=topScore[j-1];
            }
            topScore[i]=score;
            break;
        }
    }
    [self saveProgress];
}

-(void) addScoreHoles:(int)score{
    if(score<topScoreHoles[4]){
        return;
    }
    
    for(int i=0;i<5;i++){
        if(score>topScoreHoles[i]){
            for(int j=4;j>i;j--){
                topScoreHoles[j]=topScoreHoles[j-1];
            }
            topScoreHoles[i]=score;
            break;
        }
    }
    [self saveProgress];
}

-(void) addScoreStars:(int)score{
    if(score<topScoreStars[4]){
        return;
    }
    for(int i=0;i<5;i++){
        if(score>topScoreStars[i]){
            for(int j=4;j>i;j--){
                topScoreStars[j]=topScoreStars[j-1];
            }
            topScoreStars[i]=score;
            break;
        }
    }
    [self saveProgress];
}
- (int *)getTopScoreStars {
    return topScoreStars;
}

- (int *)getTopScoreHoles {
    return topScoreHoles;
}

- (int *)getTopScore {
    return topScore;
}



@end
