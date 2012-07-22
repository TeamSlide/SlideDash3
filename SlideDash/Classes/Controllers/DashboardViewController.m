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
    
    if ([widget isEqualToString:@"WEATHER"])
    {
        WeatherViewController *weatherWidgetController = [[WeatherViewController alloc] initWithNibName:@"WeatherWidget" bundle:nil];
        [view addSubview:weatherWidgetController.view];
    }
    else if ([widget isEqualToString:@"TWITTER"])
    {
        TweetViewController *tweetViewController = [[TweetViewController alloc] initWithNibName:@"Tweet" bundle:nil];
        [view addSubview:tweetViewController.view];
    }
    
    // Hide the "Add widget" button
    [[view viewWithTag:kAddWidgetButtonTag] setHidden:YES];
}

@end
