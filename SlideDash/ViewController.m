//
//  ViewController.m
//  SlideDash
//
//  Created by gVince on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize topView;
@synthesize leftView;
@synthesize rightView;
@synthesize bottomView;
@synthesize settingsButton;
@synthesize addButton;
@synthesize weatherLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *urlString = [NSString stringWithFormat:@"http://slidedash.codemonkey.io/weather/94080"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    id result;
    
    if (data != nil) {
        NSError *error =nil;
        
        result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error == nil) {
            NSLog(@"this is result %@", result);
        }
    }
    
    NSDictionary *jsonResult = [result objectAtIndex:0];
    
    [[self weatherLabel] setText:[NSString stringWithFormat:@"temp:%@\n%@", [jsonResult objectForKey:@"temp"], [jsonResult objectForKey:@"text"]]];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTopView:nil];
    [self setLeftView:nil];
    [self setRightView:nil];
    [self setBottomView:nil];
    [self setSettingsButton:nil];
    [self setAddButton:nil];
    [self setWeatherLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [topView release];
    [leftView release];
    [rightView release];
    [bottomView release];
    [settingsButton release];
    [addButton release];
    [weatherLabel release];
    [super dealloc];
}

#pragma mark Custom Methods


@end
