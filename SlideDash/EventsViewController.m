//
//  EventsViewController.m
//  SlideDash
//
//  Created by Fang Chen on 7/22/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController ()
@end

@implementation EventsViewController
@synthesize eventImageView;
@synthesize textView;
@synthesize mainLabel;
@synthesize subTitle;
@synthesize eventHandler = _eventHandler;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"in initwithnibname");
        if (!_eventHandler) {
            _eventHandler = [[EventsModel alloc] init];
            [_eventHandler setDelegate:self];
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadNewEvent];
}

- (void)viewDidUnload {
    [self setEventImageView:nil];
    [self setTextView:nil];
    [self setMainLabel:nil];
    [self setSubTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)loadNewEvent {
    
    [self.eventHandler updateStack];
    NSDictionary *newEvent = [self.eventHandler getNextEvent];
    
    if ([newEvent objectForKey:@"eventName"]) {
        self.mainLabel.text = [newEvent objectForKey:@"eventName"];
    } else {
        NSLog(@"no eventName");
    }
    
    if ([newEvent objectForKey:@"eventLocation"]) {
        self.subTitle.text = [newEvent objectForKey:@"eventLocation"];
    } else if ([newEvent objectForKey:@"eventLocationTitle"]) {
        self.subTitle.text = [newEvent objectForKey:@"eventLocationTitle"];
    } else {
        NSLog(@"no location");
    }
    
}

@end
