//
//  CircuitViewController.h
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAAnimation.h>

#import "MBProgressHUD.h"
#import "Circuit-KeyboardController.h"
#import "CircuitHeadlineController.h"
#import "CircuitActivityController.h"
#import "CellHeadlinesCell.h"
#import "CellActivities.h"
//#import "Circuit-TableControllerViewController.h"

@interface CircuitViewController : UIViewController <UITableViewDelegate, CircuitHeadlineControllerDelegate, CircuitActivityControllerDelegate> {
	IBOutlet UIViewController *vcFeed;
	IBOutlet UIViewController *vcActivities;
	IBOutlet UIViewController *vcActivityFeed;
	IBOutlet UIViewController *vcExplore;
	IBOutlet UIViewController *vcProfile;
	
	IBOutlet UINavigationController *navConMain;
	
	IBOutlet UITextField *txtUsername;
	IBOutlet UITextField *txtPassword;
	
	IBOutlet UIView *viewLogin;
	IBOutlet Circuit_KeyboardController *kbController;
	
	IBOutlet UIView *viewMainMenu;

	IBOutlet UIButton *btnCollection;
	IBOutlet UIButton *btnActivities;
	IBOutlet UIButton *btnActivityFeed;
	
	// ACTIVITIES VIEW
	IBOutlet UILabel *lblActHeaderAuthor;
	IBOutlet UILabel *lblActHeaderName;
	IBOutlet UILabel *lblActHeaderPlace;
	IBOutlet UILabel *lblActHeaderDesc;
	IBOutlet UIImageView *imgActHeaderPicture;
	IBOutlet UIImageView *imgActHeaderBG;
	
	// EXPLORE VIEW
	IBOutlet UITextField *txtSearch;
	IBOutlet UITableView *tblSearchResults;
	IBOutlet UIButton *btnExplore;
	
	// PROFILE VIEW
	IBOutlet UILabel *lblProfileName;
	IBOutlet UIButton *btnProfileSettings;
	IBOutlet UIImageView *imgProfilePicture;
	IBOutlet UIButton *btnProfile;
	
	IBOutlet UITableView *tblActivityFeed;
	
	NSMutableArray *arrayCellBGColors;
	
	CGFloat origHeightMenuOverlay;
	
	NSUInteger feedSelectedRow;
	
	MBProgressHUD *hud;
}

@property (nonatomic, retain) IBOutlet UITableView *tblFeed;
@property (nonatomic, retain) IBOutlet UITableView *tblActivities;

- (IBAction)btnNavCollections_Tap:(id)sender;
- (IBAction)btnMainMenuHome_Tap:(id)sender;
- (IBAction)btnMainMenuActivities_Tap:(id)sender;
- (IBAction)btnMainMenuExplore_Tap:(id)sender;
- (IBAction)btnMainMenuProfile_Tap:(id)sender;
- (IBAction)btnNavActivities_Tap:(id)sender;
- (IBAction)btnActHeaderBack_Tap:(id)sender;
- (IBAction)btnNavActivityFeed_Tap:(id)sender;
- (IBAction)btnExplore_Tap:(id)sender;
- (IBAction)btnProfile_Tap:(id)sender;

@end
