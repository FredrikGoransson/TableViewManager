//
//  Section0Cell1TableViewCell.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 09/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellDataSource.h"
#import "SampleDataEntity.h"

@interface Section0Cell1TableViewCell : UITableViewCell<TableViewCellDataSource>
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;

@end
