//
//  Circuit-TableControllerViewController.m
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import "Circuit-TableControllerViewController.h"

@interface Circuit_TableControllerViewController ()

@end

@implementation Circuit_TableControllerViewController

- (void)awakeFromNib
{
	NSLog(@"TABLEVIEW CONTROLLER");
}

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (CircuitAppDelegate *)appDelegate
{
	return (CircuitAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (CircuitHeadlineController *)headlineController
{
	return [CircuitHeadlineController sharedInstance];
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
// 
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (tableView == [self appDelegate].viewController.tblFeed)
	{
		return [self headlineController].arrayFeed.count;
	}
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == [self appDelegate].viewController.tblFeed)
	{
		static NSString *CellIdentifier = @"RosterCellIdentifier";
		
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

		cell.lblAuthor.text = headline.author;
		cell.lblHeadlineName.text = headline.name;
		cell.lblPlace.text = headline.place;
		cell.lblDescription.text = headline.description;
		
		return cell;
	}
	
	
	NSAssert(FALSE, @"No valid callback for the table called.");
	return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}






- (void)hasUpdatedHeadlineFeed:(CircuitHeadlineController *)sender
{
	[[self appDelegate].viewController.tblFeed reloadData];
}


@end