//
//  Circuit-Headline.m
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import "Circuit-Headline.h"

@implementation Circuit_Headline

- (id)init
{
	return self;
}

- (NSDictionary *)hostToKinveyPropertyMapping
{
	return @{
			 @"entityId" : KCSEntityKeyId, //the required _id field
    @"author" : @"author",
    @"description" : @"description",
    @"name" : @"name",
	 @"place" : @"place",
	 @"tags" : @"tags",
	 @"timestamp" : @"timestamp"
    };
}

@end
