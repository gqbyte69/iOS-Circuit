//
//  CircuitHeadlineController.m
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import "CircuitHeadlineController.h"

@implementation CircuitHeadlineController

@synthesize arrayFeed;
@synthesize arrayUserHeadlines;
@synthesize delegate;

- (id)init
{
	store = [KCSAppdataStore storeWithOptions:@{ KCSStoreKeyCollectionName : @"Headlines",
			 KCSStoreKeyCollectionTemplateClass : [Circuit_Headline class]}];
	
	arrayFeed = [NSMutableArray array];
	arrayUserHeadlines = [NSMutableArray array];
	[self updateFeedArray];
	return self;
}

+ (id)sharedInstance
{
	static dispatch_once_t pred = 0;
	__strong static id _sharedObject = nil;
	dispatch_once(&pred, ^{
		_sharedObject = [[self alloc] init];
	});
	return _sharedObject;
}

- (void)saveHeadline:(CircuitHeadlineParams *) param
{
	Circuit_Headline* headline = [[Circuit_Headline alloc] init];
	
	headline.author = param.author;
	headline.name = param.name;
	headline.place = param.place;
	headline.description = param.description;
	headline.timestamp = [NSDate date];
	
	
	[store saveObject:headline withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
		if (errorOrNil != nil)
		{
			//save failed, show an error alert
			UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Save failed", @"Save Failed")
																				 message:[errorOrNil localizedFailureReason] //not actually localized
																				delegate:nil
																	cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
																	otherButtonTitles:nil];
			[alertView show];
		}
		else
		{
			//save was successful
			NSLog(@"Successfully saved event (id='%@').", [objectsOrNil[0] kinveyObjectId]);
		}
	} withProgressBlock:nil];
}

- (void)getHeadlinesFromUser:(NSString *) username
{
	KCSQuery *userQuery = [KCSQuery queryOnField:@"author" withExactMatchForValue:username];
	
	
	[store queryWithQuery:userQuery withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
		if (errorOrNil != nil)
		{
			//An error happened, just log for now
			NSLog(@"An error occurred on fetch: %@", errorOrNil);
		}
		else
		{
			NSLog(@"FETCHED:\n%@", objectsOrNil);
			//got all events back from server -- update table view
//			[_eventList setArray:objectsOrNil];
//			[self.tableView reloadData];
		}
	} withProgressBlock:nil];
}

- (void)updateFeedArray
{
	// TODO: Change query to show only 10 recent entries using timestamp
	[store queryWithQuery:[KCSQuery query] withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
		if (errorOrNil != nil)
		{
			//An error happened, just log for now
			NSLog(@"An error occurred on fetch: %@", errorOrNil);
		}
		else
		{
			[arrayFeed setArray:objectsOrNil];
			[delegate hasUpdatedHeadlineFeed:self];
		}
	} withProgressBlock:nil];
}

@end
