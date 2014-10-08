//
//  TestTableViewCellWithDataSource.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "TestTableViewCellWithDataSource.h"

@implementation TestTableViewCellWithDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isDataSet = NO;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSObject *)data
{
    self.isDataSet = YES;
    self.textLabel.text = [NSString stringWithFormat:@"Title %@", data];
    self.detailTextLabel.text = [NSString stringWithFormat:@"Detail %@", data];
}

@end
