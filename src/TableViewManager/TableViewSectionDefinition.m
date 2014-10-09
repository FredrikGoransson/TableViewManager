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

@implementation TableViewSectionDefinitionWithHeaderIdentifier

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerHeight = -1;
        self.footerHeight = -1;
        self.identifier = nil;

    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString*)aIdentifier
{
    self = [super init];
    if (self) {
        self.headerHeight = -1;
        self.footerHeight = -1;
        self.identifier = aIdentifier;
    }
    return self;
}
+ (TableViewSectionDefinitionWithHeaderIdentifier*)sectionWithIdentifier:(NSString*)aIdentifier
{
    return [[TableViewSectionDefinitionWithHeaderIdentifier alloc] initWithIdentifier:aIdentifier];
}

@end

@implementation TableViewSectionDefinitionWithHeaderView

- (instancetype)initWithOwnerClass:(Class)aOwnerClass
{
    self = [super init];
    if (self) {
        self.ownerClass = aOwnerClass;
    }
    return self;
}

- (instancetype)initWithOwnerClass:(Class)aOwnerClass andNibName:(NSString*)aNibName
{
    self = [super init];
    if (self) {
        self.ownerClass = aOwnerClass;
        self.nibName = aNibName;
    }
    return self;
}

+ (TableViewSectionDefinitionWithHeaderView*)sectionWithOwnerClass:(Class)aOwnerClass
{
    return [[TableViewSectionDefinitionWithHeaderView alloc] initWithOwnerClass:aOwnerClass];
}

+ (TableViewSectionDefinitionWithHeaderView*)sectionWithOwnerClass:(Class)aOwnerClass andNibName:(NSString*)aNibName
{
    return [[TableViewSectionDefinitionWithHeaderView alloc] initWithOwnerClass:aOwnerClass andNibName:aNibName];
}

@end
