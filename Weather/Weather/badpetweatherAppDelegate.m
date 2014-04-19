//
//  badpetweatherAppDelegate.m
//  Weather
//
//  Created by  on 4/14/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "badpetweatherAppDelegate.h"
#import "badpetweatherMasterViewController.h"
#import "badpetweatherLocation.h"

@implementation badpetweatherAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self storeInPreferences];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self loadFromPreferences];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)loadFromPreferences
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *serializedLocations = [prefs objectForKey:@"locations"];
    if (serializedLocations != nil)
    {
        NSMutableArray *newBackingArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<[serializedLocations count]; ++i)
        {
            [newBackingArray addObject:[[badpetweatherLocation alloc] initFromDictionary:[serializedLocations objectAtIndex:i]]];
        }
        
        UINavigationController *navController = self.window.rootViewController;
        NSArray *childControllers = [navController viewControllers];
        badpetweatherMasterViewController *masterController = [childControllers objectAtIndex:0];
        
        [masterController setArray:newBackingArray];
    }
}

- (void)storeInPreferences
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    UINavigationController *navController = self.window.rootViewController;
    NSArray *childControllers = [navController viewControllers];
    badpetweatherMasterViewController *masterController = [childControllers objectAtIndex:0];
    
    NSArray *backingArray = [masterController getArray];
    NSMutableArray *serializableArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<[backingArray count]; ++i)
    {
        [serializableArray addObject:[[backingArray objectAtIndex:i] getDictionaryEquivalent]];
    }
    [prefs setObject:serializableArray forKey:@"locations"];
}

@end
