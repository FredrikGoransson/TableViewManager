//
//  TableViewDataSourceAndDelegate.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TableViewCellFactory.h"

@interface TableViewDataSourceAndDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) id<TableViewCellFactory> cellFactory;
@property (nonatomic, strong) NSMutableArray *sections;

-(void)addSection:(TableViewSectionDefinition*)sectionDefinition;
-(TableViewSectionDefinition*)sectionAtIndex:(NSInteger)index;

@end