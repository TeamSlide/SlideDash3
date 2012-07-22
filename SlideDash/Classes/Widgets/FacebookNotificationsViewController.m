//
//  FacebookNotificationsViewController.m
//  SlideDash
//
//  Created by Mathias Hansen on 22/07/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "FacebookNotificationsViewController.h"

@interface FacebookNotificationsViewController ()

@end

@implementation FacebookNotificationsViewController
@synthesize labelFriends;
@synthesize labelMessages;
@synthesize labelNotifications;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setLabelFriends:nil];
    [self setLabelMessages:nil];
    [self setLabelNotifications:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
