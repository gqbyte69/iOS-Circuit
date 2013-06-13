//
//  CircuitActivityController.h
//  Circuit
//
//  Created by Bonz on 6/9/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Circuit-Activity.h"

@class CircuitActivityController;
@protocol CircuitActivityControllerDelegate <NSObject>

@required
- (void)hasUpdatedActivity:(CircuitActivityController *) sender;
- (void)hasUpdatedActivityFeed:(CircuitActivityController *) sender;

@end

@interface CircuitActivityController : NSObject {
	KCSAppdataStore *store;
	id <CircuitActivityControllerDelegate> delegate;
}

@property (nonatomic, strong) id <CircuitActivityControllerDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *arrayActivities;
@property (nonatomic, retain) NSMutableArray *arrayActivityFeed;

+ (CircuitActivityController *)sharedInstance;
- (void)getActivityWithParent:(NSString *) parentId;
- (void)getActivityFeed;

@end
