//
//  SelfSound.m
//  项目2
//
//  Created by rimi on 15/6/18.
//  Copyright (c) 2015年 rimi. All rights reserved.
//

#import "SelfSound.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation SelfSound
-(id)initForPlayingVibrate
{
    self = [super init];
    if (self) {
        soundID = kSystemSoundID_Vibrate;
    }
    return self;
}


//sysetem
-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type
{
    self = [super init];
    if (self) {
        //NSLog(@"----%@++++%@",resourceName,type);
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit" ] pathForResource:@"Tock" ofType:@"aiff"];
//        NSLog(@"sss%@",path);
//        NSString *path = [NSString stringWithFormat:@"/Users/rimi/Desktop/项目2第一次整合/项目2tap.aif"];
        if (path) {
            NSLog(@"aaa%@",path);
            SystemSoundID theSoundID;
            OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            if (error == kAudioServicesNoError) {
                NSLog(@"system");
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        }
        

        
    }
    return self;
}

//自定义声音
-(id)initForPlayingSoundEffectWith:(NSString *)filename
{
    NSLog(@"hh");
    self = [super init];
    if (self) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
//        NSData * data = [NSData dataWithContentsOfURL:fileURL];
        if (fileURL != nil)
        {
           
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError){
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound");
            }
        }
    }
    return self;
    
    }

-(void)play
{
   
    AudioServicesPlaySystemSound(soundID);
}

-(void)deallocSound
{
    AudioServicesDisposeSystemSoundID(soundID);
}
@end
