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
@synthesize imageView = _imageView;
@synthesize rationaleLabel = _rationaleLabel;
@synthesize weatherLabel = _weatherLabel;

static const int F = 0;
static const int C = 1;
static const int K = 2;

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
        // Get weather data
        self.weatherLabel.text = @"Loading data...";
        self.weatherLabel.text = [@"api.openweathermap.org/data/2.5/weather?q=" stringByAppendingString:[self.detailItem description]];
        
        NSURL *url = [[NSURL alloc] initWithString:[@"http://api.openweathermap.org/data/2.5/weather?q=" stringByAppendingString:[self.detailItem description]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
        
        
        self.navigationItem.title = self.detailItem;
    }
}

- (void)setImage:(badpetweatherWeatherData *) weatherObject
{
    UIImage *image;
    NSString *animal;
    NSString *rationale;
    
    if (weatherObject.rain > 0.1) {
        image = [UIImage imageNamed:@"manatee.JPG"];
        animal = @"A MANATEE";
        rationale = @"because rain";
    }
    else if (weatherObject.snow > 10) {
        image = [UIImage imageNamed:@"polarBear.jpg"];
        animal = @"A POLAR BEAR";
        rationale = @"because it's goddamn snowy";
    }
    else if (weatherObject.temperature < 1) {
        // This should never happen
        animal = @"NO PETS ALSO YOU ARE VERY DEAD";
        rationale = @"so dead";
    }
    else if (weatherObject.temperature < 70 || weatherObject.temperature > 340) {
        image = [UIImage imageNamed:@"tardigrade.jpg"];
        animal = @"A TARDIGRADE. YOU'LL BE DEAD THOUGH";
        rationale = @"how did this happen";
    }
    else if (weatherObject.temperature < 256) {
        image = [UIImage imageNamed:@"polarBear.jpg"];
        animal = @"A POLAR BEAR";
        rationale = @"because it's goddamn cold";
    }
    else if (weatherObject.temperature < 302) {
        image = [UIImage imageNamed:@"puppies.jpg"];
        animal = @"A PUPPY";
        rationale = @"always puppies";
    }
    else if (weatherObject.temperature > 302) {
        image = [UIImage imageNamed:@"camel.jpg"];
        animal = @"A CAMEL";
        rationale = @"it's so hot you're probably in the desert";
    }
    self.imageView.image = image;
    self.animalLabel.text = animal;
    self.animalLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.rationaleLabel.text = rationale;
}

- (void)setWeatherText:(badpetweatherWeatherData *)weatherObject
{
    NSMutableString *weatherText = [NSMutableString string];
    NSString *tempText = [self getTemp:weatherObject.temperature toUnits:F];
    [weatherText appendString:tempText];
    self.weatherLabel.text = weatherText;
}

- (NSString *)getTemp:(float)tempInKelvin toUnits:(int)units
{
    float temperature;
    if (units == F) {
        temperature = (9.0 / 5) * (tempInKelvin - 273) + 32;
    }
    else if (units == C) {
        temperature = tempInKelvin - 273.15;
    }
    else {
        temperature = tempInKelvin;
    }
    NSMutableString *tempString = [NSMutableString stringWithFormat:@"%0.2f", temperature];
    [tempString appendString:@"\u00B0"];
    return [NSString stringWithString:tempString];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.weatherLabel.text = [error localizedDescription];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.receivedData = data;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *jsonParseError = nil;
    NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:self.receivedData options:0 error:&jsonParseError];
    badpetweatherWeatherData *weatherObject = [[badpetweatherWeatherData alloc] init];
    weatherObject.name = [weatherData objectForKey: @"name"];
    NSDictionary *mainData =[weatherData objectForKey:@"main"];
    // Kelvin
    weatherObject.temperature = [[mainData objectForKey:@"temp"] floatValue];
    weatherObject.high = [[mainData objectForKey:@"temp_max"] floatValue];
    weatherObject.low = [[mainData objectForKey:@"temp_min"] floatValue];
    // Meters/Sec
    weatherObject.windspeed = [[[weatherData objectForKey:@"wind"] objectForKey:@"speed"] floatValue];
    // Millimeters per 3 hours
    weatherObject.rain = [[[weatherData objectForKey:@"rain"] objectForKey:@"3h"] floatValue];
    weatherObject.snow = [[[weatherData objectForKey:@"snow"] objectForKey:@"3h"] floatValue];
    
    [self setWeatherText:weatherObject];
    [self setImage:weatherObject];
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
    self.weatherLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
