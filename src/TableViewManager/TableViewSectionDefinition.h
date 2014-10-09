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

@protocol TableViewSectionHeightSpecifier <NSObject>

-(float)headerHeight;
-(float)footerHeight;

@end

@interface TableViewSectionDefinitionWithHeaderIdentifier : TableViewSectionDefinition<TableViewSectionHeightSpecifier>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic) float headerHeight;
@property (nonatomic) float footerHeight;

- (instancetype)initWithIdentifier:(NSString*)identifier;
+ (TableViewSectionDefinitionWithHeaderIdentifier*)sectionWithIdentifier:(NSString*)identifier;

@end

@interface TableViewSectionDefinitionWithHeaderView : TableViewSectionDefinitionWithHeaderIdentifier

@property (nonatomic, strong) NSString *nibName;
@property (nonatomic, strong) Class ownerClass;

- (instancetype)initWithOwnerClass:(Class)ownerClass;
- (instancetype)initWithOwnerClass:(Class)ownerClass andNibName:(NSString*)nibName;
+ (TableViewSectionDefinitionWithHeaderView*)sectionWithOwnerClass:(Class)ownerClass;
+ (TableViewSectionDefinitionWithHeaderView*)sectionWithOwnerClass:(Class)ownerClass andNibName:(NSString*)nibName;

@end