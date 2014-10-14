//
//  Section0HeaderView.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 09/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewSectionDataSource.h"
#import "SampleDataEntity.h"

@interface Section0HeaderView : UITableViewHeaderFooterView<TableViewSectionDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end
