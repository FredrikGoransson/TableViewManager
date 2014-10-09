//
//  ViewController.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewDataSourceAndDelegate.h"
#import "STCollapseTableView.h"
#import "SampleDataEntity.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) SampleDataEntity *dataEntity;
@property (nonatomic, strong) TableViewDataSourceAndDelegate *source;
@property (weak, nonatomic) IBOutlet STCollapseTableView *tableView;

@end

