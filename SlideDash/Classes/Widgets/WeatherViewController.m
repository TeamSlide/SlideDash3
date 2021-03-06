//
//  WeatherViewController.m
//  SlideDash
//
//  Created by gVince on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherSettingsViewController.h"

@interface WeatherViewController () {
    NSData *data;
}

@property (strong, nonatomic) NSData *data;

- (void)beforeGo;

@end

@implementation WeatherViewController
@synthesize tempLabel;
@synthesize weatherImage;
@synthesize data;

@synthesize zipCode = _zipCode;
@synthesize zipCodeUserDefaults = _zipCodeUserDefaults;

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
    
    [self setZipCodeUserDefaults:[NSUserDefaults standardUserDefaults]];
    
    [self beforeGo];
}

- (void)beforeGo {
    
    dispatch_queue_t queue = dispatch_queue_create("q", NULL);
    dispatch_async(queue, ^{
        
        if ([self zipCode] == nil) {
            [[self zipCodeUserDefaults] setObject:@"95231" forKey:@"zipCodeNSUserDefaultKey"];
            [self setZipCode:[NSString stringWithString:[[self zipCodeUserDefaults] objectForKey:@"zipCodeNSUserDefaultKey"]]];
        }
        
        NSString *zipCodeToAppend = [NSString stringWithString:[self zipCode]];
        
        
        NSString *primaryURLString = [NSString stringWithString:@"http://slidedash.codemonkey.io/weather/"];
        primaryURLString = [primaryURLString stringByAppendingString:zipCodeToAppend];
        
        NSString *urlString = [NSString stringWithString:primaryURLString];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        [self setData:[NSData dataWithContentsOfURL:url]];
        
        [self performSelectorOnMainThread:@selector(go) withObject:nil waitUntilDone:NO];
        
    });
}

- (void)go {
    id result;
    
    if ([self data] != nil) {
        NSError *error =nil;
        
        result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error == nil) {
            
            NSDictionary *jsonResult = [result objectAtIndex:0];
            
            [[self tempLabel] setText:[NSString stringWithFormat:@"%@ °F", [jsonResult objectForKey:@"temp"]]];
            
            NSString *theWeather = [NSString stringWithFormat:@"%@", [jsonResult objectForKey:@"code"]];
            NSInteger weatherCode = [theWeather intValue];
            NSString *weatherImagPath; //weatherImagPath = [[NSBundle mainBundle] pathForResource:@"" ofType:@""];
            
            if ((weatherCode >= 26 && weatherCode <= 30) || weatherCode == 40) {
                // Cloudy
                weatherImagPath = [[NSBundle mainBundle] pathForResource:@"cloudy" ofType:@"png"];
            } else if (weatherCode == 20) {
                // Fog
                weatherImagPath = [[NSBundle mainBundle] pathForResource:@"FOG" ofType:@"png"];
            } else if (weatherCode == 17 || weatherCode == 35) {
                // Hail
                weatherImagPath = [[NSBundle mainBundle] pathForResource:@"hail" ofType:@"png"];
            } else if (weatherCode == 5 || weatherCode == 6 || weatherCode == 10 || weatherCode == 35) {
                // Rain
                weatherImagPath = [[NSBundle mainBundle] pathForResource:@"rain" ofType:@"png"];
            } else if (weatherCode == 7 || (weatherCode >= 13 && weatherCode <= 16) || weatherCode == 41 || weatherCode == 42 || weatherCode == 43 || weatherCode == 46) {
                // Snow
                weatherImagPath = [[NSBundle mainBundle] pathForResource:@"snow" ofType:@"png"];
            } else if (weatherCode == 3 || weatherCode == 4 || (weatherCode >= 37 && weatherCode <= 39) || weatherCode == 45 || weatherCode == 47) {
                weatherImagPath = [[NSBundle mainBundle] pathForResource:@"thunder" ofType:@"png"];
            } else if (weatherCode == 32 || weatherCode == 34) {
                weatherImagPath = [[NSBundle mainBundle] pathForResource:@"Sunny" ofType:@"png"];
            } else if (weatherCode == 24) {
                weatherImagPath = [[NSBundle mainBundle] pathForResource:@"windy2" ofType:@"png"];
            } else if (weatherCode == 0) {
                weatherImagPath = [[NSBundle mainBundle] pathForResource:@"windy" ofType:@"png"];
            } else if (weatherCode == 33){
                weatherImagPath = [[NSBundle mainBundle] pathForResource:@"noun_moon" ofType:@"png"];
            } else {
                weatherImagPath = [[NSBundle mainBundle] pathForResource:@"Sunny" ofType:@"png"];
            }
            
            UIImage *weatherImageFile = [UIImage imageWithContentsOfFile:weatherImagPath];
            
            [[self weatherImage] setImage:weatherImageFile];
        }
    } else { // If there's no internet connection, display something else.
        NSString *weatherImagePath = [[NSBundle mainBundle] pathForResource:@"cloudy" ofType:@"png"];
        UIImage *weatherImageFile = [UIImage imageWithContentsOfFile:weatherImagePath];
        [[self weatherImage] setImage:weatherImageFile];
        
        [[self tempLabel] setText:[NSString stringWithString:@"off"]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setZipCode:[[self zipCodeUserDefaults] objectForKey:@"zipCodeNSUserDefaultKey"]];
    
    
    NSLog(@"zipcode: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"zipCodeNSUserDefaultKey"]);
    //[NSUserDefaults standardUserDefaults] setObject:<#(id)#> forKey:<#(NSString *)#>
    [self beforeGo];
}

- (void)viewDidUnload
{
    [self setTempLabel:nil];
    [self setWeatherImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Overidden Methods

- (void) settingsButtonClicked:(id)sender {
    NSLog(@"weather settings");
    WeatherSettingsViewController *wsvc = [[WeatherSettingsViewController alloc] initWithNibName:@"WeatherSettingsViewController" bundle:nil];
    [wsvc setZipCodeNSUserDefaultKey:@"zipCodeNSUserDefaultKey"];
    
    UINavigationController *weatherNavCon  = [[UINavigationController alloc] initWithRootViewController:wsvc];
    [self presentModalViewController:weatherNavCon animated:YES];
}

@end
