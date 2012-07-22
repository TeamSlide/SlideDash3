//
//  WeatherViewController.h
//  SlideDash
//
//  Created by gVince on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WidgetViewController.h"

@interface WeatherViewController : WidgetViewController {
    NSString *_zipCode;
    NSUserDefaults *_zipCodeUserDefaults;
}

@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;

@property (copy, nonatomic) NSString *zipCode;
@property (strong, nonatomic) NSUserDefaults *zipCodeUserDefaults;

@end
