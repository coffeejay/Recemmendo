//
//  ViewController.h
//  Recemendo
//
//  Created by Jay Deuskar on 10/20/12.
//  Copyright (c) 2012 Jay Deuskar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "RVActionButtonsSheet.h"

@interface ViewController : UIViewController <MPMediaPickerControllerDelegate,UIGestureRecognizerDelegate,RVActionButtonsSheetDelegate,UIPopoverControllerDelegate>

{
    MPMusicPlayerController *musicPlayer;
    RVActionButtonsSheet *actionButtonsSheet;
    UIActionSheet *action;
    UILabel *songLabel;
    UILabel *artistLabel;
    UILabel *albumLabel;
    IBOutlet UIView *view1;
    UIImageView *artworkImageView;
    UITextView* textView;
    NSMutableData* responseData;
    IBOutlet UIActivityIndicatorView* loading;
    IBOutlet UIButton* back;
    IBOutlet UIButton* play;
    IBOutlet UIButton* pause;
    IBOutlet UIButton* forward;
    IBOutlet UIButton* recommendations;
    IBOutlet UIImageView* albumArt;
    IBOutlet UIImageView* wait;
    //Recommendations
    IBOutlet UIScrollView *suggFlow;
    IBOutlet UIImageView *sugg1;
    IBOutlet UIImageView *sugg2;
    IBOutlet UIImageView *sugg3;
    IBOutlet UIImageView *sugg4;
    IBOutlet UIImageView *sugg5;
    IBOutlet UIImageView *sugg6;
    IBOutlet UIImageView *sugg7;
    IBOutlet UIImageView *sugg8;
    IBOutlet UIImageView *sugg9;
    IBOutlet UIImageView *sugg10;
    IBOutlet UILabel *sn1;
    IBOutlet UILabel *sn2;
    IBOutlet UILabel *sn3;
    IBOutlet UILabel *sn4;
    IBOutlet UILabel *sn5;
    IBOutlet UILabel *sn6;
    IBOutlet UILabel *sn7;
    IBOutlet UILabel *sn8;
    IBOutlet UILabel *sn9;
    IBOutlet UILabel *sn10;
    IBOutlet UILabel *an1;
    IBOutlet UILabel *an2;
    IBOutlet UILabel *an3;
    IBOutlet UILabel *an4;
    IBOutlet UILabel *an5;
    IBOutlet UILabel *an6;
    IBOutlet UILabel *an7;
    IBOutlet UILabel *an8;
    IBOutlet UILabel *an9;
    IBOutlet UILabel *an10;
    IBOutlet UILabel* errorMessage;
    IBOutlet UIButton* playlistSelect;
    
    
}

@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;
@property (nonatomic, retain) IBOutlet UILabel *songLabel;
@property (nonatomic, retain) IBOutlet UILabel *artistLabel;
@property (nonatomic, retain) IBOutlet UILabel *albumLabel;
@property (nonatomic, retain) IBOutlet UIImageView *artworkImageView;
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet NSMutableData *responseData;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* loading;
@property (nonatomic, retain) IBOutlet UILabel* loadingLabel;
@property (nonatomic, retain) IBOutlet UIImageView *artworkImageViewRec;
@property (nonatomic, retain) IBOutlet UIView *swipeView;

-(IBAction)goToSettings;
-(IBAction)backSong:(UIGestureRecognizer *)sender;
-(IBAction)play_pause_song;
-(IBAction)forwardSong:(UIGestureRecognizer *)sender;
-(IBAction)backSongButton;
-(IBAction)forwardSongButton;
-(IBAction)getReccomendations;
-(void)butt1Click;
-(void)butt2Click;
-(void)butt3Click;
-(void)butt4Click;
-(void)butt5Click;
-(void)butt6Click;
-(void)butt7Click;
-(void)butt8Click;
-(void)butt9Click;
-(void)butt10Click;
-(void)bringToFront;
-(IBAction)pickASong;



@end
