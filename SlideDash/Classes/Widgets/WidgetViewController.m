//
//  WidgetViewController.m
//  SlideDash
//
//  Created by Mathias Hansen on 22/07/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "WidgetViewController.h"

@interface WidgetViewController ()

@end

@implementation WidgetViewController

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)settingsButtonClicked:(id)sender {
}
@end
