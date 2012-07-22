//
//  CommuteViewController.m
//  SlideDash
//
//  Created by Mcoe mac on 7/22/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "CommuteViewController.h"
#import "CommuteSettingsViewController.h"

@interface CommuteViewController ()

@end

@implementation CommuteViewController
@synthesize TransPortTypeImg;
@synthesize step2, step3, line_id ;
@synthesize departure_time;



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
    //self.departure_time.text =@"wtfffffff";
    self.step2 =[[NSMutableArray alloc]init];
    
    NSLog(@"this is after async %@", step2);
    
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    [locationManager startMonitoringSignificantLocationChanges];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    lastLocation = newLocation;
    [self load];
}

-(void)load
{
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    dispatch_async(queue, ^{
        NSLog(@"this got called2");
        NSString * origin = [NSString stringWithFormat:@"%f,%f", lastLocation.coordinate.latitude, lastLocation.coordinate.longitude];
        NSString * endpoint = @"SJC,CA";
        
        //WHEN SHIT HAPPYENS TO YOUR URL API FIX 
        NSString *urlString2 = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=false&mode=transit",[origin stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [endpoint  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSURL *url2 = [NSURL URLWithString:urlString2];
        
        
        NSData *data2 = [NSData dataWithContentsOfURL:url2];
        
        
        id result2;
        
        if (data2 != nil) {
            NSError *error =nil;
            
            result2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingAllowFragments error:&error];
            if (error == nil) {
                //   NSLog(@"this is result %@", result2);
                //self.array = result2;
            }
        }
        NSArray * steps = [[[[[result2 objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"steps"];
        for (NSDictionary*  step in steps) {
            
            if ([[step objectForKey:@"travel_mode"] isEqualToString: @"TRANSIT"]) {
                
                //elf.step = [step objectForKey:@"travle_mode" is
                self.step3 =  [[ step objectForKey:@"transit_details"] objectForKey:@"headsign"]; 
                self.step2 =  [[[ step objectForKey:@"transit_details"] objectForKey:@"departure_time"] objectForKey:@"text"];
                
                //NSString * stringDepart = [NSString stringWithFormat: [self.step2 objectAtIndex:0]];
                [self performSelectorOnMainThread:@selector(setDeparture_time) withObject:nil waitUntilDone:NO];
                
                //  NSLog(@"ths is departure time !!!!!!! %@", stringDepart);
            }
        }
        //   NSLog(@"this DEPARTURE TIME !!!!!!!!!!!!!! %@",[[[[[[result2 objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"]objectAtIndex:0] objectForKey:@"steps"] objectAtIndex:0]    );
    });
}

-(void) setDeparture_time
{   self.line_id.text =[NSString stringWithFormat:@"%@", self.step3];
    self.departure_time.text =[NSString stringWithFormat:@"%@", self.step2];
}
- (void)viewDidUnload
{
    [self setTransPortTypeImg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)settingsButtonClicked:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    CommuteSettingsViewController *commuteSettingsViewController = [storyboard instantiateViewControllerWithIdentifier:@"CommuteSettingsViewController"];
    
    [self presentModalViewController:commuteSettingsViewController animated:YES];
}
@end
