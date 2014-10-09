//
//  Section0Cell1TableViewCell.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 09/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "Section0Cell1TableViewCell.h"

@implementation Section0Cell1TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSObject *)data
{
    if( [data isKindOfClass:[SampleDataEntity class]])
    {
        SampleDataEntity *dataEntity = (SampleDataEntity*)data;
        self.headingLabel.text = dataEntity.heading;
    }
}

@end
