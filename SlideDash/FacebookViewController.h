//
//  FacebookViewController.h
//  SlideDash
//
//  Created by Fang Chen on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface FacebookViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *facebook;
@property (strong, nonatomic) NSArray *arrayOfEventsFromCalendars;
@property (strong, nonatomic) NSMutableArray *arrayOfEvents;
@end
