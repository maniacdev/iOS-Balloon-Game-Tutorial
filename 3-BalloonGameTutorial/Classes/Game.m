//
//  Game.m
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

#import "Game.h" 

// 
@implementation Game


- (id)initWithWidth:(float)width height:(float)height 
{

    if (self = [super initWithWidth:width height:height]) 
	{
		SPImage *backgroundImage = [SPImage imageWithContentsOfFile:@"tutorialbackground.png"];
		[self addChild:backgroundImage];
		
		score = 0;
		level = 1;
		
		scoreTextField = [SPTextField textFieldWithText:[NSString stringWithFormat:@"Score: %d", score]];
		levelTextField = [SPTextField textFieldWithText:[NSString stringWithFormat:@"Level: %d", level]];
		
		scoreTextField.fontName = @"Marker Felt";
		scoreTextField.x = 160;
		scoreTextField.y = 7;
		scoreTextField.vAlign = SPVAlignTop;
		scoreTextField.hAlign = SPHAlignRight;
		scoreTextField.fontSize = 20;
		
		[self addChild:scoreTextField];
		
		levelTextField = [SPTextField textFieldWithText:[NSString stringWithFormat:@"Level: %d", level]];
		levelTextField.fontName = @"Marker Felt";
		levelTextField.x = 0;
		levelTextField.y = 7;
		levelTextField.vAlign = SPVAlignTop;
		levelTextField.fontSize = 20;
		
		[self addChild:levelTextField];
		
		SPSound *music = [SPSound soundWithContentsOfFile:@"music.caf"];
		SPSoundChannel *channel = [[music createChannel] retain];
		channel.loop = YES;
		channel.volume = 0.25;
		[channel play];
		
		balloonTextures = [NSMutableArray array];
		[balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"bluetutorial.png"]];
		[balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"greentutorial.png"]];
		[balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"indigotutorial.png"]];
		[balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"orangetutorial.png"]];
		[balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"redtutorial.png"]];
		[balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"violettutorial.png"]];
		[balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"yellowtutorial.png"]];
		[balloonTextures retain];
		
		playFieldSprite = [SPSprite sprite];
		[self addChild:playFieldSprite];
		
		[self addBalloon];
	}

	
	return self;
}

-(void)addBalloon
{
	SPImage *image = [SPImage imageWithTexture:[balloonTextures objectAtIndex:arc4random() % balloonTextures.count]];
	
	image.x = (arc4random() % (int)(self.width-image.width));
	image.y = self.height;
	
	[playFieldSprite addChild:image];
	
	SPTween *tween = [SPTween tweenWithTarget:image
										 time:(double)((arc4random() % 5) + 2)
								   transition:SP_TRANSITION_LINEAR];
	
	[tween animateProperty:@"x" targetValue:arc4random() % (int)(self.width-image.width)];
	[tween animateProperty:@"y" targetValue:-image.height];
	
	[self.juggler addObject:tween];
}
@end

