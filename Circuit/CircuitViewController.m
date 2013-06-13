//
//  CircuitViewController.m
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import "CircuitViewController.h"
#import "CircuitAppDelegate.h"

@interface CircuitViewController ()

@end



@implementation CircuitViewController

@synthesize tblFeed;
@synthesize tblActivities;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

//	[KCSUser activeUser];
//	[KCSUser hasSavedCredentials];
//	[KCSUser clearSavedCredentials];
	
	[self initializeColors];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
														  selector:@selector(activeUserChanged)
																name:KCSActiveUserChangedNotification
															 object:nil];
	
	kbController.window = ((CircuitAppDelegate *)[[UIApplication sharedApplication] delegate]).window;
	kbController.sview = (UIScrollView *)viewLogin;
	
	origHeightMenuOverlay = viewMainMenu.frame.size.height;
	viewMainMenu.frame = CGRectMake(0.0, 50.0, viewMainMenu.frame.size.width, viewMainMenu.frame.size.height);
	
	feedSelectedRow = 0;
//	[navConMain pushViewController:vcFeed animated:YES];
//	UIColor *color1 = [UIColor colorWithRed:(176/255.f) green:(204/255.f) blue:(228/255.f) alpha:1.0];
//	UIColor *color2 = [UIColor colorWithRed:(82/255.f) green:(145/255.f) blue:(193/255.f) alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeColors
{
	arrayCellBGColors = [NSMutableArray array];
	[arrayCellBGColors addObject:[self generateColorWithRed:176 green:34 blue:89 alpha:1]];
	[arrayCellBGColors addObject:[self generateColorWithRed:242 green:59 blue:109 alpha:1]];
	[arrayCellBGColors addObject:[self generateColorWithRed:246 green:119 blue:25 alpha:1]];
	[arrayCellBGColors addObject:[self generateColorWithRed:255 green:186 blue:50 alpha:1]];
	[arrayCellBGColors addObject:[self generateColorWithRed:152 green:201 blue:60 alpha:1]];
	[arrayCellBGColors addObject:[self generateColorWithRed:79 green:194 blue:195 alpha:1]];
	[arrayCellBGColors addObject:[self generateColorWithRed:0 green:166 blue:183 alpha:1]];
}

- (void)showFeedView
{
	CircuitAppDelegate *temp = (CircuitAppDelegate *)[[UIApplication sharedApplication] delegate];
	UIWindow *win = temp.window;
	
	[self.view removeFromSuperview];
	[win addSubview:navConMain.view];
	
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromRight];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	// 6. Commit the animation
	[[win layer] addAnimation:animation forKey:@"SwitchToView1"];
}

- (IBAction)btnSample2_Tap:(id)sender
{
	[navConMain pushViewController:vcActivities animated:YES];
}

- (IBAction)btnLogin_Tap:(id)sender
{
	hud = [MBProgressHUD showHUDAddedTo:viewLogin animated:YES];
	hud.labelText = @"Loggin in...";
	
	txtUsername.text = @"user1";
	txtPassword.text = @"pass";
	
	[KCSUser loginWithUsername:txtUsername.text password:txtPassword.text withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
		if (errorOrNil == nil)
		{
			NSLog(@"LOGIN SUCCESS!!!");
			
			[self headlineController].delegate = self;
			[self activityController].delegate = self;
			
			[self hideLoader];
			[self showFeedView];
			
		}
		else
		{
			if (hud)
			{
				[MBProgressHUD hideHUDForView:viewLogin animated:YES];
				hud = nil;
			}
			
			//there was an error with the update save
			NSString* message = [errorOrNil localizedDescription];
			UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Create account failed", @"Sign account failed")
																			message:message
																		  delegate:nil
															  cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
															  otherButtonTitles: nil];
			[alert show];
		}
	}];
}

- (void)activeUserChanged
{
	NSLog(@"Active user changed");
}

- (void)getUserDetails
{
	
//	KCSUserAttributeUsername
//	KCSUserAttributeSurname
//	KCSUserAttributeGivenname
//	KCSUserAttributeEmail
//	KCSUserAttributeFacebookId
	
	[KCSUserDiscovery lookupUsersForFieldsAndValues:@{ KCSUserAttributeSurname : @"Smith"}
											  completionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
												  if (errorOrNil == nil)
												  {
													  //array of matching KCSUser objects
													  NSLog(@"Found %d Smiths", objectsOrNil.count);
													  
													  KCSUser *user = [objectsOrNil objectAtIndex:0];
													  NSString *lastName = user.surname;
												  }
												  else
												  {
													  NSLog(@"Got An error: %@", errorOrNil);
												  }
											  }
												 progressBlock:nil];
}

// To Check if there is a saved credential in the app
//if ([KCSUser hasSavedCredentials] == NO) {
//	//show log-in views
//} else {
//	//user is logged in and will be loaded on first call to Kinvey
//}

// // Logout the active user
//[[KCSUser activeUser] logout];

- (CircuitHeadlineController *)headlineController
{
	return [CircuitHeadlineController sharedInstance];
}

- (CircuitActivityController *)activityController
{
	return [CircuitActivityController sharedInstance];
}

- (CircuitAppDelegate *)appDelegate
{
	return (CircuitAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (IBAction)btnActHeaderBack_Tap:(id)sender
{
	[navConMain popToRootViewControllerAnimated:YES];
}

- (void)btnHeadlineCellAdapt_Tap:(id) sender
{
	
}

- (void)btnHeadlineCellView_Tap:(id) sender
{
	Circuit_Headline *headline = [[self headlineController].arrayFeed objectAtIndex:feedSelectedRow];
	
	NSString *pid = headline.entityId;
	
	NSString *author = [NSString stringWithFormat:@"By: %@", headline.author];
	
	lblActHeaderAuthor.text = author;
	lblActHeaderName.text = headline.name;
	lblActHeaderPlace.text = headline.place;
	lblActHeaderDesc.text = headline.description;
	
	NSInteger rem = (feedSelectedRow % 4) + 1;
	NSString *fn = [NSString stringWithFormat:@"img-%d.png", rem];
	UIImage *thumb = [UIImage imageNamed:fn];
	
	imgActHeaderPicture.image = thumb;
	
	NSInteger remColor = feedSelectedRow % 7;
	UIColor *colorBG = [arrayCellBGColors objectAtIndex:remColor];
	imgActHeaderBG.backgroundColor = colorBG;
	
	
	[[self activityController] getActivityWithParent:pid];
	
	[self showLoaderWithMessage:@"Retrieving Activities..."];
}

- (void)btnHeadlineCellLike_Tap:(id) sender
{
	
}

- (IBAction)btnMainMenuHome_Tap:(id)sender
{
	if ([navConMain topViewController] == vcFeed)
		return;
	
	[self showMainMenuOverlayOnView:nil toShow:NO];
	[navConMain popToRootViewControllerAnimated:YES];
}

- (IBAction)btnMainMenuActivities_Tap:(id)sender
{
	if ([navConMain topViewController] == vcActivityFeed)
		return;
	
	[self showMainMenuOverlayOnView:nil toShow:NO];
	[self showLoaderWithMessage:@"Fetching..."];
	[[self activityController] getActivityFeed];
}

- (IBAction)btnMainMenuExplore_Tap:(id)sender
{
	if ([navConMain topViewController] == vcExplore)
		return;
	
	if ([navConMain topViewController] != vcFeed)
		[navConMain popToRootViewControllerAnimated:NO];
	
	[self showMainMenuOverlayOnView:nil toShow:NO];
	[navConMain pushViewController:vcExplore animated:YES];
}

- (IBAction)btnMainMenuProfile_Tap:(id)sender
{
	if ([navConMain topViewController] == vcProfile)
		return;
	
	if ([navConMain topViewController] != vcFeed)
		[navConMain popToRootViewControllerAnimated:NO];
	
	[self showMainMenuOverlayOnView:nil toShow:NO];
	[navConMain pushViewController:vcProfile animated:YES];
}

- (IBAction)btnNavCollections_Tap:(id)sender
{
	btnCollection.selected = !btnCollection.selected;
	
	[self showMainMenuOverlayOnView:[navConMain topViewController].view toShow:btnCollection.selected];
}

- (IBAction)btnNavActivities_Tap:(id)sender
{
	btnActivities.selected = !btnActivities.selected;
	
	[self showMainMenuOverlayOnView:[navConMain topViewController].view toShow:btnActivities.selected];
}

- (IBAction)btnNavActivityFeed_Tap:(id)sender
{
	btnActivityFeed.selected = !btnActivityFeed.selected;
	
	[self showMainMenuOverlayOnView:[navConMain topViewController].view toShow:btnActivityFeed.selected];
}

- (IBAction)btnExplore_Tap:(id)sender
{
	btnExplore.selected = !btnExplore.selected;
	
	[self showMainMenuOverlayOnView:[navConMain topViewController].view toShow:btnExplore.selected];
}

- (IBAction)btnProfile_Tap:(id)sender
{
	btnProfile.selected = !btnProfile.selected;
	
	[self showMainMenuOverlayOnView:[navConMain topViewController].view toShow:btnProfile.selected];
}

- (void)showMainMenuOverlayOnView:(UIView *) view toShow:(BOOL) state
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.8];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	CGRect m = viewMainMenu.frame;
//	viewMainMenu.frame = CGRectMake(0.0, 50.0, m.size.width, m.size.height);
	
	if (state)
	{
		[view addSubview:viewMainMenu];
		viewMainMenu.frame = CGRectMake(0.0, 50.0, m.size.width, origHeightMenuOverlay);
	}
	else
	{
		[viewMainMenu removeFromSuperview];
		viewMainMenu.frame = CGRectMake(0.0, 50.0, m.size.width, 0);
	}
	
	[UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//#warning Potentially incomplete method implementation.
	//    // Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (tableView == tblFeed)
	{
		return [self headlineController].arrayFeed.count;
	}
	
	if (tableView == tblActivities)
	{
		return [self activityController].arrayActivities.count;
	}

	if (tableView == tblActivityFeed)
	{
		return [self activityController].arrayActivityFeed.count;
	}
	
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == tblFeed)
	{
		static NSString *CellIdentifier = @"CellHeadlineIdentifier";
		
		CellHeadlinesCell *cell = (CellHeadlinesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (!cell)
		{
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CellHeadline" owner:nil options:nil];
			
			for(id currentObject in topLevelObjects)
			{
				if([currentObject isKindOfClass:[CellHeadlinesCell class]])
				{
					cell = (CellHeadlinesCell *)currentObject;
					break;
				}
			}
		}
		
		Circuit_Headline *headline = [[self headlineController].arrayFeed objectAtIndex:indexPath.row];
		
		NSString *author = [NSString stringWithFormat:@"By: %@", headline.author];
		
		cell.lblAuthor.text = author;
		cell.lblHeadlineName.text = headline.name;
		cell.lblPlace.text = headline.place;
		cell.lblDescription.text = headline.description;
		
		NSInteger rem = (indexPath.row % 4) + 1;
		NSString *fn = [NSString stringWithFormat:@"img-%d.png", rem];
		UIImage *thumb = [UIImage imageNamed:fn];

		cell.imgHeadlinePicture.image = thumb;
		
		NSInteger remColor = indexPath.row % 7;
		UIColor *colorBG = [arrayCellBGColors objectAtIndex:remColor];
		cell.imgBG.backgroundColor = colorBG;
		
		[cell.btnAdapt addTarget:self action:@selector(btnHeadlineCellAdapt_Tap:) forControlEvents:UIControlEventTouchUpInside];
		[cell.btnView addTarget:self action:@selector(btnHeadlineCellView_Tap:) forControlEvents:UIControlEventTouchUpInside];
		[cell.btnLike addTarget:self action:@selector(btnHeadlineCellLike_Tap:) forControlEvents:UIControlEventTouchUpInside];

		return cell;
	}
	
	if ((tableView == tblActivities) || (tableView == tblActivityFeed))
	{
		static NSString *CellIdentifier = @"CellActivityIdentifier";
		
		CellActivities *cell = (CellActivities *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (!cell)
		{
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CellActivity" owner:nil options:nil];
			
			for(id currentObject in topLevelObjects)
			{
				if([currentObject isKindOfClass:[CellActivities class]])
				{
					cell = (CellActivities *)currentObject;
					break;
				}
			}
		}

		Circuit_Activity *activity;
		
		if (tableView == tblActivities)
			activity = [[self activityController].arrayActivities objectAtIndex:indexPath.row];
		else
			activity = [[self activityController].arrayActivityFeed objectAtIndex:indexPath.row];
		
		cell.activityLocation.text = activity.sublocation;
		cell.activityName.text = activity.name;
//		cell.btnActivityType
		
//		[cell.btnAdapt addTarget:self action:@selector(btnHeadlineCellAdapt_Tap:) forControlEvents:UIControlEventTouchUpInside];
//		[cell.btnView addTarget:self action:@selector(btnHeadlineCellView_Tap:) forControlEvents:UIControlEventTouchUpInside];
//		[cell.btnLike addTarget:self action:@selector(btnHeadlineCellLike_Tap:) forControlEvents:UIControlEventTouchUpInside];
		
		return cell;
	}
	
	NSAssert(FALSE, @"No valid callback for the table called.");
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == tblFeed)
	{
		feedSelectedRow = indexPath.row;
		
		[tableView beginUpdates];
		[tableView endUpdates];
	}
	
	[[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
//
//	if (tableView == tblFeed)
//	{
//		
//	}
	
	// Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
	 // ...
	 // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == tblFeed)
	{
		if(indexPath.row == [tableView indexPathForSelectedRow].row)
			return 150.0;
		else
			return 100;
	}
	
	if ((tableView == tblActivities) || (tableView == tblActivityFeed))
		return 99;
	
	return 0;
}

- (void)hasUpdatedHeadlineFeed:(CircuitHeadlineController *)sender
{
	[tblFeed reloadData];
}

- (void)hasUpdatedActivity:(CircuitActivityController *)sender
{
	[tblActivities reloadData];
	
	[self hideLoader];
	[navConMain pushViewController:vcActivities animated:YES];
}

- (void)hasUpdatedActivityFeed:(CircuitActivityController *)sender
{
	[tblActivityFeed reloadData];
	
	[self hideLoader];
	[navConMain pushViewController:vcActivityFeed animated:YES];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI METHODS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)showLoaderWithMessage:(NSString *) message
{
	hud = [MBProgressHUD showHUDAddedTo:[navConMain topViewController].view animated:YES];
	hud.labelText = message;
}

- (void)hideLoader
{
	if (hud)
	{
		[MBProgressHUD hideHUDForView:[navConMain topViewController].view animated:YES];
		hud = nil;
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI TOOLS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (UIColor *)generateColorWithRed:(NSUInteger) red
									 green:(NSUInteger) green
									  blue:(NSUInteger) blue
									 alpha:(CGFloat) alpha
{
	return [UIColor colorWithRed:(red/255.f) green:(green/255.f) blue:(blue/255.f) alpha:alpha];
}

@end
