//
//  TableViewCellFactory.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TableViewCellDefinition.h"
#import "TableViewSectionDefinition.h"

@protocol TableViewCellFactory <NSObject>

-(UITableViewCell*)cellWith:(TableViewCellDefinition *)cellDefinition;
-(UIView*)sectionHeaderWith:(TableViewSectionDefinition *)sectionDefinition;
-(UIView*)sectionFooterWith:(TableViewSectionDefinition *)sectionDefinition;

@end
