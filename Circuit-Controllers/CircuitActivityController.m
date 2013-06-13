//
//  CircuitActivityController.m
//  Circuit
//
//  Created by Bonz on 6/9/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import "CircuitActivityController.h"

@implementation CircuitActivityController

@synthesize delegate;
@synthesize arrayActivities;
@synthesize arrayActivityFeed;

- (id)init
{
	store = [KCSAppdataStore storeWithOptions:@{ KCSStoreKeyCollectionName : @"Activities",
			KCSStoreKeyCollectionTemplateClass : [Circuit_Activity class]}];
	
	arrayActivities = [NSMutableArray array];
	arrayActivityFeed = [NSMutableArray array];
	
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

- (void)getActivityFeed
{
	[store queryWithQuery:[KCSQuery query] withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
		if (errorOrNil != nil)
		{
			//An error happened, just log for now
			NSLog(@"An error occurred on fetch: %@", errorOrNil);
		}
		else
		{
			[arrayActivityFeed setArray:objectsOrNil];
			[delegate hasUpdatedActivityFeed:self];
		}
	} withProgressBlock:nil];
}

- (void)getActivityWithParent:(NSString *) parentId
{
	KCSQuery *activityQuery = [KCSQuery queryOnField:@"parentid" withExactMatchForValue:parentId];
	
	
	[store queryWithQuery:activityQuery withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
		if (errorOrNil != nil)
		{
			//An error happened, just log for now
			NSLog(@"An error occurred on fetch: %@", errorOrNil);
		}
		else
		{
//			NSLog(@"FETCHED:\n%@", objectsOrNil);
			[self arrangeStepsOfArray:objectsOrNil];
		}
	} withProgressBlock:nil];
}

- (void)arrangeStepsOfArray:(NSArray *) arrayInput
{
	NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:arrayInput.count];
	NSString *dummyObject = @"";
	
	for (int i = 0; i < arrayInput.count; i++)
	{
		[tempArray addObject:dummyObject];
	}
	
	for (Circuit_Activity *record in arrayInput)
	{
		[tempArray replaceObjectAtIndex:record.stepnumber.integerValue-1 withObject:record];
	}

	[arrayActivities setArray:tempArray];
	[delegate hasUpdatedActivity:self];
}

@end
