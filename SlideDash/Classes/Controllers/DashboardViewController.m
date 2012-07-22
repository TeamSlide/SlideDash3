//
//  DashboardViewController.m
//  SlideDash
//
//  Created by Mathias Hansen on 21/07/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "DashboardViewController.h"
#import "WeatherViewController.h"
#import "TweetViewController.h"
#import "FacebookNotificationsViewController.h"
#import "CommuteViewController.h"
#import "EventsViewController.h"

#define kAddWidgetButtonTag 42

@interface DashboardViewController ()

@end

@implementation DashboardViewController
@synthesize topWidget;
@synthesize leftWidget;
@synthesize rightWidget;
@synthesize bottomView;

@synthesize delegate;

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
    widgets = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
    [self setTopWidget:nil];
    [self setLeftWidget:nil];
    [self setRightWidget:nil];
    [self setBottomView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addWidgetClicked:(id)sender {
    UIButton *button = (UIButton*)sender;
    
    if (delegate)
    {
        [delegate didClickAddWidget:button.superview.tag];
    }
    
    // Add weather widget
    /*WeatherViewController *weatherWidgetController = [[WeatherViewController alloc] initWithNibName:@"WeatherWidget" bundle:nil];
    [button.superview addSubview:weatherWidgetController.view];*/
}

- (void)setWidget:(NSString*)widget inLocation:(int)location
{
    UIView *view = [self.view viewWithTag:location];
    
    // Remove existing view if we have one
    [[view viewWithTag:999] removeFromSuperview];
    
    WidgetViewController *widgetViewController = nil;
    
    if ([widget isEqualToString:@"WEATHER"])
    {
        widgetViewController = [[WeatherViewController alloc] initWithNibName:@"WeatherWidget" bundle:nil];
    }
    else if ([widget isEqualToString:@"TWITTER"])
    {
        widgetViewController = [[TweetViewController alloc] initWithNibName:@"Tweet" bundle:nil];
    }
    else if ([widget isEqualToString:@"FACEBOOKNOTIFICATIONS"])
    {
        widgetViewController = [[FacebookNotificationsViewController alloc] initWithNibName:@"FacebookNotifications" bundle:nil];
    }
    else if ([widget isEqualToString:@"COMMUTE"])
    {
       widgetViewController = [[CommuteViewController alloc] initWithNibName:@"CommuteViewController" bundle:nil];
    }
    else if ([widget isEqualToString:@"EVENT"])
    {
        widgetViewController = [[EventsViewController alloc] initWithNibName:@"EventsViewController" bundle:nil];
    }
    
    if (widgetViewController != nil)
    {
        // Save widget and show it
        [widgets addObject:widgetViewController];
        [widgetViewController.view setTag:999];
        [view addSubview:widgetViewController.view];
        
        // Hide the "Add widget" button
        [[view viewWithTag:kAddWidgetButtonTag] setHidden:YES];
    }
}

- (void)removeAllWidgets
{
    for (int i = 100; i < 104; i++)
    {
        UIView *view = [self.view viewWithTag:i];
        [[view viewWithTag:999] removeFromSuperview];
    }
}

- (void)showAddWidgetButtons
{
    for (int i = 100; i < 104; i++)
    {
        UIView *view = [self.view viewWithTag:i];
        [[view viewWithTag:999] setAlpha:0.1f];
        [[view viewWithTag:kAddWidgetButtonTag] setHidden:NO];
        [view bringSubviewToFront:[view viewWithTag:kAddWidgetButtonTag]];
    }
}

- (void)hideAddWidgetButtons
{
    for (int i = 100; i < 104; i++)
    {
        UIView *view = [self.view viewWithTag:i];
        [[view viewWithTag:999] setAlpha:1.0f];
        [[view viewWithTag:kAddWidgetButtonTag] setHidden:YES];
    }
}

@end
