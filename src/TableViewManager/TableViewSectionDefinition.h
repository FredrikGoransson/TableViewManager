//
//  TableViewSectionDefinition.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewCellDefinition.h"

@interface TableViewSectionDefinition : NSObject

@property (nonatomic, strong) NSObject *data;
@property (nonatomic, strong) NSMutableArray *cells;

-(void)addCell:(TableViewCellDefinition*)cellDefinition;
-(TableViewCellDefinition*)cellAtRow:(NSInteger)row;

@end

@interface TableViewSectionDefinitionWithIdentifier : TableViewSectionDefinition

@property (nonatomic, strong) NSString *identifier;

@end

@interface TableViewSectionDefinitionWithView : TableViewSectionDefinitionWithIdentifier

@property (nonatomic, strong) NSString *nibName;
@property (nonatomic, strong) Class ownerClass;

@end