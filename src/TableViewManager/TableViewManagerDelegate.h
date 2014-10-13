//
//  TableViewManagerDelegate.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 13/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewCellDefinition.h"

@protocol TableViewManagerDelegate <NSObject>

-(void)cellSelected:(TableViewCellDefinition*)cellDefinition;

@end
