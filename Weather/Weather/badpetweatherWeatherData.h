//
//  badpetweatherWeatherData.h
//  Weather
//
//  Created by Maegereg on 4/16/14.
//
//

#import <Foundation/Foundation.h>

@interface badpetweatherWeatherData : NSObject

@property NSString *name;

@property float temperature;

@property float high;

@property float low;

@property float windspeed;

@property float rain;

@property float snow;

- (id)initFromDictionary:(NSDictionary *)dictionary;

- (NSDictionary*)getDictionaryEquivalent;

@end
