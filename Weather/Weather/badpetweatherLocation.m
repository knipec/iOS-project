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

@end
