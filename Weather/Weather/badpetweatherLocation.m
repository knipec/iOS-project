//
//  badpetweatherLocation.m
//  Weather
//
//  Created by Maegereg on 4/18/14.
//
//

#import "badpetweatherLocation.h"

@implementation badpetweatherLocation

- (id)initWithLocationName:(NSString *)locationName
{
    self = [super init];
    if (self)
    {
        self.locationName = locationName;
        self.lastData = nil;
        self.temperatureUnits = 0;
    }
    return self;
}

- (id)initFromDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.locationName = [dictionary objectForKey:@"locationname"];
        self.temperatureUnits = [[dictionary objectForKey:@"temperatureunits"] intValue];
        self.lastData = [[badpetweatherWeatherData alloc] initFromDictionary:dictionary];
    }
    return self;
}

- (NSDictionary*)getDictionaryEquivalent
{
    NSMutableDictionary *toReturn = nil;
    if (self.lastData != nil)
    {
        toReturn = [self.lastData getDictionaryEquivalent];
    }
    if (toReturn == nil)
    {
        toReturn = [[NSMutableDictionary alloc] init];
    }
    
    [toReturn setObject:self.locationName forKey:@"locationname"];
    [toReturn setObject:[NSNumber numberWithInt:self.temperatureUnits] forKey:@"temperatureunits"];
    return toReturn;
}

@end
