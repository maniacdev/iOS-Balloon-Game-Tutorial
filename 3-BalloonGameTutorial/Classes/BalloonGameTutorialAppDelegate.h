//
//  BalloonGameTutorialAppDelegate.h
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

#import <UIKit/UIKit.h>
#import "Sparrow.h" 

@interface BalloonGameTutorialAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    SPView *sparrowView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SPView *sparrowView;

@end
