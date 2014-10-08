//
//  TableViewDataSourceAndDelegate.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "TableViewDataSourceAndDelegate.h"

@implementation TableViewDataSourceAndDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sections = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - helper methods

-(void)addSection:(TableViewSectionDefinition*)sectionDefinition
{
    [self.sections addObject:sectionDefinition];
}

-(TableViewSectionDefinition*)sectionAtIndex:(NSInteger)index
{
    return (TableViewSectionDefinition*)[self.sections objectAtIndex:index];
}

-(TableViewCellDefinition*)cellForIndexPath:(NSIndexPath*)indexPath
{
    if( self.cellFactory != nil)
    {
        TableViewSectionDefinition *sectionDefinition = [self sectionAtIndex:indexPath.section];
        TableViewCellDefinition *cellDefinition = [sectionDefinition cellAtRow:indexPath.row];
        return cellDefinition;
    }
    return nil;
}

#pragma mark - Table View Delegate

// Variable height support

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if( self.cellFactory != nil)
    {
        TableViewCellDefinition *cellDefinition = [self cellForIndexPath:indexPath];
        UITableViewCell *cell = [self.cellFactory cellWith:cellDefinition];
        return cell.bounds.size.height;
    }*/
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( self.cellFactory != nil)
    {
        TableViewCellDefinition *cellDefinition = [self cellForIndexPath:indexPath];
        if( [cellDefinition conformsToProtocol:@protocol(TableViewCellHeightSpecifier)])
        {
            id<TableViewCellHeightSpecifier> heightSpecifier = (id<TableViewCellHeightSpecifier>)cellDefinition;
            float height = [heightSpecifier height];
            if( height >= 0) return height;
        }
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return -1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return -1;
}

#pragma mark - Table View Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( self.cellFactory != nil)
    {
        TableViewCellDefinition *cellDefinition = [self cellForIndexPath:indexPath];
        return [self.cellFactory cellWith:cellDefinition];
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TableViewSectionDefinition *sectionDefinition = (TableViewSectionDefinition*)[self.sections objectAtIndex:section];
    return [sectionDefinition.cells count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 0;
}

@end
