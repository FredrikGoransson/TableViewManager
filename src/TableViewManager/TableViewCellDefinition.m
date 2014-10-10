//
//  TableViewCellDefinition.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "TableViewCellDefinition.h"

@implementation TableViewCellDefinition

@end

@implementation TableViewCellDefinitionWithIdentifier

+(TableViewCellDefinitionWithIdentifier*)cellDefinitionWithIdentifier:(NSString*)identifier
{
    return [[TableViewCellDefinitionWithIdentifier alloc] initWithIdentifier:identifier];
}

+(TableViewCellDefinitionWithIdentifier*)cellDefinitionWithIdentifier:(NSString*)identifier andHeight:(float)height
{
    return [[TableViewCellDefinitionWithIdentifier alloc] initWithIdentifier:identifier andHeight:height];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = -1;
    }
    return self;
}

-(instancetype)initWithIdentifier:(NSString*)aIdentifier
{
    self = [super init];
    if (self) {
        self.identifier = aIdentifier;
        self.height = -1;
    }
    return self;
}

-(instancetype)initWithIdentifier:(NSString*)aIdentifier andHeight:(float)aHeight
{
    self = [super init];
    if (self) {
        self.identifier = aIdentifier;
        self.height = aHeight;
    }
    return self;
}

@end

@implementation TableViewCellDefinitionWithView

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

+ (TableViewCellDefinitionWithView*)cellWithOwnerClass:(Class)aOwnerClass
{
    return [[TableViewCellDefinitionWithView alloc] initWithOwnerClass:aOwnerClass];
}

+ (TableViewCellDefinitionWithView*)cellWithOwnerClassNamed:(NSString*)aOwnerClassName
{
    Class aOwnerClass = NSClassFromString(aOwnerClassName);
    return [[TableViewCellDefinitionWithView alloc] initWithOwnerClass:aOwnerClass andNibName:aOwnerClassName];
}

+ (TableViewCellDefinitionWithView*)cellWithOwnerClass:(Class)aOwnerClass andNibName:(NSString*)aNibName
{
    return [[TableViewCellDefinitionWithView alloc] initWithOwnerClass:aOwnerClass andNibName:aNibName];
}

@end