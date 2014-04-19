//
//  badpetweatherWeatherData.m
//  Weather
//
//  Created by Maegereg on 4/16/14.
//
//

#import "badpetweatherWeatherData.h"

@implementation badpetweatherWeatherData

- (id)initFromDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.name = [dictionary objectForKey:@"name"];
        self.temperature = [[dictionary objectForKey:@"temperature"] floatValue];
        self.high = [[dictionary objectForKey:@"high"] floatValue];
        self.low = [[dictionary objectForKey:@"low"] floatValue];
        self.windspeed = [[dictionary objectForKey:@"windspeed"] floatValue];
        self.rain = [[dictionary objectForKey:@"rain"] floatValue];
        self.snow = [[dictionary objectForKey:@"snow"] floatValue];
    }
    if (self.name == nil)
    {
        return nil;
    }
    return self;
}

- (NSMutableDictionary*)getDictionaryEquivalent
{
    //If there wasn't stored WeatherData in the dictionary, return nil
    if (self.name == nil) {
        return nil;
    }
    NSMutableDictionary *toReturn = [[NSMutableDictionary alloc] init];
    [toReturn setObject:self.name forKey:@"name"];
    [toReturn setObject:[NSNumber numberWithFloat: self.temperature] forKey:@"temperature"];
    [toReturn setObject:[NSNumber numberWithFloat: self.high] forKey:@"high"];
    [toReturn setObject:[NSNumber numberWithFloat: self.low] forKey:@"low"];
    [toReturn setObject:[NSNumber numberWithFloat: self.windspeed] forKey:@"windspeed"];
    [toReturn setObject:[NSNumber numberWithFloat: self.rain] forKey:@"rain"];
    [toReturn setObject:[NSNumber numberWithFloat: self.snow] forKey:@"snow"];
    return toReturn;
}

@end
