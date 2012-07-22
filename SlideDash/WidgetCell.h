//
//  WidgetCell.h
//  SlideDash
//
//  Created by Mathias Hansen on 21/07/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WidgetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *widgetImageView;
@property (weak, nonatomic) IBOutlet UILabel *widgetNameLabel;

@end
