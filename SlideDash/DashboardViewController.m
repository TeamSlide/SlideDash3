//
//  DashboardViewController.m
//  SlideDash
//
//  Created by Mathias Hansen on 21/07/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "DashboardViewController.h"
#import "WeatherViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController
@synthesize topWidget;
@synthesize leftWidget;
@synthesize rightWidget;
@synthesize bottomView;

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
    NSLog(@"Add widget: %d", button.tag);
    
    // Add weather widget
    WeatherViewController *weatherWidgetController = [[WeatherViewController alloc] initWithNibName:@"WeatherWidget" bundle:nil];
    [button.superview addSubview:weatherWidgetController.view];
}
@end
