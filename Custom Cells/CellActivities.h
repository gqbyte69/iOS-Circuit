//
//  CellActivities.h
//  Circuit
//
//  Created by Bonz on 6/9/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellActivities : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *activityName;
@property (nonatomic, retain) IBOutlet UILabel *activityLocation;
@property (nonatomic, retain) IBOutlet UIButton *btnActivityType;

@end
