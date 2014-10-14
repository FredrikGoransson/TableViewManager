//
//  ViewController.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "ViewController.h"
#import "DefaultTableViewCellFactory.h"
#import "Section0HeaderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupData];
    [self setupDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData
{
    self.dataEntity = [[SampleDataEntity alloc] init];
    self.dataEntity.heading = @"Sample Heading";
    self.dataEntity.title = @"Sample title";
    self.dataEntity.showMidSection = NO;
    self.dataEntity.subData = [[NSMutableArray alloc] initWithObjects:
                               [[SampleDataSubEntity alloc] initWithValue:@"Hello"],
                               [[SampleDataSubEntity alloc] initWithValue:@"World"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Foo"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Bar"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Hello"],
                               [[SampleDataSubEntity alloc] initWithValue:@"World"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Foo"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Bar"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Hello"],
                               [[SampleDataSubEntity alloc] initWithValue:@"World"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Foo"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Bar"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Hello"],
                               [[SampleDataSubEntity alloc] initWithValue:@"World"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Foo"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Bar"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Hello"],
                               [[SampleDataSubEntity alloc] initWithValue:@"World"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Foo"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Bar"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Hello"],
                               [[SampleDataSubEntity alloc] initWithValue:@"World"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Foo"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Bar"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Hello"],
                               [[SampleDataSubEntity alloc] initWithValue:@"World"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Foo"],
                               [[SampleDataSubEntity alloc] initWithValue:@"Bar"],
                                nil];
    
}

- (void)setupDataSource
{
    // Note: Init with actionDelegate:self 'forwards' all selectors to self that are performed on TableViewCells
    self.source = [[TableViewManager alloc] initWithActionDelegate:self];
    
    // Section 0
    TableViewSectionDefinitionWithHeaderIdentifier *section0 = [TableViewSectionDefinitionWithHeaderIdentifier sectionWithIdentifier:@"Section0Identifier"];
    section0.data = @"Overview";
    [self.source addSection:section0];

    TableViewCellDefinitionWithIdentifier *cell00 = [TableViewCellDefinitionWithIdentifier cellDefinitionWithIdentifier:@"Section0Cell0Identifier"];
    cell00.data = self.dataEntity;
    [section0 addCell:cell00];
    
    TableViewCellDefinitionWithIdentifier *cell01 = [TableViewCellDefinitionWithIdentifier cellDefinitionWithIdentifier:@"Section0Cell1Identifier"];
    cell01.data = self.dataEntity;
    [section0 addCell:cell01];
    
    
    // Section 1
    TableViewSectionDefinitionWithHeaderView *section1 = [TableViewSectionDefinitionWithHeaderView sectionWithOwnerClass:[Section0HeaderView class]];
    section1.data = self.dataEntity;
    [self.source addSection:section1];
    for (NSString *subEntity in self.dataEntity.subData)
    {
        TableViewCellDefinitionWithIdentifier *subCell = [TableViewCellDefinitionWithIdentifier cellDefinitionWithIdentifier:@"Section1Cell0Identifier"];
        subCell.data = subEntity;
        [section1 addCell:subCell];
    }
    
    // Section 2
    TableViewSectionDefinitionWithHeaderView *section2 = [TableViewSectionDefinitionWithHeaderView sectionWithOwnerClass:[Section0HeaderView class]];
    section2.data = @"Details";
    [self.source addSection:section2];

    TableViewCellDefinitionWithView *cell20 = [TableViewCellDefinitionWithView cellWithOwnerClassNamed:@"Section1Cell2TableViewCell"];
    cell20.data = self.dataEntity;
    [section2 addCell:cell20];

    
    
    self.tableView.dataSource = self.source;
    self.tableView.delegate = self.source;
    
    DefaultTableViewCellFactory *cellFactory = [[DefaultTableViewCellFactory alloc] initWithTableView:self.tableView];
    self.source.cellFactory = cellFactory;
    
    self.tableView.exclusiveSections = NO;
    [self.tableView reloadData];
    [self.tableView openSection:0 animated:NO];
    if( self.dataEntity.showMidSection)
       [self.tableView openSection:1 animated:NO];
    else
        [self.tableView closeSection:1 animated:NO];
    [self.tableView openSection:2 animated:NO];
}

-(void)tableView:(UITableView *)tableView didOpenSection:(NSUInteger)sectionIndex
{
    if( sectionIndex == 1)
    {
        self.dataEntity.showMidSection = YES;
    
        UITableViewCell<TableViewCellDataSource> *cell = (UITableViewCell<TableViewCellDataSource>*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        [cell setData:self.dataEntity];
    
    }
    
    //TableViewSectionDefinition *sectionDefinition = [self.source sectionAtIndex:2];
    //sectionDefinition.data = self.dataEntity;
    
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)tableView:(UITableView *)tableView didCloseSection:(NSUInteger)sectionIndex
{
    if( sectionIndex == 1)
    {
    self.dataEntity.showMidSection = NO;
    
    UITableViewCell<TableViewCellDataSource> *cell = (UITableViewCell<TableViewCellDataSource>*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    [cell setData:self.dataEntity];
    }
    //TableViewSectionDefinition *sectionDefinition = [self.source sectionAtIndex:2];
    //sectionDefinition.data = self.dataEntity;
}

-(void)buttonTapped:(UIButton*)sender
{
    NSLog(@"That was the button");
}

- (void)switchSwitched:(UISwitch *)sender
{
    NSIndexPath *indexPathForSelectedRow = [self.tableView indexPathForSelectedRow];
    NSLog(@"That was the switch %d %d", (int)indexPathForSelectedRow.section, (int)indexPathForSelectedRow.row);
    
    self.dataEntity.showMidSection = sender.on;

    if( self.dataEntity.showMidSection)
        [self.tableView openSection:1 animated:YES];
    else
        [self.tableView closeSection:1 animated:YES];
}

-(void)cellSelected:(TableViewCellDefinition *)cellDefinition
{
    NSLog(@"Cell with data %@ was selected", cellDefinition.data);
}

@end
