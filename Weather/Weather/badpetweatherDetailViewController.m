//
//  badpetweatherDetailViewController.m
//  Weather
//
//  Created by  on 4/14/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "badpetweatherDetailViewController.h"

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
        self.detailDescriptionLabel.text = [@"api.openweathermap.org/data/2.5/find?q=" stringByAppendingString:[self.detailItem description]];
        
        NSURL *url = [[NSURL alloc] initWithString:[@"http://api.openweathermap.org/data/2.5/find?q=" stringByAppendingString:[self.detailItem description]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        self.receivedData = [NSMutableData dataWithLength:4096];
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.detailDescriptionLabel.text = [error localizedDescription];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *data =[[NSString alloc] initWithData:self.receivedData encoding:[NSString defaultCStringEncoding]];
    self.detailDescriptionLabel.text = data;
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
