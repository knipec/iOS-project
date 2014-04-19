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

int tempUnits = F;

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
        self.weatherLabel.text = @"Loading...";
        
        NSURL *url = [[NSURL alloc] initWithString:[@"http://api.openweathermap.org/data/2.5/weather?q=" stringByAppendingString:[self urlEncodeString:self.detailItem.locationName]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
  
        self.navigationItem.title = self.detailItem.locationName;
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
    else if (weatherObject.temperature >= 302) {
        image = [UIImage imageNamed:@"camel.jpg"];
        animal = @"A CAMEL";
        rationale = @"it's so hot you're basically in the desert";
        self.suggestionLabel.textColor = [UIColor blackColor];
    }
    self.imageView.image = image;
    self.animalLabel.text = animal;
    self.animalLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.rationaleLabel.text = rationale;
}

- (void)setWeatherText:(badpetweatherWeatherData *)weatherObject
{
    NSMutableString *weatherText = [NSMutableString string];
    NSString *tempText = [self getTemp:weatherObject.temperature toUnits:tempUnits];
    [weatherText appendString:tempText];
    self.weatherLabel.text = weatherText;
    self.highLabel.text = [self getTemp:weatherObject.high toUnits:tempUnits];
    self.lowLabel.text = [self getTemp:weatherObject.low toUnits:tempUnits];
    self.windLabel.text = [NSString stringWithFormat:@"%0.1f %@", weatherObject.windspeed, @"m/s"];
    float rain = weatherObject.rain;
    float snow = weatherObject.snow;
    if (rain > 0 && snow > 0)
    {
        self.precipLabel.text = @"Wintry Mix?";
        self.precipLabel2.text = [NSString stringWithFormat:@"%0.1f %@", (rain+snow), @"mm/hour"];
    }
    else if (rain > 0 && snow >= 0)
    {
        self.precipLabel.text = @"Rain";
        self.precipLabel2.text = [NSString stringWithFormat:@"%0.1f %@", rain, @"mm/hour"];
    }
    else if (rain <= 0 && (snow > 0))
    {
        self.precipLabel.text = @"Snow";
        self.precipLabel2.text = [NSString stringWithFormat:@"%0.1f %@", snow, @"mm/hour"];
    }
    else
    {
        self.precipLabel.text = @"Nothing";
        self.precipLabel2.text = @"is falling from the sky";
        [self.precipLabel2 setFont:[UIFont systemFontOfSize:14]];
    }
    

    
}

// Code taken from http://stackoverflow.com/questions/8086584/objective-c-url-encoding
- (NSString *)urlEncodeString:(NSString *)string
{
    NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[]\" ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}


- (NSString *)getTemp:(float)tempInKelvin toUnits:(int)units
{
    float temperature;
    NSMutableString *tempString;
    if (units == F) {
        temperature = (9.0 / 5) * (tempInKelvin - 273) + 32;
        tempString = [NSMutableString stringWithFormat:@"%0.1f", temperature];
        [tempString appendString:@" \u00B0F"];
    }
    else if (units == C) {
        temperature = tempInKelvin - 273.15;
        tempString = [NSMutableString stringWithFormat:@"%0.1f", temperature];
        [tempString appendString:@" \u00B0C"];
    }
    else {
        temperature = tempInKelvin;
        tempString = [NSMutableString stringWithFormat:@"%0.1f", temperature];
        [tempString appendString:@" K"];
    }
    
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
    // Millimeters per hour
    weatherObject.rain = [[[weatherData objectForKey:@"rain"] objectForKey:@"3h"] floatValue];
    weatherObject.snow = [[[weatherData objectForKey:@"snow"] objectForKey:@"3h"] floatValue];
    // set it to the detail item's last data property
    self.detailItem.lastData = weatherObject;
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

- (IBAction)tempUnitChanged:(id)sender
{
    tempUnits = [_TempUnitControl selectedSegmentIndex];
    badpetweatherWeatherData *weatherObject = self.detailItem.lastData;
    [self setWeatherText:weatherObject];
    
}
@end
