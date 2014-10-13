//
//  Section1Cell2TableViewCell.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 10/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellActionSource.h"

@interface Section1Cell2TableViewCell : UITableViewCell<TableViewCellDelegateActions>

@property (nonatomic, weak) id<TableViewCellActionHandler> actionHandler;

- (IBAction)buttonTapped:(UIButton *)sender;
- (IBAction)switchSwitched:(UISwitch *)sender;

@end
