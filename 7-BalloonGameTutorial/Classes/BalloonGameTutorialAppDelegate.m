//
//  BalloonGameTutorialAppDelegate.m
//  BalloonGameTutorial
//
//  Created by Johann Dowa of ManiacDev.com
//  Copyright Johann Dowa 2010. All rights reserved.
//
//  You may use this code within your own games.  In fact I encourage it, and if
//  you provide credit somewhere in your game to myself and ManiacDev.Com tell
//  me about it and I'll mention it on my ManiacDev.Com which receives thousands 
//  of daily visits.
// 
//  You may however not use this code or any portion for any use other than in
//  the development of iOS applications without my permission. 
//  (In other words you may not use it in any tutorials, books wikis etc. 
//  without asking me first)
//
//  This file was created automatically when creating a Sparrow project
//  I left this alone - Check the Game.m file to learn how the app was made.

#import "BalloonGameTutorialAppDelegate.h"
#import "Game.h" 

@implementation BalloonGameTutorialAppDelegate

@synthesize window;
@synthesize sparrowView;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Enable retina display support
	[SPStage setSupportHighResolutions:YES];
	
    SP_CREATE_POOL(pool);    
    
    Game *game = [[Game alloc] initWithWidth:320 height:480];        
    sparrowView.stage = game;
    [sparrowView start];
    [window makeKeyAndVisible];
    [game release];    
    
	[SPAudioEngine start];
	
    SP_RELEASE_POOL(pool);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    sparrowView.frameRate = 5;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    sparrowView.frameRate = 30;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [SPPoint purgePool];
    [SPRectangle purgePool];
    [SPMatrix purgePool];    
}

- (void)dealloc {
	[SPAudioEngine stop];
    [window release];
    [super dealloc];
}

@end
