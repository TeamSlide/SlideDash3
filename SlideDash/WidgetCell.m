//
//  WidgetCell.m
//  SlideDash
//
//  Created by Mathias Hansen on 21/07/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "WidgetCell.h"

@implementation WidgetCell
@synthesize widgetImageView;
@synthesize widgetNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    // Set cell background color
    [self.contentView setBackgroundColor:[UIColor blackColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
