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
                cell = [[[NSBundle bundleForClass:cellDefinitionWithView.ownerClass] loadNibNamed:cellDefinitionWithView.nibName owner:cellOwner options:nil] firstObject];
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
        else
        {
            NSString *dataAsString = [NSString stringWithFormat:@"%@", cellDefinition.data];
            cell.textLabel.text = dataAsString;
        }
    }
    
    return cell;
}

-(UIView *)sectionFooterWith:(TableViewSectionDefinition *)sectionDefinition
{
    return nil;
}

-(UIView *)sectionHeaderWith:(TableViewSectionDefinition *)sectionDefinition
{
    return nil;
}

@end
