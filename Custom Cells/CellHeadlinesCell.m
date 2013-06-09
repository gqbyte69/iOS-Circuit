//
//  CellHeadlinesCell.m
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import "CellHeadlinesCell.h"

@implementation CellHeadlinesCell

@synthesize lblAuthor;
@synthesize lblHeadlineName;
@synthesize lblPlace;
@synthesize lblDescription;
@synthesize imgHeadlinePicture;
@synthesize imgBG;
@synthesize btnAdapt;
@synthesize btnLike;
@synthesize btnView;

- (void)awakeFromNib
{
	lblAuthor.text = @"";
	lblHeadlineName.text = @"";
	lblPlace.text = @"";
	lblDescription.text = @"";
	imgHeadlinePicture.image = nil;
	imgBG.image = nil;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
