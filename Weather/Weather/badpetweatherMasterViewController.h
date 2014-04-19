//
//  badpetweatherMasterViewController.h
//  Weather
//
//  Created by  on 4/14/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface badpetweatherMasterViewController : UITableViewController <UIAlertViewDelegate>

- (void)setArray:(NSMutableArray *)array;

- (NSMutableArray *)getArray;

@end
