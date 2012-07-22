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

@interface MainViewController ()

@end

@implementation MainViewController

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
    [dashboardViewControllers addObject:[[DashboardViewController alloc] initWithNibName:@"DashboardView" bundle:nil]];
    
    [self reloadPages];
    
    // Hide slide menu
    [slideMenu setFrame:CGRectMake(slideMenu.frame.origin.x, -slideMenu.frame.size.height, slideMenu.frame.size.width, slideMenu.frame.size.height)];
    isAnimatingMenu = NO;
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
    [dashboardViewControllers addObject:[[DashboardViewController alloc] initWithNibName:@"DashboardView" bundle:nil]];
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
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Remove dashboard" message:@"Are you sure that you want remove the active dashboard?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes!", nil];
    [alertView show];
    
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
    
    [UIView animateWithDuration:0.4f animations:^{
        isAnimatingMenu = YES;
        
        CGFloat newY = 0;
        
        if (slideMenu.frame.origin.y < 0)
        {
            newY = 0;
        }
        else
        {
            newY = -slideMenu.frame.size.height;
        }
        
        [slideMenu setFrame:CGRectMake(slideMenu.frame.origin.x, newY, slideMenu.frame.size.width, slideMenu.frame.size.height)];
    } completion:^(BOOL finished) {
        if (finished)
        {
            isAnimatingMenu = NO;
        }
    }];
}

@end
