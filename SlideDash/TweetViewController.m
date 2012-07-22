//
//  TweetViewController.m
//  SlideDash
//
//  Created by Mcoe mac on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()

@end

@implementation TweetViewController
@synthesize TweetTextLabel;
@synthesize ImageTweet;
@synthesize TweetStrollView;
@synthesize array;


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
    
       
	// Do any additional setup after loading the view, typically from a nib.
    NSString *urlString2 = [NSString stringWithFormat:@"http://slidedash.codemonkey.io/twitter/hashtag/iosdevcamp"];
    
    NSURL *url2 = [NSURL URLWithString:urlString2];
    
    NSData *data2 = [NSData dataWithContentsOfURL:url2];
    
    id result2;
    
    if (data2 != nil) {
        NSError *error =nil;
        
        result2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingAllowFragments error:&error];
        if (error == nil) {
            NSLog(@"this is result %@", result2);
            self.array = result2;
        }
    }
    
    //  NSDictionary *jsonResult2 = [result2 objectAtIndex:0];
    
    NSString * myText = [[result2 objectAtIndex:0]objectForKey:@"text"];
    //get size of the text:
    CGFloat constrainedSize = 265.0f; //or any other size
    //or any other font that matches what you will use in the UILabel
    CGSize textSize = [myText sizeWithFont: self.TweetTextLabel.font
                         constrainedToSize:CGSizeMake(9999, constrainedSize )
                             lineBreakMode:UILineBreakModeWordWrap];
    
    //    NSString  *string = [[[result2 objectAtIndex:0]objectForKey:@"text"]stringValue];
    
    //create a label:
    CGRect labelFrame = CGRectMake (self.TweetTextLabel.frame.origin.x,self.TweetTextLabel.frame.origin.y ,textSize.width , textSize.height);
    [self.TweetTextLabel setFrame:labelFrame];
    
    self.TweetTextLabel.text = [[result2 objectAtIndex:0]objectForKey:@"text"];
    self.TweetStrollView.contentSize = CGSizeMake(labelFrame.size.width,labelFrame.size.height);
    
    
    

	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTweetStrollView:nil];
    [self setTweetTextLabel:nil];
    [self setImageTweet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
