//
//  TableViewDataSourceAndDelegate.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "TableViewDataSourceAndDelegate.h"
#import "DefaultTableViewCellFactory.h"

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

- (void)EnsureCellFactory
{
    if( self.cellFactory == nil)
    {
        [NSException raise:@"TableViewDataSourceAndDelegate cellFactory is nil" format:@"TableViewDataSourceAndDelegate must have property cellFactory set to an instance conforming to protocol TableViewCellFactory"];
    }
}

#pragma mark - Table View Delegate

// Variable height support

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self EnsureCellFactory];
    
    TableViewCellDefinition *cellDefinition = [self cellForIndexPath:indexPath];
    if( [cellDefinition conformsToProtocol:@protocol(TableViewCellHeightSpecifier)])
    {
        id<TableViewCellHeightSpecifier> heightSpecifier = (id<TableViewCellHeightSpecifier>)cellDefinition;
        float height = [heightSpecifier height];
        if( height >= 0) return height;
    }
    if ( [cellDefinition isKindOfClass:[TableViewCellDefinitionWithView class]])
    {
        UITableViewCell *cell = [self.cellFactory cellWith:cellDefinition];
        if([cell conformsToProtocol:@protocol(TableViewCellHeightSpecifier)])
        {
            id<TableViewCellHeightSpecifier> heightSpecifier = (id<TableViewCellHeightSpecifier>)cell;
            float height = [heightSpecifier height];
            if( height >= 0) return height;
        }
        return cell.frame.size.height;
    }
    
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    [self EnsureCellFactory];
    
    TableViewSectionDefinition *sectionDefinition = [self sectionAtIndex:section];
    if( [sectionDefinition conformsToProtocol:@protocol(TableViewSectionHeightSpecifier) ])
    {
        id<TableViewSectionHeightSpecifier> heightSpecifier = (id<TableViewSectionHeightSpecifier>)sectionDefinition;
        float height = [heightSpecifier headerHeight];
        if( height >= 0) return height;
    }
    if ( [sectionDefinition isKindOfClass:[TableViewSectionDefinitionWithHeaderView class]])
    {
        UIView *view = [self.cellFactory headerViewWith:sectionDefinition];
        return view.frame.size.height;
    }
    
    return tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    [self EnsureCellFactory];
    
    TableViewSectionDefinition *sectionDefinition = [self sectionAtIndex:section];
    if( [sectionDefinition conformsToProtocol:@protocol(TableViewSectionHeightSpecifier) ])
    {
        id<TableViewSectionHeightSpecifier> heightSpecifier = (id<TableViewSectionHeightSpecifier>)sectionDefinition;
        float height = [heightSpecifier footerHeight];
        if( height >= 0) return height;
    }
    
    return tableView.sectionFooterHeight;
}

#pragma mark - Table View Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self EnsureCellFactory];
    
    TableViewCellDefinition *cellDefinition = [self cellForIndexPath:indexPath];
    return [self.cellFactory cellWith:cellDefinition];
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    [self EnsureCellFactory];
    
    TableViewSectionDefinition *sectionDefinition = [self sectionAtIndex:section];
    return [self.cellFactory headerViewWith:sectionDefinition];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TableViewSectionDefinition *sectionDefinition = [self sectionAtIndex:section];
    if( sectionDefinition.data == nil ) return nil;
    NSString *title = [NSString stringWithFormat:@"%@", sectionDefinition.data];
    
    return title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

@end
