//
//  Circuit-Activity.m
//  Circuit
//
//  Created by Bonz on 6/9/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import "Circuit-Activity.h"

@implementation Circuit_Activity

- (id)init
{
	return self;
}

- (NSDictionary *)hostToKinveyPropertyMapping
{
	return @{
			 @"entityId" : KCSEntityKeyId, //the required _id field
    @"name" : @"name",
    @"stepnumber" : @"stepnumber",
    @"subactivity" : @"subactivity",
	 @"sublocation" : @"sublocation"
    };
}

@end
