//
//  TweetViewController.m
//  SlideDash
//
//  Created by Mcoe mac on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "TweetViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface TweetViewController ()

@end

@implementation TweetViewController
@synthesize TweetTextLabel;
@synthesize TweetImgButton;
@synthesize ImageTweet;
@synthesize TweetStrollView;
@synthesize array;
@synthesize TweetUser;
@synthesize timer, timer2;



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
    
    
    [self load];
    [self loadTweet:0];
    //self.ImageTweet.layer 
    //    NSString  *string = [[[result2 objectAtIndex:0]objectForKey:@"text"]stringValue];
    
    //create a label:
   
    
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveX:) userInfo:nil repeats:YES];
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveY:) userInfo:nil repeats:YES];
    
	// Do any additional setup after loading the view.
}
-(void)load
{
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    dispatch_async(queue, ^{
        
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
    });

}

-(void)loadTweet:(NSInteger )myINT
{    myint = myint +myINT;
    
    if (myint >array.count-1) {
        NSLog(@"this is int, and count %i %i", myint , array.count);
        [self load];
        myint = 0;   
        return;
    }
    NSString * myText = [[array objectAtIndex:myint]objectForKey:@"text"];
    //get size of the text:
    CGFloat constrainedSize = 265.0f; //or any other size
    //or any other font that matches what you will use in the UILabel
    CGSize textSize = [myText sizeWithFont: self.TweetTextLabel.font
                         constrainedToSize:CGSizeMake(9999, constrainedSize )
                             lineBreakMode:UILineBreakModeWordWrap];
    
    [self.TweetTextLabel setCenter:CGPointMake(0, self.TweetTextLabel.center.y)];
    
    CGRect labelFrame = CGRectMake (self.TweetTextLabel.frame.origin.x,self.TweetTextLabel.frame.origin.y ,textSize.width , textSize.height);
    [self.TweetTextLabel setFrame:labelFrame];
    NSString *stringURL =[[array objectAtIndex:myint]objectForKey:@"user_photo"] ;
    self.TweetTextLabel.text = [[array objectAtIndex:myint]objectForKey:@"text"];
    NSURL *URL = [NSURL URLWithString:stringURL];
    NSData *ImageData =[NSData dataWithContentsOfURL:URL];
    
    self.TweetUser.text =[[array objectAtIndex:myint]objectForKey:@"user"];
    UIImage *image = [UIImage imageWithData:ImageData];
    [self.TweetImgButton setImage:image forState:normal];
    //self.ImageTweet.image =image;
    self.TweetStrollView.contentSize = CGSizeMake(labelFrame.size.width,labelFrame.size.height);
}

-(void)moveX:(id)sender
{      self.timer =(NSTimer*) sender;
    CGPoint  center = TweetTextLabel.center;
    center.x = center.x-.5;
    [self.TweetTextLabel setCenter:center];
      if (-1* self.TweetTextLabel.center.x > self.TweetTextLabel.frame.size.width -390 ) {
         [self loadTweet:1];
         // NSLog(@"MOVE XXXXXXXXX");
        
          if (self.ImageTweet.image.description != nil) {
              
      self.timer2 = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveY:) userInfo:nil repeats:YES];
    }
      }
   // NSLog(@"this is %f %f", -1*self.TweetTextLabel.center.x, self.TweetTextLabel.frame.size.width);
    
        //[self.timer invalidate];
}
-(void)moveY:(id)sender
{   NSLog(@"wtffff");
    self.timer = (NSTimer *)sender;
    CGPoint center = TweetImgButton.center;
    center.y = center.y- 5;
    [self.TweetImgButton setCenter:center];
    if (-1 *self.TweetImgButton.center.y >self.TweetImgButton.frame.size.height) {
        NSLog(@"hahahahahahahhah");
        [timer invalidate];
        self.TweetImgButton.hidden =YES;
        [self.TweetImgButton setCenter:CGPointMake(40, 30)];
        self.TweetImgButton.hidden =NO;
    }
    NSLog(@"this is %f %f", -1*self.TweetImgButton.center.y, self.TweetImgButton.frame.size.height);
    
    //[self.timer invalidate];
}



- (void)viewDidUnload
{
    
    [self setTweetStrollView:nil];
    [self setTweetTextLabel:nil];
    [self setImageTweet:nil];
    [self setTweetUser:nil];
    [self setTweetImgButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
