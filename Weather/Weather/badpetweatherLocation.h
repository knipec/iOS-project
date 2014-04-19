//
//  badpetweatherLocation.h
//  Weather
//
//  Created by Maegereg on 4/18/14.
//
//

#import <Foundation/Foundation.h>
#import "badpetweatherWeatherData.h"

@interface badpetweatherLocation : NSObject

@property NSString *locationName;

@property badpetweatherWeatherData *lastData;

- (id)initWithLocationName:(NSString *)locationName;

- (id)initFromDictionary:(NSDictionary *)dictionary;

- (NSDictionary*)getDictionaryEquivalent;

@end
