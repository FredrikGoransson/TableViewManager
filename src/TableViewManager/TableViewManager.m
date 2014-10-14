//
//  TableViewDataSourceAndDelegate.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "TableViewManager.h"
#import "DefaultTableViewCellFactory.h"

@implementation TableViewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sections = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithActionDelegate:(id)actionDelegate
{
    self = [super init];
    if (self) {
        self.sections = [[NSMutableArray alloc] init];
        self.actionDelegate = actionDelegate;
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

-(void)configureCellForActionDelegation:(UITableViewCell*)cell
{
    if( [cell conformsToProtocol:@protocol(TableViewCellDelegateActions)]){
        UITableViewCell<TableViewCellDelegateActions> *cellWithActionDelegation = (UITableViewCell<TableViewCellDelegateActions>*)cell;
        cellWithActionDelegation.actionHandler = self;
    }
}

- (void)EnsureCellFactory
{
    if( self.cellFactory == nil)
    {
        [NSException raise:@"TableViewDataSourceAndDelegate cellFactory is nil" format:@"TableViewDataSourceAndDelegate must have property cellFactory set to an instance conforming to protocol TableViewCellFactory"];
    }
}

-(void)handleAction:(SEL)selector withSender:(id)sender
{
    if(self.actionDelegate != nil && [self.actionDelegate respondsToSelector:selector])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // Note, we should only do this for IBAction type selectors (or selectors with void as returntype)
        // Since the selector (aSelector) is returning void, it doesn't make sense to try to obtain the return result of performSelector. In fact, if we do, it crashes the app.
        [self.actionDelegate performSelector:selector withObject:sender];
#pragma clang diagnostic pop
    }
}

-(CGFloat)tableViewRowHeight:(UITableView*)tableView
{
    return tableView.rowHeight > 0 ? tableView.rowHeight : UITableViewAutomaticDimension;
}

-(BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return [super conformsToProtocol:aProtocol] || [self.actionDelegate conformsToProtocol:aProtocol];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [super respondsToSelector:aSelector] || [self.actionDelegate respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self.actionDelegate respondsToSelector:aSelector])
    {
        return self.actionDelegate;
    }
    return nil;
}

#pragma mark - Table View Delegate

// Variable height support

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableViewRowHeight:tableView];
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
    
    return [self tableViewRowHeight:tableView];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( self.actionDelegate && [self.actionDelegate respondsToSelector:@selector(cellSelected:)])
    {
        TableViewCellDefinition *cellDefinition = [self cellForIndexPath:indexPath];
        [self.actionDelegate cellSelected:cellDefinition];
    }
}

#pragma mark - Table View Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self EnsureCellFactory];
    
    TableViewCellDefinition *cellDefinition = [self cellForIndexPath:indexPath];
    UITableViewCell *cell = [self.cellFactory cellWith:cellDefinition];
    [self configureCellForActionDelegation:cell];
    return cell;
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
