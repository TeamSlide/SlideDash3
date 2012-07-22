//
//  MainViewController.m
//  SlideDash
//
//  Created by Mathias Hansen on 21/07/12.
//
//

#import "MainViewController.h"
#import "DashboardViewController.h"
#import "PageViewManager.h"
#import "SelectWidgetViewController.h"
#import "EventsModel.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    // Initialize the pageview manager
    pageViewManager = [[PageViewManager alloc]  initWithScrollView:scrollView pageControl:pageControl];
    
    // Initialize initial dashboard view controller
    dashboardViewControllers = [[NSMutableArray alloc] init];
    DashboardViewController *dashboardViewController = [[DashboardViewController alloc] initWithNibName:@"DashboardView" bundle:nil];
    [dashboardViewController setDelegate:self];
    [dashboardViewControllers addObject:dashboardViewController];
    
    [self reloadPages];
    
    // Hide slide menu
    [slideMenu setFrame:CGRectMake(slideMenu.frame.origin.x, -slideMenu.frame.size.height, slideMenu.frame.size.width, slideMenu.frame.size.height)];
    isAnimatingMenu = NO;
    
    // Make overlay tappable
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overlayTapped:)];
    [overlayView addGestureRecognizer:tapGestureRecognizer];
}

- (void)overlayTapped:(id)sender
{
    if (isAnimatingMenu)
        return;
    
    // Hide menu
    [self menuButtonClicked:nil];
}

- (void)reloadPages
{
    // Add views to an array
    NSMutableArray *dashboardViews = [[NSMutableArray alloc] init];
    for (DashboardViewController *dashboardViewController in dashboardViewControllers) {
        [dashboardViews addObject:dashboardViewController.view];
    }
    
    // Make the PageViewManager display our array of UIViews on the UIScrollView.
    [pageViewManager loadPages:dashboardViews];
}

- (void)viewDidUnload
{
    scrollView = nil;
    pageControl = nil;
    slideMenu = nil;
    overlayView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addDashboardClicked:(id)sender {
    if (isAnimatingMenu)
        return;
    
    // Create the new dashboard
    DashboardViewController *dashboardViewController = [[DashboardViewController alloc] initWithNibName:@"DashboardView" bundle:nil];
    [dashboardViewController setDelegate:self];
    [dashboardViewControllers addObject:dashboardViewController];
    [self reloadPages];
    
    // Hide the menu
    [self menuButtonClicked:nil];
    
    // Animate to the newly created dashboard
    [pageViewManager animateToPage:dashboardViewControllers.count - 1];
}

- (IBAction)replaceWidgetsClicked:(id)sender {
}

- (IBAction)removeDashboardClicked:(id)sender {
    if (isAnimatingMenu)
        return;
    
    if ([dashboardViewControllers count] <= 1)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Remove dashboard" message:@"You need to have at least one dashboard." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Remove dashboard" message:@"Are you sure that you want remove the active dashboard?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes!", nil];
        [alertView show];
    }
    
    // Hide the menu
    [self menuButtonClicked:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1)
    {
        // Remove the active dashboard
        [dashboardViewControllers removeObjectAtIndex:pageViewManager.pageIndex];
        
        // Reload pages
        [self reloadPages];
    }
}

- (IBAction)menuButtonClicked:(id)sender {
    if (isAnimatingMenu)
        return;
    
    BOOL showMenu = (slideMenu.frame.origin.y < 0);
    
    [overlayView setHidden:NO];//!showMenu];
    
    [UIView animateWithDuration:0.4f animations:^{
        isAnimatingMenu = YES;
        
        CGFloat newY = 0;
        
        if (showMenu) {
            // Show menu
            newY = 0;
            [overlayView setAlpha:0.6f];
        } else {
            // Hide menu
            newY = -(slideMenu.frame.size.height + 44.0);
            [overlayView setAlpha:0.0f];
        }
        
        [slideMenu setFrame:CGRectMake(slideMenu.frame.origin.x, newY, slideMenu.frame.size.width, slideMenu.frame.size.height)];
    } completion:^(BOOL finished) {
        if (finished)
        {
            isAnimatingMenu = NO;
        }
    }];
}

- (void)didClickAddWidget:(int)location
{
    NSLog(@"You clicked a widget add button! %d", location);
    [self performSegueWithIdentifier:@"SelectWidgetSegue" sender:[NSNumber numberWithInt:location]];
}

- (void)didSelectWidget:(NSString*)widgetId forLocation:(int)location
{
    DashboardViewController *dashboardViewController = (DashboardViewController*)[dashboardViewControllers objectAtIndex:pageViewManager.pageIndex];
    [dashboardViewController setWidget:widgetId inLocation:location];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SelectWidgetSegue"])
    {
        NSNumber *location = (NSNumber*)sender;
        
        SelectWidgetViewController *selectWidgetViewController = [segue destinationViewController];
        [selectWidgetViewController setDelegate:self];
        [selectWidgetViewController setLocation:[location intValue]];
    }
}

@end
