//
//  WagerViewController.h
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-19.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WagerViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UIPickerView *wagerPicker;
@property (nonatomic, retain) NSArray *wagers;
@property (nonatomic, retain) IBOutlet NSString *gameName;

@end
