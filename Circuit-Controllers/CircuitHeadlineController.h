//
//  CircuitHeadlineController.h
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Circuit-Headline.h"
#import "CircuitHeadlineParams.h"

@class CircuitHeadlineController;
@protocol CircuitHeadlineControllerDelegate <NSObject>

@required
- (void)hasUpdatedHeadlineFeed:(CircuitHeadlineController *) sender;


@end


@interface CircuitHeadlineController : NSObject {
	KCSAppdataStore *store;
	id <CircuitHeadlineControllerDelegate> delegate;
}

@property (nonatomic, retain) NSMutableArray *arrayUserHeadlines;
@property (nonatomic, retain) NSMutableArray *arrayFeed;
@property (nonatomic, strong) id <CircuitHeadlineControllerDelegate> delegate;

+ (CircuitHeadlineController *)sharedInstance;

@end
