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
}

-(instancetype)initWithTableView:(UITableView*)aTableView
{
    self = [super init];
    if (self) {
        tableView = aTableView;
        cachedViews = [[NSMutableDictionary alloc] init];
        
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
    
    if( [cellDefinition isKindOfClass:[TableViewCellDefinitionWithView class]])
    {
        TableViewCellDefinitionWithView *cellDefinitionWithView = (TableViewCellDefinitionWithView*)cellDefinition;
        
        NSString *identifier = cellDefinitionWithView.identifier;
        if( identifier == nil)
        {
            identifier = [NSString stringWithFormat:@"Identifier-for-TableViewCellDefinitionWithView-%p", cellDefinition];
        }
        cell = (UITableViewCell*)[cachedViews objectForKey:identifier];
        if( cell == nil )
        {
            if( [cellDefinitionWithView.ownerClass instancesRespondToSelector:@selector(initWithStyle:reuseIdentifier:)])
            {
                UITableViewCell *cellOwner = (UITableViewCell*)[[cellDefinitionWithView.ownerClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDefinitionWithView.identifier];
                NSString *nibName = cellDefinitionWithView.nibName;
                if( nibName == nil)
                {
                    nibName = NSStringFromClass(cellDefinitionWithView.ownerClass);
                }
                cell = [[[NSBundle bundleForClass:cellDefinitionWithView.ownerClass] loadNibNamed:nibName owner:cellOwner options:nil] firstObject];
                [cachedViews setObject:cell forKey:identifier];
            }
        }
    }
    else if ([cellDefinition isKindOfClass:[TableViewCellDefinitionWithIdentifier class]])
    {
        TableViewCellDefinitionWithIdentifier *cellDefinitionWithIdentifier = (TableViewCellDefinitionWithIdentifier*)cellDefinition;
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellDefinitionWithIdentifier.identifier];
    }
    else
    {
        NSString *randomIdentifier = [NSString stringWithFormat:@"TableViewCell-%p", cellDefinition];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:randomIdentifier];
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
    if( [sectionDefinition isKindOfClass:[TableViewSectionDefinitionWithHeaderView class]])
    {
        TableViewSectionDefinitionWithHeaderView *sectionDefinitionWithHeaderView = (TableViewSectionDefinitionWithHeaderView*)sectionDefinition;
        
        NSString *identifier = sectionDefinitionWithHeaderView.identifier;
        if( identifier == nil)
        {
            identifier = [NSString stringWithFormat:@"Identifier-for-TableViewCellDefinitionWithView-%p", sectionDefinition];
        }
        headerView = (UIView*)[cachedViews objectForKey:identifier];
        if( headerView == nil )
        {
            if( [sectionDefinitionWithHeaderView.ownerClass instancesRespondToSelector:@selector(init)])
            {
                UIView *headerViewOwner = (UIView*)[[sectionDefinitionWithHeaderView.ownerClass alloc] init];
                NSString *nibName = sectionDefinitionWithHeaderView.nibName;
                if( nibName == nil)
                {
                    nibName = NSStringFromClass(sectionDefinitionWithHeaderView.ownerClass);
                }
                headerView = [[[NSBundle bundleForClass:sectionDefinitionWithHeaderView.ownerClass] loadNibNamed:nibName owner:headerViewOwner options:nil] firstObject];
                [cachedViews setObject:headerView forKey:identifier];
            }
        }
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
