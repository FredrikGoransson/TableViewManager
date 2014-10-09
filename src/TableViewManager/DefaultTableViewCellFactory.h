//
//  DefaultTableViewCellFactory.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TableViewCellFactory.h"
#import "TableViewCellDataSource.h"
#import "TableViewSectionDataSource.h"

@interface DefaultTableViewCellFactory : NSObject<TableViewCellFactory>

-(instancetype)initWithTableView:(UITableView*)tableView;

@end
