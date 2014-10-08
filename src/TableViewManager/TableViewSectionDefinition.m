//
//  TableViewSectionDefinition.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "TableViewSectionDefinition.h"

@implementation TableViewSectionDefinition

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cells = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addCell:(TableViewCellDefinition*)cellDefinition
{
    [self.cells addObject:cellDefinition];
}

-(TableViewCellDefinition*)cellAtRow:(NSInteger)row
{
    return (TableViewCellDefinition*)[self.cells objectAtIndex:row];
}

@end

@implementation TableViewSectionDefinitionWithIdentifier

@end

@implementation TableViewSectionDefinitionWithView

@end
