//
//  RVActionButtons.h
//  RVActionButtons
//
//  Created by Ricardo & Louise on 12/07/12.
//  Copyright (c) 2012 Ricardo Moreira Varjão. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RVActionButtonsSheetDelegate;
@class UILabel, UIToolbar, UITabBar, UIWindow, UIBarButtonItem, UIPopoverController;

typedef NS_ENUM(NSInteger, RVActionButtonsSheetStyle) {
    RVActionButtonSheetStyleAutomatic = -1,       // take appearance from toolbar style otherwise uses 'default'
    RVActionButtonSheetStyleDefault          = UIBarStyleDefault,
    RVActionButtonSheetStyleBlackTranslucent = UIBarStyleBlackTranslucent,
    RVActionButtonSheetStyleBlackOpaque      = UIBarStyleBlackOpaque,
};

@interface RVActionButtonsSheet : UIView<UIPopoverControllerDelegate>{
   @private
    UIView *_view;
    UIView *_background;
    id<RVActionButtonsSheetDelegate>_delegate;
    int _numberOfButtons;
    UIPopoverController *_popController;
    
    UIViewController *_viewController;
    UIPopoverController *_popoverController;
}


- (id)initWithDelegate:(id<RVActionButtonsSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray*)arrayTitles otherButtonImageNames:(NSArray*)arrayImageNames inView:(UIView*)view;

@property(nonatomic, retain) id<RVActionButtonsSheetDelegate> delegate;
@property(nonatomic) RVActionButtonsSheetStyle actionButtonsStyle;
@property (nonatomic, retain) UIView *view;

- (NSInteger)addButtonWithTitle:(NSString *)title imageName:(NSString*)imageName;
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

@property(nonatomic,readonly) NSInteger numberOfButtons;
@property(nonatomic) NSInteger cancelButtonIndex;      // if the delegate does not implement -actionSheetCancel:, we pretend this button was clicked on. default is -1
@property(nonatomic,readonly) NSInteger firstOtherButtonIndex;	// -1 if no otherButtonTitles or initWithTitle:... not used
@property(nonatomic,readonly,getter=isVisible) BOOL visible;

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated NS_AVAILABLE_IOS(3_2);
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated NS_AVAILABLE_IOS(3_2);
- (void)showInView:(UIView*)view;

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;
-(void)clickedButton:(id)sender;


@end


@protocol RVActionButtonsSheetDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionButtonsSheet:(RVActionButtonsSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionButtonsSheetCancel:(RVActionButtonsSheet*)actionButtonsSheet;
- (void)willPresentActionButtonsSheet:(RVActionButtonsSheet *)actionButtonsSheet;  // before animation and showing view
- (void)didPresentActionButtonsSheet:(RVActionButtonsSheet *)actionButtonsSheet;  // after animation
- (void)actionButtonsSheet:(RVActionButtonsSheet *)actionButtonsSheet willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)actionButtonsSheet:(RVActionButtonsSheet *)actionButtonsSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation
@end


