//
//  ViewController.m
//  Recemendo
//
//  Created by Jay Deuskar on 10/20/12.
//  Copyright (c) 2012 Jay Deuskar. All rights reserved.
//


#import "ViewController.h"
#import "JSON.h"
#import "Settings.h"

@interface ViewController ()
- (void)handleNowPlayingItemChanged:(id)notification;
- (void)handleExternalVolumeChanged:(id)notification;
@end


@implementation ViewController

@synthesize musicPlayer;
@synthesize songLabel;
@synthesize artistLabel;
@synthesize albumLabel;
@synthesize artworkImageView;
@synthesize textView;
@synthesize responseData;
@synthesize loading;
@synthesize loadingLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    
    [musicPlayer setShuffleMode: MPMusicShuffleModeSongs];
    [musicPlayer setRepeatMode:MPMusicRepeatModeDefault];
    
    // Register for music player notifications
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(handleNowPlayingItemChanged:)
                               name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                             object:self.musicPlayer];
        [self.musicPlayer beginGeneratingPlaybackNotifications];
    
    [suggFlow setScrollEnabled:YES];
    suggFlow = [[UIScrollView alloc] initWithFrame:CGRectMake(9, 200, 300, 215)];
    suggFlow.contentSize = CGSizeMake(1525, suggFlow.frame.size.height);
    [suggFlow setCanCancelContentTouches:NO];
    suggFlow.alwaysBounceHorizontal = YES;
    
    
    [back setBackgroundImage:[UIImage imageNamed:@"backNor.PNG"] forState:UIControlStateNormal];
    [back setBackgroundImage:[UIImage imageNamed:@"backPress.PNG"] forState:UIControlStateHighlighted];
    
    [forward setBackgroundImage:[UIImage imageNamed:@"forwardNor.PNG"] forState:UIControlStateNormal];
    [forward setBackgroundImage:[UIImage imageNamed:@"forwardPress.PNG"] forState:UIControlStateHighlighted];
    
    [play setBackgroundImage:[UIImage imageNamed:@"playNor.PNG"] forState:UIControlStateNormal];
    [play setBackgroundImage:[UIImage imageNamed:@"playPress.PNG"] forState:UIControlStateHighlighted];
    
    [pause setBackgroundImage:[UIImage imageNamed:@"pauseNor.PNG"] forState:UIControlStateNormal];
    [pause setBackgroundImage:[UIImage imageNamed:@"pausePress.PNG"] forState:UIControlStateHighlighted];

    if (self.musicPlayer.playbackState==MPMusicPlaybackStateStopped || self.musicPlayer.playbackState==MPMusicPlaybackStatePaused)
    {
        play.hidden=NO;
        pause.hidden=YES;
    }
    else
    {
        play.hidden=YES;
        pause.hidden=NO;
    }
    
    
    //SUGGESTION IMAGES
   
    sugg1=[[UIImageView alloc] initWithFrame:CGRectMake(25, 22, 125, 125)];
    [suggFlow addSubview:sugg1];
    
    sn1=[[UILabel alloc] initWithFrame:CGRectMake(25, 164, 125, 20)];
    sn1.textColor=[UIColor whiteColor];
    [sn1 setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
    sn1.text=@"";
    sn1.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:sn1];
    
    an1=[[UILabel alloc] initWithFrame:CGRectMake(25, 184, 125, 20)];
    an1.textColor=[UIColor whiteColor];
    [an1 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    an1.text=@"";
    an1.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:an1];
    
    UIButton* butt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    butt1.tag = 102;
    butt1.frame = CGRectMake(25, 22, 125, 125);
    [butt1 addTarget:self action:@selector(butt1Click) forControlEvents:UIControlEventTouchUpInside];
    [suggFlow addSubview:butt1];

    
    sugg2=[[UIImageView alloc] initWithFrame:CGRectMake(175, 22, 125, 125)];
    [suggFlow addSubview:sugg2];
    
    sn2=[[UILabel alloc] initWithFrame:CGRectMake(175, 164, 125, 20)];
    sn2.textColor=[UIColor whiteColor];
    [sn2 setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
    sn2.text=@"";
    sn2.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:sn2];
    
    an2=[[UILabel alloc] initWithFrame:CGRectMake(175, 184, 125, 20)];
    an2.textColor=[UIColor whiteColor];
    [an2 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    an2.text=@"";
    an2.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:an2];
    
    UIButton* butt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    butt2.tag = 103;
    butt2.frame = CGRectMake(175, 22, 125, 125);
    [butt2 addTarget:self action:@selector(butt2Click) forControlEvents:UIControlEventTouchUpInside];
    [suggFlow addSubview:butt2];
    
    sugg3=[[UIImageView alloc] initWithFrame:CGRectMake(325, 22, 125, 125)];
    [suggFlow addSubview:sugg3];
    
    sn3=[[UILabel alloc] initWithFrame:CGRectMake(325, 164, 125, 20)];
    sn3.textColor=[UIColor whiteColor];
    [sn3 setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
    sn3.text=@"";
    sn3.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:sn3];
    
    an3=[[UILabel alloc] initWithFrame:CGRectMake(325, 184, 125, 20)];
    an3.textColor=[UIColor whiteColor];
    [an3 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    an3.text=@"";
    an3.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:an3];
    
    UIButton* butt3 = [UIButton buttonWithType:UIButtonTypeCustom];
    butt3.tag = 103;
    butt3.frame = CGRectMake(325, 22, 125, 125);
    [butt3 addTarget:self action:@selector(butt3Click) forControlEvents:UIControlEventTouchUpInside];
    [suggFlow addSubview:butt3];
    
    sugg4=[[UIImageView alloc] initWithFrame:CGRectMake(475, 22, 125, 125)];
    [suggFlow addSubview:sugg4];
    
    sn4=[[UILabel alloc] initWithFrame:CGRectMake(475, 164, 125, 20)];
    sn4.textColor=[UIColor whiteColor];
    [sn4 setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
    sn4.text=@"";
    sn4.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:sn4];
    
    an4=[[UILabel alloc] initWithFrame:CGRectMake(475, 184, 125, 20)];
    an4.textColor=[UIColor whiteColor];
    [an4 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    an4.text=@"";
    an4.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:an4];
    
    UIButton* butt4 = [UIButton buttonWithType:UIButtonTypeCustom];
    butt4.tag = 104;
    butt4.frame = CGRectMake(475, 22, 125, 125);
    [butt4 addTarget:self action:@selector(butt4Click) forControlEvents:UIControlEventTouchUpInside];
    [suggFlow addSubview:butt4];
    
    sugg5=[[UIImageView alloc] initWithFrame:CGRectMake(625, 22, 125, 125)];
    [suggFlow addSubview:sugg5];
    
    sn5=[[UILabel alloc] initWithFrame:CGRectMake(625, 164, 125, 20)];
    sn5.textColor=[UIColor whiteColor];
    [sn5 setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
    sn5.text=@"";
    sn5.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:sn5];
    
    an5=[[UILabel alloc] initWithFrame:CGRectMake(625, 184, 125, 20)];
    an5.textColor=[UIColor whiteColor];
    [an5 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    an5.text=@"";
    an5.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:an5];
    
    UIButton* butt5 = [UIButton buttonWithType:UIButtonTypeCustom];
    butt5.tag = 105;
    butt5.frame = CGRectMake(625, 22, 125, 125);
    [butt5 addTarget:self action:@selector(butt5Click) forControlEvents:UIControlEventTouchUpInside];
    [suggFlow addSubview:butt5];
    
    sugg6=[[UIImageView alloc] initWithFrame:CGRectMake(775, 22, 125, 125)];
    [suggFlow addSubview:sugg6];
    
    sn6=[[UILabel alloc] initWithFrame:CGRectMake(775, 164, 125, 20)];
    sn6.textColor=[UIColor whiteColor];
    [sn6 setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
    sn6.text=@"";
    sn6.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:sn6];
    
    an6=[[UILabel alloc] initWithFrame:CGRectMake(775, 184, 125, 20)];
    an6.textColor=[UIColor whiteColor];
    [an6 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    an6.text=@"";
    an6.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:an6];
    
    UIButton* butt6 = [UIButton buttonWithType:UIButtonTypeCustom];
    butt6.tag = 106;
    butt6.frame = CGRectMake(775, 22, 125, 125);
    [butt6 addTarget:self action:@selector(butt6Click) forControlEvents:UIControlEventTouchUpInside];
    [suggFlow addSubview:butt6];
    
    sugg7=[[UIImageView alloc] initWithFrame:CGRectMake(925, 22, 125, 125)];
    [suggFlow addSubview:sugg7];
    
    sn7=[[UILabel alloc] initWithFrame:CGRectMake(925, 164, 125, 20)];
    sn7.textColor=[UIColor whiteColor];
    [sn7 setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
    sn7.text=@"";
    sn7.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:sn7];
    
    an7=[[UILabel alloc] initWithFrame:CGRectMake(925, 184, 125, 20)];
    an7.textColor=[UIColor whiteColor];
    [an7 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    an7.text=@"";
    an7.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:an7];
    
    UIButton* butt7 = [UIButton buttonWithType:UIButtonTypeCustom];
    butt7.tag = 107;
    butt7.frame = CGRectMake(925, 22, 125, 125);
    [butt7 addTarget:self action:@selector(butt7Click) forControlEvents:UIControlEventTouchUpInside];
    [suggFlow addSubview:butt7];
    
    sugg8=[[UIImageView alloc] initWithFrame:CGRectMake(1075, 22, 125, 125)];
    [suggFlow addSubview:sugg8];
    
    sn8=[[UILabel alloc] initWithFrame:CGRectMake(1075, 164, 125, 20)];
    sn8.textColor=[UIColor whiteColor];
    [sn8 setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
    sn8.text=@"";
    sn8.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:sn8];
    
    an8=[[UILabel alloc] initWithFrame:CGRectMake(1075, 184, 125, 20)];
    an8.textColor=[UIColor whiteColor];
    [an8 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    an8.text=@"";
    an8.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:an8];
    
    UIButton* butt8 = [UIButton buttonWithType:UIButtonTypeCustom];
    butt8.tag = 108;
    butt8.frame = CGRectMake(1075, 22, 125, 125);
    [butt8 addTarget:self action:@selector(butt8Click) forControlEvents:UIControlEventTouchUpInside];
    [suggFlow addSubview:butt8];
    
    sugg9=[[UIImageView alloc] initWithFrame:CGRectMake(1225, 22, 125, 125)];
    [suggFlow addSubview:sugg9];
    
    sn9=[[UILabel alloc] initWithFrame:CGRectMake(1225, 164, 125, 20)];
    sn9.textColor=[UIColor whiteColor];
    [sn9 setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
    sn9.text=@"";
    sn9.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:sn9];
    
    an9=[[UILabel alloc] initWithFrame:CGRectMake(1225, 184, 125, 20)];
    an9.textColor=[UIColor whiteColor];
    [an9 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    an9.text=@"";
    an9.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:an9];
    
    UIButton* butt9 = [UIButton buttonWithType:UIButtonTypeCustom];
    butt9.tag = 109;
    butt9.frame = CGRectMake(1225, 22, 125, 125);
    [butt9 addTarget:self action:@selector(butt9Click) forControlEvents:UIControlEventTouchUpInside];
    [suggFlow addSubview:butt9];
    
    sugg10=[[UIImageView alloc] initWithFrame:CGRectMake(1375, 22, 125, 125)];
    [suggFlow addSubview:sugg10];
    
    sn10=[[UILabel alloc] initWithFrame:CGRectMake(1375, 164, 125, 20)];
    sn10.textColor=[UIColor whiteColor];
    [sn10 setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
    sn10.text=@"";
    sn10.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:sn10];
    
    an10=[[UILabel alloc] initWithFrame:CGRectMake(1375, 184, 125, 20)];
    an10.textColor=[UIColor whiteColor];
    [an10 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    an10.text=@"";
    an10.backgroundColor=[UIColor clearColor];
    [suggFlow addSubview:an10];
    
    UIButton* butt10 = [UIButton buttonWithType:UIButtonTypeCustom];
    butt10.tag = 110;
    butt10.frame = CGRectMake(1375, 22, 125, 125);
    [butt10 addTarget:self action:@selector(butt10Click) forControlEvents:UIControlEventTouchUpInside];
    [suggFlow addSubview:butt10];

    [self.view addSubview:suggFlow];
    
    //GESTURE RECOGNIZER
    
    UISwipeGestureRecognizer* right=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(forwardSong:)];
    right.numberOfTouchesRequired=1;
    right.direction=UISwipeGestureRecognizerDirectionRight;
    [view1 addGestureRecognizer:right];
    
    
    UISwipeGestureRecognizer* left=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSong:)];
    left.numberOfTouchesRequired=1;
    left.direction=UISwipeGestureRecognizerDirectionLeft;
    [view1 addGestureRecognizer:left];
    
    
    actionButtonsSheet = [[RVActionButtonsSheet alloc] initWithDelegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:[NSArray arrayWithObjects:@"iTunes", @"Youtube", nil]
                                                  otherButtonImageNames:[NSArray arrayWithObjects:@"iconiTunes.png",@"iconYoutube.PNG",nil]
                                                                 inView:self.view];
    

}


-(IBAction)pickASong
{
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = YES; // this is the default
    [self presentModalViewController:mediaPicker animated:YES];
    [mediaPicker release];
}


-(void)bringToFront
{
    [self.view bringSubviewToFront:suggFlow];
}

-(void)butt1Click
{
    [actionButtonsSheet showInView:self.view];
    
    NSString* itunes1=@"http://itunes.com/";
    NSString* artistName=[an1.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* songName=[sn1.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* finaliTunes=[[[itunes1 stringByAppendingString:artistName] stringByAppendingString:@"/"] stringByAppendingString:songName];
    finaliTunes=[finaliTunes lowercaseString];
    NSLog(finaliTunes);
    
    NSString* artistName1=[an1.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* songName1=[sn1.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* youtube1=[[[@"http://www.youtube.com/results?search_query=" stringByAppendingString:artistName1] stringByAppendingString:@"+"] stringByAppendingString:songName1];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:finaliTunes forKey:@"iTunesKey"];
    [defaults setObject:youtube1 forKey:@"YoutubeKey"];
	[defaults synchronize];

    
    
}

-(void)butt2Click
{
    [actionButtonsSheet showInView:self.view];
    NSString* itunes1=@"http://itunes.com/";
    NSString* artistName=[an2.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* songName=[sn2.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* finaliTunes=[[[itunes1 stringByAppendingString:artistName] stringByAppendingString:@"/"] stringByAppendingString:songName];
    finaliTunes=[finaliTunes lowercaseString];
    NSLog(finaliTunes);
    
    NSString* artistName1=[an2.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* songName1=[sn2.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* youtube1=[[[@"http://www.youtube.com/results?search_query=" stringByAppendingString:artistName1] stringByAppendingString:@"+"] stringByAppendingString:songName1];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:finaliTunes forKey:@"iTunesKey"];
    [defaults setObject:youtube1 forKey:@"YoutubeKey"];
	[defaults synchronize];
}

-(void)butt3Click
{
    [actionButtonsSheet showInView:self.view];
    NSString* itunes1=@"http://itunes.com/";
    NSString* artistName=[an3.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* songName=[sn3.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* finaliTunes=[[[itunes1 stringByAppendingString:artistName] stringByAppendingString:@"/"] stringByAppendingString:songName];
    finaliTunes=[finaliTunes lowercaseString];
    NSLog(finaliTunes);
    
    NSString* artistName1=[an3.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* songName1=[sn3.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* youtube1=[[[@"http://www.youtube.com/results?search_query=" stringByAppendingString:artistName1] stringByAppendingString:@"+"] stringByAppendingString:songName1];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:finaliTunes forKey:@"iTunesKey"];
    [defaults setObject:youtube1 forKey:@"YoutubeKey"];
	[defaults synchronize];
}
-(void)butt4Click
{
    [actionButtonsSheet showInView:self.view];
    NSString* itunes1=@"http://itunes.com/";
    NSString* artistName=[an4.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* songName=[sn4.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* finaliTunes=[[[itunes1 stringByAppendingString:artistName] stringByAppendingString:@"/"] stringByAppendingString:songName];
    finaliTunes=[finaliTunes lowercaseString];
    NSLog(finaliTunes);
    
    NSString* artistName1=[an4.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* songName1=[sn4.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* youtube1=[[[@"http://www.youtube.com/results?search_query=" stringByAppendingString:artistName1] stringByAppendingString:@"+"] stringByAppendingString:songName1];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:finaliTunes forKey:@"iTunesKey"];
    [defaults setObject:youtube1 forKey:@"YoutubeKey"];
	[defaults synchronize];
}

-(void)butt5Click
{
    [actionButtonsSheet showInView:self.view];
    NSString* itunes1=@"http://itunes.com/";
    NSString* artistName=[an5.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* songName=[sn5.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* finaliTunes=[[[itunes1 stringByAppendingString:artistName] stringByAppendingString:@"/"] stringByAppendingString:songName];
    finaliTunes=[finaliTunes lowercaseString];
    NSLog(finaliTunes);
    
    NSString* artistName1=[an5.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* songName1=[sn5.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* youtube1=[[[@"http://www.youtube.com/results?search_query=" stringByAppendingString:artistName1] stringByAppendingString:@"+"] stringByAppendingString:songName1];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:finaliTunes forKey:@"iTunesKey"];
    [defaults setObject:youtube1 forKey:@"YoutubeKey"];
	[defaults synchronize];
}

-(void)butt6Click
{
    [actionButtonsSheet showInView:self.view];
    NSString* itunes1=@"http://itunes.com/";
    NSString* artistName=[an6.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* songName=[sn6.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* finaliTunes=[[[itunes1 stringByAppendingString:artistName] stringByAppendingString:@"/"] stringByAppendingString:songName];
    finaliTunes=[finaliTunes lowercaseString];
    NSLog(finaliTunes);
    
    NSString* artistName1=[an6.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* songName1=[sn6.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* youtube1=[[[@"http://www.youtube.com/results?search_query=" stringByAppendingString:artistName1] stringByAppendingString:@"+"] stringByAppendingString:songName1];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:finaliTunes forKey:@"iTunesKey"];
    [defaults setObject:youtube1 forKey:@"YoutubeKey"];
	[defaults synchronize];
}

-(void)butt7Click
{
    [actionButtonsSheet showInView:self.view];
    NSString* itunes1=@"http://itunes.com/";
    NSString* artistName=[an7.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* songName=[sn7.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* finaliTunes=[[[itunes1 stringByAppendingString:artistName] stringByAppendingString:@"/"] stringByAppendingString:songName];
    finaliTunes=[finaliTunes lowercaseString];
    NSLog(finaliTunes);
    
    NSString* artistName1=[an7.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* songName1=[sn7.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* youtube1=[[[@"http://www.youtube.com/results?search_query=" stringByAppendingString:artistName1] stringByAppendingString:@"+"] stringByAppendingString:songName1];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:finaliTunes forKey:@"iTunesKey"];
    [defaults setObject:youtube1 forKey:@"YoutubeKey"];
	[defaults synchronize];
}
-(void)butt8Click
{
    [actionButtonsSheet showInView:self.view];
    NSString* itunes1=@"http://itunes.com/";
    NSString* artistName=[an8.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* songName=[sn8.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* finaliTunes=[[[itunes1 stringByAppendingString:artistName] stringByAppendingString:@"/"] stringByAppendingString:songName];
    finaliTunes=[finaliTunes lowercaseString];
    NSLog(finaliTunes);
    
    NSString* artistName1=[an8.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* songName1=[sn8.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* youtube1=[[[@"http://www.youtube.com/results?search_query=" stringByAppendingString:artistName1] stringByAppendingString:@"+"] stringByAppendingString:songName1];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:finaliTunes forKey:@"iTunesKey"];
    [defaults setObject:youtube1 forKey:@"YoutubeKey"];
	[defaults synchronize];
}
-(void)butt9Click
{
    [actionButtonsSheet showInView:self.view];
    NSString* itunes1=@"http://itunes.com/";
    NSString* artistName=[an9.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* songName=[sn9.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* finaliTunes=[[[itunes1 stringByAppendingString:artistName] stringByAppendingString:@"/"] stringByAppendingString:songName];
    finaliTunes=[finaliTunes lowercaseString];
    NSLog(finaliTunes);
    
    NSString* artistName1=[an9.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* songName1=[sn9.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* youtube1=[[[@"http://www.youtube.com/results?search_query=" stringByAppendingString:artistName1] stringByAppendingString:@"+"] stringByAppendingString:songName1];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:finaliTunes forKey:@"iTunesKey"];
    [defaults setObject:youtube1 forKey:@"YoutubeKey"];
	[defaults synchronize];
}
-(void)butt10Click
{
    [actionButtonsSheet showInView:self.view];
    NSString* itunes1=@"http://itunes.com/";
    NSString* artistName=[an10.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* songName=[sn10.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* finaliTunes=[[[itunes1 stringByAppendingString:artistName] stringByAppendingString:@"/"] stringByAppendingString:songName];
    finaliTunes=[finaliTunes lowercaseString];
    NSLog(finaliTunes);
    
    NSString* artistName1=[an10.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* songName1=[sn10.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* youtube1=[[[@"http://www.youtube.com/results?search_query=" stringByAppendingString:artistName1] stringByAppendingString:@"+"] stringByAppendingString:songName1];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:finaliTunes forKey:@"iTunesKey"];
    [defaults setObject:youtube1 forKey:@"YoutubeKey"];
	[defaults synchronize];
}



-(IBAction)backSongButton
{
    [self.musicPlayer skipToPreviousItem];
    
}
-(IBAction)forwardSongButton
{
    [self.musicPlayer skipToNextItem];

}


-(IBAction)backSong:(UIGestureRecognizer *)sender
{
    [self.musicPlayer skipToPreviousItem];

}



-(IBAction)play_pause_song
{
    MPMusicPlaybackState playbackState = self.musicPlayer.playbackState;

    if (playbackState == MPMusicPlaybackStateStopped || playbackState == MPMusicPlaybackStatePaused)
    {
        [self.musicPlayer play];
        play.hidden=YES;
        pause.hidden=NO;
    }
    else
    {
        
        [self.musicPlayer pause];
        play.hidden=NO;
        pause.hidden=YES;
    }
    
}



-(IBAction)forwardSong:(UIGestureRecognizer *)sender
{
    [self.musicPlayer skipToNextItem];

}


-(IBAction)goToSettings
{
    Settings *set= [[Settings alloc] initWithNibName:@"Settings" bundle:nil];
	set.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self presentModalViewController:set animated:YES];
    
}

- (void)viewDidUnload {
    // Stop music player notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                                  object:self.musicPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                                  object:self.musicPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMusicPlayerControllerVolumeDidChangeNotification
                                                  object:self.musicPlayer];
    [self.musicPlayer endGeneratingPlaybackNotifications];
    
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    self.musicPlayer = nil;
    self.songLabel = nil;
    self.artistLabel = nil;
    self.albumLabel = nil;
    self.artworkImageView = nil;
}

- (void)dealloc {
    [musicPlayer release];
    [songLabel release];
    [artistLabel release];
    [albumLabel release];
    [artworkImageView release];
    [super dealloc];
}


-(IBAction)getReccomendations

{
    
    loading.alpha=1.0;
    wait.alpha=1.0;
    errorMessage.hidden=YES;
    suggFlow.hidden=NO;
    [loading startAnimating];
    suggFlow.alpha=0.0;
    
  
    MPMediaItem *currentItem = self.musicPlayer.nowPlayingItem;
    
    // Display the artist, album, and  for the now-playing media item.
    // These are all UILabels.

    
    NSMutableString* first=[@"http://ws.audioscrobbler.com/2.0/?method=track.getsimilar&artist=" mutableCopy];
    NSMutableString* artistName=[[[currentItem valueForProperty:MPMediaItemPropertyAlbumArtist] stringByReplacingOccurrencesOfString:@" " withString:@"+"] mutableCopy];
    NSMutableString* middle=[@"&track=" mutableCopy];
    NSMutableString* songName=[[[currentItem valueForProperty:MPMediaItemPropertyTitle] stringByReplacingOccurrencesOfString:@" " withString:@"+"]mutableCopy];
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"\\(.+?\\)"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:NULL];
    
    [regex replaceMatchesInString:songName
                          options:0
                            range:NSMakeRange(0, [songName length])
                     withTemplate:@""];
    NSMutableString* final=[@"&api_key=e3f53f2f2896b44ff158a586b8ee15c7&format=json" mutableCopy];
    
    NSMutableString* finalURL=[[[[[first stringByAppendingString:artistName] stringByAppendingString:middle] stringByAppendingString:songName] stringByAppendingString:final] mutableCopy];
   
    
    self.responseData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:finalURL]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    NSLog(finalURL);
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[connection release];
	self.responseData = nil;
    errorMessage.text=@"There is no connection to the internet. Please check your connection and try again.";
    errorMessage.hidden=NO;
    suggFlow.hidden=YES;
    loading.alpha=0.0;
    wait.alpha=0.0;
    suggFlow.alpha=1.0;
}



#pragma mark -
#pragma mark Process loan data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [connection release];

    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          options:kNilOptions
                          error:&error];
    
    
        
    NSArray* songList = [[json objectForKey:@"similartracks"] objectForKey:@"track"]; //2

    
    loading.alpha=0.0;
    wait.alpha=0.0;
    suggFlow.alpha=1.0;
    
    if([songList isKindOfClass:[NSArray class]])
    {
        //Now we're sure it's an array
      
    NSLog(@"track: %@", songList); //3
        
        if ([songList count]>9) {
      
    NSDictionary* song1 = [songList objectAtIndex:0];
    
    NSString* song1Name= [song1 objectForKey:@"name"];
    NSString* song1Artist= [[song1 objectForKey:@"artist"] objectForKey:@"name"];
            
    NSArray* array1=[song1 objectForKey:@"image"];
    NSDictionary* dic1=[array1 objectAtIndex:3];
    NSString* finalURL1=[dic1 objectForKey:@"#text"];
    NSURL* newURL1=[NSURL URLWithString:finalURL1];
    UIImage* album1=[UIImage imageWithData:[NSData dataWithContentsOfURL:newURL1]];

    
    NSDictionary* song2 = [songList objectAtIndex:1];
    
    NSString* song2Name= [song2 objectForKey:@"name"];
    NSString* song2Artist= [[song2 objectForKey:@"artist"] objectForKey:@"name"];
            
    NSArray* array2=[song2 objectForKey:@"image"];
    NSDictionary* dic2=[array2 objectAtIndex:3];
    NSString* finalURL2=[dic2 objectForKey:@"#text"];
    NSURL* newURL2=[NSURL URLWithString:finalURL2];
    UIImage* album2=[UIImage imageWithData:[NSData dataWithContentsOfURL:newURL2]];
    
    NSDictionary* song3 = [songList objectAtIndex:2];
    
    NSString* song3Name= [song3 objectForKey:@"name"];
    NSString* song3Artist= [[song3 objectForKey:@"artist"] objectForKey:@"name"];
    
    NSArray* array3=[song3 objectForKey:@"image"];
    NSDictionary* dic3=[array3 objectAtIndex:3];
    NSString* finalURL3=[dic3 objectForKey:@"#text"];
    NSURL* newURL3=[NSURL URLWithString:finalURL3];
    UIImage* album3=[UIImage imageWithData:[NSData dataWithContentsOfURL:newURL3]];
            
    NSDictionary* song4 = [songList objectAtIndex:3];
    
    NSString* song4Name= [song4 objectForKey:@"name"];
    NSString* song4Artist= [[song4 objectForKey:@"artist"] objectForKey:@"name"];
            
    NSArray* array4=[song4 objectForKey:@"image"];
    NSDictionary* dic4=[array4 objectAtIndex:3];
    NSString* finalURL4=[dic4 objectForKey:@"#text"];
    NSURL* newURL4=[NSURL URLWithString:finalURL4];
    UIImage* album4=[UIImage imageWithData:[NSData dataWithContentsOfURL:newURL4]];

    
    NSDictionary* song5 = [songList objectAtIndex:4];
    
    NSString* song5Name= [song5 objectForKey:@"name"];
    NSString* song5Artist= [[song5 objectForKey:@"artist"] objectForKey:@"name"];
        
    NSArray* array5=[song5 objectForKey:@"image"];
    NSDictionary* dic5=[array5 objectAtIndex:3];
    NSString* finalURL5=[dic5 objectForKey:@"#text"];
    NSURL* newURL5=[NSURL URLWithString:finalURL5];
    UIImage* album5=[UIImage imageWithData:[NSData dataWithContentsOfURL:newURL5]];

            
    NSDictionary* song6 = [songList objectAtIndex:5];
            
    NSString* song6Name= [song6 objectForKey:@"name"];
    NSString* song6Artist= [[song6 objectForKey:@"artist"] objectForKey:@"name"];
            
    NSArray* array6=[song6 objectForKey:@"image"];
    NSDictionary* dic6=[array6 objectAtIndex:3];
    NSString* finalURL6=[dic6 objectForKey:@"#text"];
    NSURL* newURL6=[NSURL URLWithString:finalURL6];
    UIImage* album6=[UIImage imageWithData:[NSData dataWithContentsOfURL:newURL6]];
            
    NSDictionary* song7 = [songList objectAtIndex:6];
           
    NSString* song7Name= [song7 objectForKey:@"name"];
    NSString* song7Artist= [[song7 objectForKey:@"artist"] objectForKey:@"name"];
            
    NSArray* array7=[song7 objectForKey:@"image"];
    NSDictionary* dic7=[array7 objectAtIndex:3];
    NSString* finalURL7=[dic7 objectForKey:@"#text"];
    NSURL* newURL7=[NSURL URLWithString:finalURL7];
    UIImage* album7=[UIImage imageWithData:[NSData dataWithContentsOfURL:newURL7]];

    NSDictionary* song8 = [songList objectAtIndex:7];
            
    NSString* song8Name= [song8 objectForKey:@"name"];
    NSString* song8Artist= [[song8 objectForKey:@"artist"] objectForKey:@"name"];
            
    NSArray* array8=[song8 objectForKey:@"image"];
    NSDictionary* dic8=[array8 objectAtIndex:3];
    NSString* finalURL8=[dic8 objectForKey:@"#text"];
    NSURL* newURL8=[NSURL URLWithString:finalURL8];
    UIImage* album8=[UIImage imageWithData:[NSData dataWithContentsOfURL:newURL8]];
    
    NSDictionary* song9 = [songList objectAtIndex:8];
            
    NSString* song9Name= [song9 objectForKey:@"name"];
    NSString* song9Artist= [[song9 objectForKey:@"artist"] objectForKey:@"name"];
            
    NSArray* array9=[song9 objectForKey:@"image"];
    NSDictionary* dic9=[array9 objectAtIndex:3];
    NSString* finalURL9=[dic9 objectForKey:@"#text"];
    NSURL* newURL9=[NSURL URLWithString:finalURL9];
    UIImage* album9=[UIImage imageWithData:[NSData dataWithContentsOfURL:newURL9]];
            
    NSDictionary* song10 = [songList objectAtIndex:9];
        
    NSString* song10Name= [song10 objectForKey:@"name"];
    NSString* song10Artist= [[song10 objectForKey:@"artist"] objectForKey:@"name"];
            
    NSArray* array10=[song10 objectForKey:@"image"];
    NSDictionary* dic10=[array10 objectAtIndex:3];
    NSString* finalURL10=[dic10 objectForKey:@"#text"];
    NSURL* newURL10=[NSURL URLWithString:finalURL10];
    UIImage* album10=[UIImage imageWithData:[NSData dataWithContentsOfURL:newURL10]];
   
            
            
            
            if (album1==nil) {
                sugg1.image=[UIImage imageNamed:@"defaultAlbum.png"];
            }
            else
            {
            sugg1.image=album1;
            }
            sn1.text=song1Name;
            an1.text=song1Artist;
   
            if (album2==nil) {
                 sugg2.image=[UIImage imageNamed:@"defaultAlbum.png"];
            }
            else
            {
                sugg2.image=album2;
            }
            sn2.text=song2Name;
            an2.text=song2Artist;
    
    
            if (album3==nil) {
                 sugg3.image=[UIImage imageNamed:@"defaultAlbum.png"];
            }
            else
            {
                sugg3.image=album3;
            }
            sn3.text=song3Name;
            an3.text=song3Artist;
            
            if (album4==nil) {
                 sugg4.image=[UIImage imageNamed:@"defaultAlbum.png"];
            }
            else
            {
                sugg4.image=album4;
            }
            sn4.text=song4Name;
            an4.text=song4Artist;
    
            if (album5==nil) {
                 sugg5.image=[UIImage imageNamed:@"defaultAlbum.png"];
            }
            else
            {
                sugg5.image=album5;
            }
            sn5.text=song5Name;
            an5.text=song5Artist;
            
            if (album6==nil) {
                 sugg6.image=[UIImage imageNamed:@"defaultAlbum.png"];
            }
            else
            {
                sugg6.image=album6;
            }
            sn6.text=song6Name;
            an6.text=song6Artist;
            
            
            if (album7==nil) {
                 sugg7.image=[UIImage imageNamed:@"defaultAlbum.png"];
            }
            else
            {
                sugg7.image=album7;
            }
            sn7.text=song7Name;
            an7.text=song7Artist;
            
            
            if (album8==nil) {
                 sugg8.image=[UIImage imageNamed:@"defaultAlbum.png"];
            }
            else
            {
                sugg8.image=album8;
            }
            sn8.text=song8Name;
            an8.text=song8Artist;
            
            
            if (album9==nil) {
                 sugg9.image=[UIImage imageNamed:@"defaultAlbum.png"];
            }
            else
            {
                sugg9.image=album9;
            }
            sn9.text=song9Name;
            an9.text=song9Artist;

            
            if (album10==nil) {
                 sugg10.image=[UIImage imageNamed:@"defaultAlbum.png"];
            }
            else
            {
                sugg10.image=album10;
            }
            sn10.text=song10Name;
            an10.text=song10Artist;

    }
        
    else
    {
        [suggFlow setHidden:YES];
        [errorMessage setHidden:NO];
    }
    }
    else{
        [suggFlow setHidden:YES];
        [errorMessage setHidden:NO];

    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Media player notification handlers

// When the now playing item changes, update song info labels and artwork display.
- (void)handleNowPlayingItemChanged:(id)notification {
    // Ask the music player for the current song.
    
    MPMediaItem *currentItem = self.musicPlayer.nowPlayingItem;
    
    // Display the artist, album, and  for the now-playing media item.
    // These are all UILabels.
    self.songLabel.text   = [currentItem valueForProperty:MPMediaItemPropertyTitle];
    self.artistLabel.text = [currentItem valueForProperty:MPMediaItemPropertyArtist];
    self.albumLabel.text  = [currentItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    
    // Display album artwork. self.artworkImageView is a UIImageView.
    CGSize artworkImageViewSize = self.artworkImageView.bounds.size;
    MPMediaItemArtwork *artwork = [currentItem valueForProperty:MPMediaItemPropertyArtwork];
    if (artwork != nil) {
        self.artworkImageView.image = [artwork imageWithSize:artworkImageViewSize];
    } else {
        self.artworkImageView.image = nil;
    }

    if (currentItem)
    {
    [self getReccomendations];
    }
    else
    {
        suggFlow.hidden=YES;
        MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
        mediaPicker.delegate = self;
        mediaPicker.allowsPickingMultipleItems = YES; // this is the default
        [self presentModalViewController:mediaPicker animated:YES];
        [mediaPicker release];
        
    }

}


#pragma mark MPMediaPickerController delegate methods

- (void)mediaPicker: (MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    // We need to dismiss the picker
    [self dismissModalViewControllerAnimated:YES];
    
    // Assign the selected item(s) to the music player and start playback.
    [self.musicPlayer stop];
    [self.musicPlayer setQueueWithItemCollection:mediaItemCollection];
    [self.musicPlayer play];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    // User did not select anything
    // We need to dismiss the picker
    [self dismissModalViewControllerAnimated:YES];
}



@end
