//
//  EmbededTweetViewController.m
//  SlideDash
//
//  Created by Mcoe mac on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "EmbededTweetViewController.h"
#import "TweetViewController.h"
@interface EmbededTweetViewController ()

@end

@implementation EmbededTweetViewController


@synthesize TweetView;
@synthesize TrafficView;
@synthesize faceBookView;
@synthesize WeatherView;

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
    TweetViewController *TweetCon =[[TweetViewController alloc]initWithNibName:@"Tweet" bundle:nil ];
    [self.view addSubview:TweetCon.view];
    //self.TweetView = TweetCon.view;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    
    [self setWeatherView:nil];
    [self setTrafficView:nil];
    [self setFaceBookView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
