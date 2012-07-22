//
//  WeatherSettingsViewController.m
//  SlideDash
//
//  Created by gVince on 7/22/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "WeatherSettingsViewController.h"

@interface WeatherSettingsViewController ()

@end

@implementation WeatherSettingsViewController

@synthesize zipCodeNSUserDefaultKey = _zipCodeNSUserDefaultKey;
@synthesize zipCodeTextField = _zipCodeTextField;
@synthesize zipCodeUserDefaults = _zipCodeUserDefaults;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setZipCodeUserDefaults:[NSUserDefaults standardUserDefaults]];
}

- (void)viewDidUnload
{
    [self setZipCodeTextField:nil];
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelZipCodeEntry:(id)sender {
    [[self navigationController] dismissModalViewControllerAnimated:YES];
}

- (IBAction)saveZipCodeEntry:(id)sender {
    if ([[[self zipCodeTextField] text] length] > 0) {
//        [[self zipCodeNSUserDefaultKey] setValue:[[self zipCodeTextField] text] forKey:@"zipCodeNSUserDefaultKey"];
//        [[self zipCodeUserDefaults] setObject:[[self zipCodeTextField] text] forKey:[self zipCodeNSUserDefaultKey]];
        [[NSUserDefaults standardUserDefaults] setObject:[[self zipCodeTextField] text] forKey:[self zipCodeNSUserDefaultKey]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[self navigationController] dismissModalViewControllerAnimated:YES];
    } else {
        [[self navigationController] dismissModalViewControllerAnimated:YES];
    }
}
@end
