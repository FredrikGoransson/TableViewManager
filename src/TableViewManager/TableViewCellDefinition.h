//
//  TableViewCellDefinition.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewCellDefinition : NSObject

@property (nonatomic, strong) NSObject *data;

@end

@protocol TableViewCellHeightSpecifier <NSObject>

-(float)height;

@end

@interface TableViewCellDefinitionWithIdentifier : TableViewCellDefinition<TableViewCellHeightSpecifier>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic) float height;

+(TableViewCellDefinitionWithIdentifier*)cellDefinitionWithIdentifier:(NSString*)identifier;
+(TableViewCellDefinitionWithIdentifier*)cellDefinitionWithIdentifier:(NSString*)identifier andHeight:(float)height;

-(instancetype)initWithIdentifier:(NSString*)identifier;
-(instancetype)initWithIdentifier:(NSString*)identifier andHeight:(float)height;

@end

@interface TableViewCellDefinitionWithView : TableViewCellDefinitionWithIdentifier

@property (nonatomic, strong) NSString *nibName;
@property (nonatomic, strong) Class ownerClass;

@end