//
//  badpetweatherDetailViewController.h
//  Weather
//
//  Created by  on 4/14/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface badpetweatherDetailViewController : UIViewController <NSURLConnectionDelegate>
{
    NSMutableData *_receivedData;
}
@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) NSMutableData *receivedData;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
