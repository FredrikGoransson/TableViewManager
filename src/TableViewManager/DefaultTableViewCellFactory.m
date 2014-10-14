//
//  DefaultTableViewCellFactory.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "DefaultTableViewCellFactory.h"

@implementation DefaultTableViewCellFactory {
    UITableView *tableView;
    NSMutableDictionary *cachedViews;
    NSMutableArray *registeredCellIdentifiers;
    NSMutableArray *registeredSectionIdentifiers;
}

-(instancetype)initWithTableView:(UITableView*)aTableView
{
    self = [super init];
    if (self) {
        tableView = aTableView;
        cachedViews = [[NSMutableDictionary alloc] init];
        
        registeredCellIdentifiers = [[NSMutableArray alloc] init];
        registeredSectionIdentifiers = [[NSMutableArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMemoryWarning:) name: UIApplicationDidReceiveMemoryWarningNotification object:nil];

    }
    return self;
}

- (void) handleMemoryWarning:(NSNotification *)notification
{
    [cachedViews removeAllObjects];
}

-(UITableViewCell*)cellWith:(TableViewCellDefinition *)cellDefinition
{
    UITableViewCell *cell;
    
    NSString *identifier;
    if ([cellDefinition isKindOfClass:[TableViewCellDefinitionWithIdentifier class]])
    {
        TableViewCellDefinitionWithIdentifier *cellDefinitionWithIdentifier = (TableViewCellDefinitionWithIdentifier*)cellDefinition;
        identifier = cellDefinitionWithIdentifier.identifier;
    }
    
    if( [cellDefinition isKindOfClass:[TableViewCellDefinitionWithView class]])
    {
        TableViewCellDefinitionWithView *cellDefinitionWithView = (TableViewCellDefinitionWithView*)cellDefinition;
        if( identifier == nil)
        {
            identifier = [NSString stringWithFormat:@"Identifier-for-TableViewCellDefinitionWithView-%p", cellDefinition];
        }
        if( ![registeredCellIdentifiers containsObject:identifier])
        {
            NSString *nibName = cellDefinitionWithView.nibName;
            if( nibName == nil)
            {
                nibName = NSStringFromClass(cellDefinitionWithView.ownerClass);
            }
            UINib *cellNib = [UINib nibWithNibName:nibName bundle:nil];
            [tableView registerNib:cellNib forCellReuseIdentifier:identifier];
            [registeredCellIdentifiers addObject:identifier];
        }
    }
    
    if( identifier != nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if( cell == nil)
        {
            [NSException raise:@"DefaultTableViewCellFactory cellWith: cannot dequeue cell with identifier" format:@"DefaultTableViewCellFactory cellWith:CellDefinition cannot dequeue cell with identifier %@", identifier];
        }
    }
    else
    {
        NSString *randomIdentifier = [NSString stringWithFormat:@"TableViewCell-%p", cellDefinition];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:randomIdentifier];
    }
    
    if( cell == nil)
    {
        [NSException raise:@"DefaultTableViewCellFactory cellWith: is nil" format:@"DefaultTableViewCellFactory cellWith:CellDefinition could not create a TableViewCell"];

    }

    if( cell != nil)
    {
        if( [cell conformsToProtocol:@protocol(TableViewCellDataSource)]){
            UITableViewCell<TableViewCellDataSource> *cellWithDataSource = (UITableViewCell<TableViewCellDataSource>*)cell;
            [cellWithDataSource setData:cellDefinition.data];
        }
        else if( [cellDefinition.data isKindOfClass:[NSString class]])
        {
            NSString *dataAsString = (NSString*)cellDefinition.data;
            cell.textLabel.text = dataAsString;
        }
    }
    
    return cell;
}

-(UIView*)headerViewWith:(TableViewSectionDefinition*)sectionDefinition
{
    UIView *headerView;
    NSString *identifier;
    
    if ([sectionDefinition isKindOfClass:[TableViewSectionDefinitionWithHeaderIdentifier class]])
    {
        TableViewSectionDefinitionWithHeaderIdentifier *sectionHeaderDefinitionWithIdentifier = (TableViewSectionDefinitionWithHeaderIdentifier*)sectionDefinition;
        identifier = sectionHeaderDefinitionWithIdentifier.identifier;
    }
    
    if( [sectionDefinition isKindOfClass:[TableViewSectionDefinitionWithHeaderView class]])
    {
        TableViewSectionDefinitionWithHeaderView *sectionDefinitionWithHeaderView = (TableViewSectionDefinitionWithHeaderView*)sectionDefinition;
        NSString *nibName = sectionDefinitionWithHeaderView.nibName;
        if( nibName == nil)
        {
            nibName = NSStringFromClass(sectionDefinitionWithHeaderView.ownerClass);
        }
        if( identifier == nil)
        {
            identifier = [NSString stringWithFormat:@"Identifier-for-TableViewSectionDefinitionWithView-%@", nibName];
        }
        if( ![registeredSectionIdentifiers containsObject:identifier])
        {
            
            UINib *cellNib = [UINib nibWithNibName:nibName bundle:nil];
            [tableView registerNib:cellNib forHeaderFooterViewReuseIdentifier:identifier];
            [registeredSectionIdentifiers addObject:identifier];
        }
    }
    
    if (identifier != nil)
    {
        headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    }

    if( headerView != nil)
    {
        if( [headerView conformsToProtocol:@protocol(TableViewSectionDataSource)]){
            UIView<TableViewSectionDataSource> *headerViewWithDataSource = (UIView<TableViewSectionDataSource>*)headerView;
            [headerViewWithDataSource setData:sectionDefinition.data];
        }
    }

    return headerView;
}

@end
