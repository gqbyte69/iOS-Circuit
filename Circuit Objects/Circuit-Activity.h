//
//  Circuit-Activity.h
//  Circuit
//
//  Created by Bonz on 6/9/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Circuit_Activity : NSObject  <KCSPersistable>

@property (nonatomic, copy) NSString *entityId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *stepnumber;
@property (nonatomic, copy) NSString *subactivity;
@property (nonatomic, copy) NSString *sublocation;

@end
