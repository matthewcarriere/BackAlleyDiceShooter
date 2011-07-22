//
//  WagerTableViewCell.m
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-21.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "WagerTableViewCell.h"

@implementation WagerTableViewCell

@synthesize gameName;
@synthesize gameDescription;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
