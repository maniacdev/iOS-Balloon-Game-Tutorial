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
	[image addEventListener:@selector(onTouchBalloon:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
	[tween addEventListener:@selector(movementThroughTopOfScreen:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
}

-(void)onTouchBalloon:(SPTouchEvent*)event
{

	SPDisplayObject* currentBalloon = (SPDisplayObject*)[event target];
		
	[currentBalloon removeEventListener:@selector(onTouchBalloon:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
	
	
	score+=10;
	scoreTextField.text = [NSString stringWithFormat:@"Score: %d", score];
	[[SPSound soundWithContentsOfFile:@"balloonpop.caf"] play];
	
	[self.juggler removeTweensWithTarget:currentBalloon];
	
	SPTween *tween = [SPTween tweenWithTarget:currentBalloon time:0.35 transition:SP_TRANSITION_LINEAR];
	[tween animateProperty:@"scaleX" targetValue:0.75];
	[tween animateProperty:@"scaleY" targetValue:1.25];
	[self.juggler addObject:tween];
	
	tween = [SPTween tweenWithTarget:currentBalloon time:(480.0-currentBalloon.y)/480.0 transition:SP_TRANSITION_LINEAR];
	[tween animateProperty:@"y" targetValue:self.height+currentBalloon.height];
	[self.juggler addObject:tween];
	
	[tween addEventListener:@selector(balloonPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];

}

-(void)drawBalloons
{
	for(int i = 0; i < level; i++)
	{
			printf("executing");
		[self addBalloon];
	}
}

-(void)movementThroughTopOfScreen:(SPEvent*)event
{
	[self.juggler removeAllObjects];
}

-(void)balloonPopped:(SPEvent*)event
{	
	SPTween *animation = (SPTween*)[event target];

	[animation removeEventListener:@selector(balloonPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
	
	SPDisplayObject *currentBalloon = (SPDisplayObject*)[animation target];
	
	[playFieldSprite removeChild:currentBalloon];
	
	if(playFieldSprite.numChildren == 0)
	{
		level++;
		levelTextField.text = [NSString stringWithFormat:@"Level: %d", level];
		[self drawBalloons];
	}
	
}

@end

