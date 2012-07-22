//
//  EventsViewController.h
//  SlideDash
//
//  Created by Fang Chen on 7/22/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WidgetViewController.h"
#import "EventsModel.h"

@interface EventsViewController : WidgetViewController
@property (strong, nonatomic) EventsModel *eventHandler;

@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

- (void)loadNewEvent;

@end
