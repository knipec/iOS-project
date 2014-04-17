//
//  badpetweatherDetailViewController.m
//  Weather
//
//  Created by  on 4/14/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "badpetweatherDetailViewController.h"
#import "badpetweatherWeatherData.h"

@interface badpetweatherDetailViewController ()
- (void)configureView;
@end

@implementation badpetweatherDetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize receivedData = _receivedData;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
        self.detailDescriptionLabel.text = @"Loading data...";
        self.detailDescriptionLabel.text = [@"api.openweathermap.org/data/2.5/weather?q=" stringByAppendingString:[self.detailItem description]];
        
        NSURL *url = [[NSURL alloc] initWithString:[@"http://api.openweathermap.org/data/2.5/weather?q=" stringByAppendingString:[self.detailItem description]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.detailDescriptionLabel.text = [error localizedDescription];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.receivedData = data;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *stringData = [[NSString alloc] initWithData:self.receivedData encoding: [NSString defaultCStringEncoding]];
    NSError *jsonParseError = nil;
    NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:self.receivedData options:0 error:&jsonParseError];
    badpetweatherWeatherData *weatherObject = [[badpetweatherWeatherData alloc] init];
    weatherObject.name = [weatherData objectForKey: @"name"];
    NSDictionary *mainData =[weatherData objectForKey:@"main"];
    weatherObject.temperature = [[mainData objectForKey:@"temp"] floatValue];
    weatherObject.high = [[mainData objectForKey:@"temp_max"] floatValue];
    weatherObject.low = [[mainData objectForKey:@"temp_min"] floatValue];
    weatherObject.windspeed = [[[weatherData objectForKey:@"wind"] objectForKey:@"speed"] floatValue];
    weatherObject.rain = [[[weatherData objectForKey:@"rain"] objectForKey:@"3h"] floatValue];
    weatherObject.snow = [[[weatherData objectForKey:@"snow"] objectForKey:@"3h"] floatValue];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.detailDescriptionLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
