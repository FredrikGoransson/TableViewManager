//
//  TestTableViewCellWithDataSource.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellDataSource.h"

@interface TestTableViewCellWithDataSource : UITableViewCell<TableViewCellDataSource>

@property (nonatomic) BOOL isDataSet;

@end
