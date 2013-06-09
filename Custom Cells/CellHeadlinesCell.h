//
//  CellHeadlinesCell.h
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellHeadlinesCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *lblAuthor;
@property (nonatomic, retain) IBOutlet UILabel *lblHeadlineName;
@property (nonatomic, retain) IBOutlet UILabel *lblPlace;
@property (nonatomic, retain) IBOutlet UILabel *lblDescription;
@property (nonatomic, retain) IBOutlet UIImageView *imgHeadlinePicture;
@property (nonatomic, retain) IBOutlet UIImageView *imgBG;
@property (nonatomic, retain) IBOutlet UIButton *btnView;
@property (nonatomic, retain) IBOutlet UIButton *btnLike;
@property (nonatomic, retain) IBOutlet UIButton *btnAdapt;

@end
