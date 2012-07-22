//
//  MasterViewController.m
//  SlideDash
//
//  Created by Fang Chen on 7/21/12.
//  Copyright (c) 2012 genu1. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic) CGSize scrollViewSize;
@end

@implementation MasterViewController
@synthesize scrollView = _scrollView;
@synthesize scrollViewSize;

- (CGSize)scrollViewSize {
    CGSize svs = CGSizeMake(640, 480);
    return svs;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    self.scrollView set
//    [self.scrollView setContentSize:self.scrollViewSize];
    
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
