//
//  CircuitHeadlineParams.m
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import "CircuitHeadlineParams.h"

@implementation CircuitHeadlineParams

@synthesize entityId;
@synthesize author;
@synthesize description;
@synthesize name;
@synthesize place;
@synthesize tags;
@synthesize timestamp;

- (id)init
{
	return self;
}

+ (CircuitHeadlineParams *)headlineParam
{
	CircuitHeadlineParams *param = [[CircuitHeadlineParams alloc] init];
	return param;
}

@end
