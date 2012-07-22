//
//  MainViewController.m
//  SlideDash
//
//  Created by Mathias Hansen on 21/07/12.
//
//

#import "MainViewController.h"
#import "DashboardViewController.h"

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
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    DashboardViewController *dashboardViewController = [storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
    
    // Put the views inside an NSArray:
    dashboardViews = [NSMutableArray arrayWithObjects:dashboardViewController.view, nil];
    
    /* Create the PageViewManager, which is a member (or property) of this
     UIViewController. The UIScrollView and UIPageControl belong to this
     UIViewController, but we're letting the PageViewManager manage them for us. */
    pageViewManager = [[PageViewManager alloc]
                        initWithScrollView:scrollView
                        pageControl:pageControl];
    
    // Make the PageViewManager display our array of UIViews on the UIScrollView.
    [pageViewManager loadPages:dashboardViews];
    
    // Hide slide menu
    [slideMenu setFrame:CGRectMake(slideMenu.frame.origin.x, -slideMenu.frame.size.height, slideMenu.frame.size.width, slideMenu.frame.size.height)];
    isAnimatingMenu = NO;
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
    UIView* newDashboard = [[UIView alloc] initWithFrame: scrollView.frame];
    newDashboard.backgroundColor = [UIColor blueColor];
    
    [dashboardViews addObject:newDashboard];
    [pageViewManager loadPages:dashboardViews];
    
    // Hide the menu
    [self menuButtonClicked:nil];
    
    // Animate to the newly created dashboard
    [pageViewManager animateToPage:dashboardViews.count - 1];
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
        [dashboardViews removeObjectAtIndex:pageViewManager.pageIndex];
        
        // Reload pages
        [pageViewManager loadPages:dashboardViews];
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
