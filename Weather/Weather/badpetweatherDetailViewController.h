//
//  badpetweatherDetailViewController.h
//  Weather
//
//  Created by  on 4/14/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "badpetweatherLocation.h"

@interface badpetweatherDetailViewController : UIViewController <NSURLConnectionDelegate>
{
    NSData *_receivedData;
}
@property (strong, nonatomic) badpetweatherLocation *detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) NSData *receivedData;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *imageLabel;

@property (weak, nonatomic) IBOutlet UILabel *suggestionLabel;

@property (weak, nonatomic) IBOutlet UILabel *animalLabel;

@property (weak, nonatomic) IBOutlet UILabel *rationaleLabel;

@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;

@property (weak, nonatomic) IBOutlet UILabel *highLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *precipLabel;
@property (weak, nonatomic) IBOutlet UILabel *precipLabel2;


@property (weak, nonatomic) IBOutlet UISegmentedControl *TempUnitControl;

- (IBAction)tempUnitChanged:(id)sender;

@end
