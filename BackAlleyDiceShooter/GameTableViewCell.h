//
//  WagerTableViewCell.h
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-21.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *description;

@end
