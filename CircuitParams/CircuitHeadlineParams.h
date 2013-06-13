//
//  CircuitHeadlineParams.h
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircuitHeadlineParams : NSObject

@property (nonatomic, retain) NSString *entityId;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *place;
@property (nonatomic, retain) NSMutableArray *tags;
@property (nonatomic, retain) NSDate *timestamp;

@end
