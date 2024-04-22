//
//  TopScore.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 7. 01. 24.
//

#import "TopScore.h"

#import "Retronator.PuttPuttGolf.h"
#import "Rectangle.h"

@implementation TopScore

- (void) initialize {
    [super initialize];
    
    float width =puttPuttGolf.graphicsDevice.viewport.width;
    float height =puttPuttGolf.graphicsDevice.viewport.height;
    // Calculate the top left point
 
    //declear color for text
    Color *textColor = [Color white];
    
    // Text
    title = [[Label alloc] initWithFont:retrotype text:@"Top Scores" position:[Vector2 vectorWithX:width/2 y:80]];
    title.horizontalAlign = HorizontalAlignCenter;
    [title setScaleUniform:[puttPuttGolf.scale titleFont]];
    title.color=textColor;
    [scene addItem:title];
    
    background.color=[Color gray];
    
    scoreArray = [[NSMutableArray<Label *> alloc] init];
    // Buttons
    
    int *topScore = [puttPuttGolf.progress getTopScore];
    
    Label *title =[[Label alloc] initWithFont:retrotype text:@"Personal Best" position:[Vector2 vectorWithX:width*3/10 y:200]];
    title.horizontalAlign = HorizontalAlignCenter;
    [title setScaleUniform:[puttPuttGolf.scale titleFont]];
    
    title.color=textColor;
    [scoreArray addObject:title];
    [scene addItem:title];
    
    for (int i = 0; i < 5; i++) {
        float scoreGap=[puttPuttGolf.scale scoreGap];
        NSString *scoreString = [NSString stringWithFormat:@" %d. Score: %d", i+1, topScore[i]];
        Label *lable =[[Label alloc] initWithFont:retrotype text:scoreString position:[Vector2 vectorWithX:width*3/10 y:320+i*scoreGap]];
        lable.horizontalAlign = HorizontalAlignCenter;
        [lable setScaleUniform:[puttPuttGolf.scale textScore]];
        lable.color=textColor;
        [scoreArray addObject:lable];
        [scene addItem:lable];
    }
    
    title =[[Label alloc] initWithFont:retrotype text:@"Global" position:[Vector2 vectorWithX:width*7/10 y:200]];
    title.horizontalAlign = HorizontalAlignCenter;
    [title  setScaleUniform:[puttPuttGolf.scale titleFont]];
    title.color=textColor;
    [scoreArray addObject:title];
    [scene addItem:title];
    
    [GKLeaderboard loadLeaderboardsWithIDs:@[@"top_scores_all"] completionHandler:^(NSArray<GKLeaderboard *> * _Nullable leaderboards, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error loading leaderboards: %@", error);
        } else {
            // Use the loaded leaderboards
            for (GKLeaderboard *leaderboard in leaderboards) {
                NSLog(@"Loaded leaderboard with ID: %@",leaderboards );
                // Get the players for whom you want to load entries
                NSArray<GKPlayer *> *players = @[[GKLocalPlayer localPlayer]]; // Replace with your players
                // Call the method
                [leaderboard loadEntriesForPlayers:players timeScope:GKLeaderboardTimeScopeAllTime completionHandler:^(GKLeaderboardEntry * _Nullable localPlayerEntry, NSArray<GKLeaderboardEntry *> * _Nullable entries, NSError * _Nullable error) {
                    if (error) {
                        NSLog(@"Error loading entries: %@", error.localizedDescription);
                    } else {
                        NSLog(@"Loaded entries successfully");
                        // Use the loaded entries
                        int i=0;
                        for (GKLeaderboardEntry *entry in entries) {
                            NSLog(@"Player: %@, Score: %li", entry.player.displayName, entry.score);
                            
                            NSString *scoreString = [NSString stringWithFormat:@" %d. %@: %li", i+1,entry.player.displayName, entry.score];
                            Label *lable =[[Label alloc] initWithFont:retrotype text:scoreString position:[Vector2 vectorWithX:width*7/10 y:320+i*100]];
                            lable.horizontalAlign = HorizontalAlignCenter;
                            
                            lable.color=textColor;
                            [lable setScaleUniform:[puttPuttGolf.scale textScore]];
                            
                            [scoreArray addObject:lable];
                            [scene addItem:lable];
                            
                            i++;
                            if(i==5)break;
                        }
                    }
                }];
            }
        }
    }];
    
    
    
    float bWindth=600;
    float bHeight=bWindth/4;
    float scale=bWindth/buttonBackground.width;
    back= [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:width/2-bWindth/2 y:height*4/5 width:bWindth height:bHeight]
                                 background:buttonBackground font:retrotype text:@"Back"];
    
    
    [back.backgroundImage setScaleUniform:scale];
    [scene addItem:back];
    
    
    


}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    
}

- (void) dealloc
{
    [background release];
    
    [title release];

    
    [super dealloc];
}

@end
