//
//  RVActionButtons.m
//  RVActionButtons
//
//  Created by Ricardo & Louise on 12/07/12.
//  Copyright (c) 2012 Ricardo Moreira Varjão. All rights reserved.
//

#import "RVActionButtonsSheet.h"
#import <QuartzCore/QuartzCore.h>

@implementation RVActionButtonsSheet
//@synthesize delegate = _delegate;
@synthesize actionButtonsStyle = _actionButtonsStyle;
@synthesize numberOfButtons = _numberOfButtons;
@synthesize cancelButtonIndex = _cancelButtonIndex;
@synthesize firstOtherButtonIndex = _firstOtherButtonIndex;
@synthesize visible = _visible;

#define velocity 600

- (id)initWithDelegate:(id<RVActionButtonsSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray*)arrayTitles otherButtonImageNames:(NSArray*)arrayImageNames inView:(UIView*)view{
    @autoreleasepool {
        self = [super init];

        if (self) {
            _view = [[UIView alloc] init];
            int row = 0;
            int collumn = 0;
            float currentY = 0;
            
            float wText = 128/2;
            float wButton = 114/2;
            float wMargin = 82.5;
            float wSpace = 86/2;
            
            
            float hButton = 114/2;
            float hMargin = 70/2;
            float hSpace = 86/2;
            float hText = 50/2;
            float hSpaceButtonCancel = 107/2;
            float hEndSpace = 37/2;
            
            CGSize sizeLabels = CGSizeMake(wText, hText);
            CGSize sizeButtons = CGSizeMake(wButton, hButton);
            CGSize sizeButtonCancel = CGSizeMake(554/2, 92/2);
            
            _numberOfButtons = [arrayTitles count];
            
            float nButtons = _numberOfButtons;
            float nRows = ceil(nButtons/3);

            float HEIGHT = hMargin + nRows*sizeButtons.height + (nRows-1)*hSpace + hEndSpace + sizeButtonCancel.height + hSpaceButtonCancel;
            float WIDTH = view.frame.size.width;
            

            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                _background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
                [_background setBackgroundColor:[UIColor blackColor]];
                [_background setAlpha:0];
                [view addSubview:_background];
                [view addSubview:_view];
                [view bringSubviewToFront:_background];
                [view bringSubviewToFront:_view];
                _delegate = delegate;
                [_view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9]];

            }else{
                hButton = 72;
                wButton = 72;
                sizeButtons = CGSizeMake(wButton, hButton);
                WIDTH = 3*sizeButtons.width + 2*wMargin + 2*wSpace;
                HEIGHT = hMargin + nRows*sizeButtons.height + (nRows)*hSpace;
            }
            [_view setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
            _view.layer.borderColor = [UIColor blackColor].CGColor;
            _view.layer.borderWidth = 1.0f;
            
            
            float lOffsetText = (wText - wButton)/2;

            currentY = hMargin;
            
            for (int i = 0; i < _numberOfButtons; i++){
                
                if (collumn == 3){
                    currentY = currentY + hSpace + sizeButtons.height;
                    collumn = 0;
                    row++;
                }
                
                UIButton *currentButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [currentButton setImage:[UIImage imageNamed:[arrayImageNames objectAtIndex:i]] forState:UIControlStateNormal];
                [currentButton setFrame:CGRectMake(wMargin + collumn*(wSpace + wButton), currentY, wButton, hButton)];
                [currentButton setBackgroundColor:[UIColor clearColor]];
                [currentButton setUserInteractionEnabled:YES];
                [currentButton setTag:i];
                
                [currentButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
                NSLog(@"button:%@", currentButton);
                
                [_view addSubview:currentButton];
                
                
                UILabel *currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(currentButton.frame.origin.x - lOffsetText, currentY + sizeButtons.height, wText, hText)];
                [currentLabel setBackgroundColor:[UIColor clearColor]];
                [currentLabel setTextColor:[UIColor whiteColor]];
                [currentLabel setText:[arrayTitles objectAtIndex:i]];
                [currentLabel setFont:[UIFont boldSystemFontOfSize:12]];
                [currentLabel setTextAlignment:NSTextAlignmentCenter];
                [currentLabel setLineBreakMode:NSLineBreakByTruncatingHead];
                [currentLabel setNumberOfLines:2];
                [_view addSubview:currentLabel];
                
                collumn++;

            }
            
            currentY = currentY + sizeButtons.height + hSpaceButtonCancel;
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
                    
                    [btnCancel addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
                    [btnCancel setTitle:cancelButtonTitle forState:UIControlStateNormal];
                    [btnCancel.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
                    float x = (WIDTH - sizeButtonCancel.width)/2;
                    [btnCancel setFrame:CGRectMake(x, currentY, sizeButtonCancel.width, sizeButtonCancel.height)]; //AJUSTAR ESTES VALORES
                    [btnCancel setTag:_numberOfButtons];
                    
                    int top = 12;
                    int bottom = 12;
                    int left = 12;
                    int right = 12;
                    UIImage *buttonTemplate = [UIImage imageNamed:@"ChooseAudioButton.png"];
                    UIImage *stretchedButtonImage = [buttonTemplate resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
                    [btnCancel setBackgroundImage:stretchedButtonImage forState:UIControlStateNormal];
                    [_view addSubview:btnCancel];
                
                    [self dismissActionButtonSheetAnimating:NO];

            }
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                _viewController = [[UIViewController alloc] init];
                [_viewController setContentSizeForViewInPopover:_view.frame.size];
                if (_viewController){
                    
                }
                _popoverController = [[UIPopoverController alloc] initWithContentViewController:_viewController];
                [[[_popoverController contentViewController] view] setAlpha:0.75f];
            }

        }
        return self;
    }
}

#pragma mark - Actions
-(void)clickedButton:(id)sender{
    UIButton *btn = sender;
    NSLog(@"buttonClicked:%d", btn.tag);
    if([_delegate respondsToSelector:@selector(actionButtonsSheet:clickedButtonAtIndex:)]){
        [_delegate actionButtonsSheet:self clickedButtonAtIndex:btn.tag];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        if ([_popoverController isPopoverVisible])
            [_popoverController dismissPopoverAnimated:YES];
    }else{
        [self dismissActionButtonSheetAnimating:YES];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    NSString* iTunesURL=[defaults objectForKey:@"iTunesKey"];
    NSString* youtubeURL=[defaults objectForKey:@"YoutubeKey"];
    
    if (btn.tag==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesURL]];
    }
    
    if (btn.tag==1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:youtubeURL]];
    }
    /*
    if (btn.tag==3){
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"Recommendo knows exactly what kind of music I like! (:"];
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Sorry"
                                      message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
     */
}

-(void)dismissActionButtonSheetAnimating:(BOOL)animating{
    if (animating){
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:_view.frame.size.height/velocity];
    }
    
    [_view setCenter:CGPointMake(_view.center.x, 4*_view.frame.size.height)];
    [_background setAlpha:0];
    
    if (animating) [UIView commitAnimations];
    
    
}

#pragma mark - Methods
- (void)showInView:(UIView*)view{
    NSLog(@"_view:%@",_view);

    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:_view.frame.size.height/velocity];

    [_view setFrame:CGRectMake(0, view.frame.size.height - _view.frame.size.height, _view.frame.size.width, _view.frame.size.height)];

//    [_view setFrame:CGRectMake(0, 0, _view.frame.size.width, _view.frame.size.height)];

    NSLog(@"_view:%@",_view);
    
    [_background setAlpha:0.0];
    
    [UIView commitAnimations];
}

//WORKING PROBLEM
- (NSInteger)addButtonWithTitle:(NSString *)title imageName:(NSString*)imageName{
    
    _numberOfButtons++;
    int index = _numberOfButtons - 1;
    if (imageName == nil) imageName = @"defaultIcon.png";
    UIButton *currentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [currentButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [currentButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [currentButton setFrame:CGRectMake(30, 30, 30, 30)]; //AJUSTAR ISSO
    [currentButton setBackgroundColor:[UIColor clearColor]];
    [currentButton setUserInteractionEnabled:YES];

    [currentButton setTag: index];
    
    [currentButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"currentButtonTarget:%@", [currentButton allTargets]);
    NSLog(@"currentButton:%@", currentButton);
    [_view addSubview:currentButton];
    
    return index;
    
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex{
    for(UIButton *aButton in self.view.subviews){
        
        if([aButton isKindOfClass:[UIButton class]] && aButton.tag == buttonIndex){
            return aButton.titleLabel.text;
        }
    }
    return nil;
}


- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated NS_AVAILABLE_IOS(3_2){
    @autoreleasepool{
        [_viewController setView:_view];
        [_viewController setContentSizeForViewInPopover:_view.frame.size];
        [_view setFrame:CGRectMake(0, 0, _view.frame.size.width, _view.frame.size.height)];
        [_popoverController setContentViewController:_viewController];
        [_popoverController presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated NS_AVAILABLE_IOS(3_2){
    
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated{
    [self.view removeFromSuperview];
}

@end
