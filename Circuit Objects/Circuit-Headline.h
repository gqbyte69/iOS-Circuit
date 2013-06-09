//
//  Circuit-Headline.h
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Circuit_Headline : NSObject <KCSPersistable>

@property (nonatomic, copy) NSString *entityId;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, copy) NSMutableArray *tags;
@property (nonatomic, copy) NSDate *timestamp;

@end
