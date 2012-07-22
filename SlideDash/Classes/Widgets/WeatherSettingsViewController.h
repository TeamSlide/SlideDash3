//
//  WeatherSettingsViewController.h
//  SlideDash
//
//  Created by gVince on 7/22/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherSettingsViewController : UIViewController {
    NSString *_zipCodeNSUserDefaultKey;
    NSUserDefaults  *_zipCodeUserDefaults;
}

@property (nonatomic, copy) NSString *zipCodeNSUserDefaultKey;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;
@property (strong, nonatomic) NSUserDefaults *zipCodeUserDefaults;

- (IBAction)cancelZipCodeEntry:(id)sender;
- (IBAction)saveZipCodeEntry:(id)sender;

@end
