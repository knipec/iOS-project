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
    }
    return self;
}

- (id)initFromDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.locationName = [dictionary objectForKey:@"locationname"];
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
    return toReturn;
}

@end
