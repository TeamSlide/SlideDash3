//
//  EventsViewController.m
//  SlideDash
//
//  Created by Fang Chen on 7/22/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController () <EventsModelDelegate>
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
    
//    NSDictionary *newEvent = [self.eventHandler getNextEvent];
//    
//    if ([newEvent objectForKey:@"eventName"]) {
//        self.mainLabel.text = [newEvent objectForKey:@"eventName"];
//    } else {
//        NSLog(@"no eventName");
//    }
//    
//    if ([newEvent objectForKey:@"eventLocation"]) {
//        self.subTitle.text = [newEvent objectForKey:@"eventLocation"];
//    } else if ([newEvent objectForKey:@"eventLocationTitle"]) {
//        self.subTitle.text = [newEvent objectForKey:@"eventLocationTitle"];
//    } else 
//        NSLog(@"no location");
//    }
    
}

- (void)didGetNextEvent:(NSDictionary *)event {
 
    if ([event objectForKey:@"eventName"]) {
        self.mainLabel.text = [event objectForKey:@"eventName"];
    } else {
        NSLog(@"no eventName");
    }
    
    if ([event objectForKey:@"eventLocation"]) {
        self.subTitle.text = [event objectForKey:@"eventLocation"];
    } else if ([event objectForKey:@"eventLocationTitle"]) {
        self.subTitle.text = [event objectForKey:@"eventLocationTitle"];
    } else {
        NSLog(@"no location");
    }
    
    [UIView animateWithDuration:.5 animations:^{
        [self.mainLabel setAlpha:1];
        [self.subTitle setAlpha:1];
        [self.eventImageView setAlpha:1];
    }];

}

@end
