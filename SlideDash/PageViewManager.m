// Author: Emile Cormier
// http://stackoverflow.com/questions/9057462/how-do-i-add-views-to-an-uiscrollview-and-keep-it-synchronized-with-a-uipagecont

#import "PageViewManager.h"

@interface PageViewManager ()

- (void)pageControlChanged;

@end

@implementation PageViewManager

- (id)initWithScrollView:(UIScrollView*)scrollView
             pageControl:(UIPageControl*)pageControl
{
    self = [super init];
    if (self)
    {
        scrollView_ = scrollView;
        pageControl_ = pageControl;
        pageControlUsed_ = NO;
        pageIndex_ = 0;
        
        [pageControl_ addTarget:self action:@selector(pageControlChanged)
               forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

/*  Setup the PageViewManager with an array of UIViews. */
- (void)loadPages:(NSArray*)pages
{
    pages_ = pages;
    scrollView_.delegate = self;
    pageControl_.numberOfPages = [pages count];
    
    CGFloat pageWidth  = scrollView_.frame.size.width;
    CGFloat pageHeight = scrollView_.frame.size.height;
    
    scrollView_.pagingEnabled = YES;
    scrollView_.contentSize = CGSizeMake(pageWidth*[pages_ count], pageHeight);
    scrollView_.scrollsToTop = NO;
    scrollView_.delaysContentTouches = NO;
    
    [pages_ enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop)
     {
         UIView* page = obj;
         page.frame = CGRectMake(pageWidth * index, 0,
                                 pageWidth, pageHeight);
         [scrollView_ addSubview:page];
     }];
}

/*  Setup the PageViewManager with an array of UIViewControllers. */
- (void)loadControllerViews:(NSArray*)pageControllers
{
    NSMutableArray* pages = [NSMutableArray arrayWithCapacity:
                             pageControllers.count];
    [pageControllers enumerateObjectsUsingBlock:
     ^(id obj, NSUInteger idx, BOOL *stop)
     {
         UIViewController* controller = obj;
         [pages addObject:controller.view];
     }];
    
    [self loadPages:pages];
}

- (void)pageControlChanged
{
    pageIndex_ = pageControl_.currentPage;
    
    // Set the boolean used when scrolls originate from the page control.
    pageControlUsed_ = YES;
    
    // Update the scroll view to the appropriate page
    CGFloat pageWidth  = scrollView_.frame.size.width;
    CGFloat pageHeight = scrollView_.frame.size.height;
    CGRect rect = CGRectMake(pageWidth * pageIndex_, 0, pageWidth, pageHeight);
    [scrollView_ scrollRectToVisible:rect animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView*)sender
{
    // If the scroll was initiated from the page control, do nothing.
    if (!pageControlUsed_)
    {
        /*  Switch the page control when more than 50% of the previous/next
         page is visible. */
        CGFloat pageWidth = scrollView_.frame.size.width;
        CGFloat xOffset = scrollView_.contentOffset.x;
        int index = floor((xOffset - pageWidth/2) / pageWidth) + 1;
        if (index != pageIndex_)
        {
            pageIndex_ = index;
            pageControl_.currentPage = index;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    pageControlUsed_ = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    pageControlUsed_ = NO;
}

@end