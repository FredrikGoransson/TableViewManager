//
//  ViewController.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewManager.h"
#import "STCollapseTableView.h"
#import "SampleDataEntity.h"
#import "TableViewCellActionSource.h"
#import "TableViewManagerDelegate.h"

@interface ViewController : UIViewController<TableViewManagerDelegate, STCollapseTableViewDelegate>

@property (nonatomic, strong) SampleDataEntity *dataEntity;
@property (nonatomic, strong) TableViewManager *source;
@property (weak, nonatomic) IBOutlet STCollapseTableView *tableView;

@end

