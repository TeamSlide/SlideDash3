//
//  WeatherViewController.m
//  SlideDash
//
//  Created by gVince on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController
@synthesize tempLabel;
@synthesize weatherImage;

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
    
    NSString *urlString = [NSString stringWithFormat:@"http://slidedash.codemonkey.io/weather/95101"];
    
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
    
    [[self tempLabel] setText:[NSString stringWithFormat:@"%@ •F", [jsonResult objectForKey:@"temp"]]];
    
    NSString *theWeather = [NSString stringWithFormat:@"%@", [jsonResult objectForKey:@"code"]];
    NSInteger weatherCode = [theWeather intValue];
    NSString *weatherImagPath; //weatherImagPath = [[NSBundle mainBundle] pathForResource:@"" ofType:@""];
    
    if (weatherCode == 26 || weatherCode == 27 || weatherCode == 28 || weatherCode == 29 || weatherCode == 30 || weatherCode == 40) {
        // Rain
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
    } else if (weatherCode == 7 || weatherCode == 13 || weatherCode == 14 || weatherCode == 15 || weatherCode == 16 || weatherCode == 41 || weatherCode == 42 || weatherCode == 42 || weatherCode == 43 || weatherCode == 46) {
        // Snow
        weatherImagPath = [[NSBundle mainBundle] pathForResource:@"snow" ofType:@"png"];
    } else if (weatherCode == 3 || weatherCode == 4 || weatherCode == 37 || weatherCode == 38 || weatherCode == 39 || weatherCode == 45 || weatherCode == 47) {
        weatherImagPath = [[NSBundle mainBundle] pathForResource:@"thunder" ofType:@"png"];
    } else if (weatherCode == 32) {
        weatherImagPath = [[NSBundle mainBundle] pathForResource:@"WeatherSun" ofType:@"png"];
    } else if (weatherCode == 24) {
        weatherImagPath = [[NSBundle mainBundle] pathForResource:@"windy2" ofType:@"png"];
    } else if (weatherCode == 0) {
        weatherImagPath = [[NSBundle mainBundle] pathForResource:@"windy" ofType:@"png"];
    } else {
        weatherImagPath = [[NSBundle mainBundle] pathForResource:@"WeatherSun" ofType:@"png"];
    }
    
    UIImage *weatherImageFile = [UIImage imageWithContentsOfFile:weatherImagPath];
    
    [[self weatherImage] setImage:weatherImageFile];
    
    // Do any additional setup after loading the view from its nib.
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

@end
