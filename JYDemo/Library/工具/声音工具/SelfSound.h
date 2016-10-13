//
//  SelfSound.h
//  项目2
//
//  Created by rimi on 15/6/18.
//  Copyright (c) 2015年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SelfSound : NSObject
{
    SystemSoundID soundID;
}

-(id)initForPlayingVibrate;

-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type;

-(id)initForPlayingSoundEffectWith:(NSString *)filename;

-(void)play;//播放

-(void)deallocSound;

//-(void)endSound;
@end
