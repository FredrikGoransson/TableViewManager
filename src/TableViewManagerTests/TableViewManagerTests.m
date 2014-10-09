//
//  TableViewManagerTests.m
//  TableViewManagerTests
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "TableViewCellFactory.h"
#import "TableViewCellDefinition.h"
#import "TableViewCellDataSource.h"
#import "DefaultTableViewCellFactory.h"

#import "TestTableViewCell.h"
#import "TestTableViewCellWithDataSource.h"
#import "TestTableViewCellForDequeing.h"

#import "TableViewDataSourceAndDelegate.h"

@interface TableViewManagerTests : XCTestCase

@end

@implementation TableViewManagerTests{
    UIViewController *viewControllerUnderTest;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Tests" bundle:bundle];
    viewControllerUnderTest = [storyBoard instantiateViewControllerWithIdentifier:@"TableViewController"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDefaultTableViewCellFactory_cellWith_CellDefinitionWithIdentifier_should_dequeue_tableView_cell {
    
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    
    // Act
    DefaultTableViewCellFactory *factory = [[DefaultTableViewCellFactory alloc] initWithTableView:tableView];
    TableViewCellDefinitionWithIdentifier *cellDefinition = [[TableViewCellDefinitionWithIdentifier alloc] init];
    cellDefinition.identifier = @"TestIdentifier1";
    UITableViewCell *cell = [factory cellWith:cellDefinition];
    
    // Assert
    XCTAssertNotNil(cell);
}

- (void)testDefaultTableViewCellFactory_cellWith_CellDefinitionWithIdentifier_should_dequeue_tableView_cell_of_correct_subclass {
    
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    
    // Act
    DefaultTableViewCellFactory *factory = [[DefaultTableViewCellFactory alloc] initWithTableView:tableView];
    TableViewCellDefinitionWithIdentifier *cellDefinition = [[TableViewCellDefinitionWithIdentifier alloc] init];
    cellDefinition.identifier = @"TestIdentifier2";
    UITableViewCell *cell = [factory cellWith:cellDefinition];
    
    // Assert
    XCTAssertNotNil(cell);
    XCTAssertTrue([cell isKindOfClass:[TestTableViewCellWithDataSource class]]);
}

- (void)testDefaultTableViewCellFactory_cellWith_CellDefinitionWithView_should_init_new_subclassed_tableviewcell {
    
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    
    // Act
    DefaultTableViewCellFactory *factory = [[DefaultTableViewCellFactory alloc] initWithTableView:tableView];
    TableViewCellDefinitionWithView *cellDefinition = [[TableViewCellDefinitionWithView alloc] init];
    cellDefinition.identifier = @"TestIdentifier1_for_view";
    cellDefinition.ownerClass = [TestTableViewCell class];
    cellDefinition.nibName = @"TestTableViewCell";
    
    UITableViewCell *cell = [factory cellWith:cellDefinition];
    
    // Assert
    XCTAssertNotNil(cell);
    XCTAssertTrue([cell isKindOfClass:cellDefinition.ownerClass]);
}

- (void)testDefaultTableViewCellFactory_cellWith_CellDefinitionWithIdentifier_should_set_cell_Data {
    
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    
    // Act
    DefaultTableViewCellFactory *factory = [[DefaultTableViewCellFactory alloc] initWithTableView:tableView];
    TableViewCellDefinitionWithIdentifier *cellDefinition = [[TableViewCellDefinitionWithIdentifier alloc] init];
    cellDefinition.identifier = @"TestIdentifier2";
    TestTableViewCellWithDataSource *cell = (TestTableViewCellWithDataSource*)[factory cellWith:cellDefinition];
    
    // Assert
    XCTAssertTrue(cell.isDataSet);
}

- (void)testTableViewDataSourceAndDelegate_should_be_assignable_as_datasource_for_tableview{

    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    TableViewDataSourceAndDelegate *source = [[TableViewDataSourceAndDelegate alloc] init];
    
    // Act
    tableView.dataSource = source;    
    XCTAssertNoThrow([tableView reloadData]);
}

- (void)testTableViewDataSourceAndDelegate_should_be_assignable_as_delegate_for_tableview{
    
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    TableViewDataSourceAndDelegate *source = [[TableViewDataSourceAndDelegate alloc] init];
    
    // Act
    tableView.delegate = source;
    XCTAssertNoThrow([tableView reloadData]);
}

- (void)testTableViewDataSourceAndDelegate_should_return_a_section_for_each_sectiondefinition_added{
    
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    TableViewDataSourceAndDelegate *source = [[TableViewDataSourceAndDelegate alloc] init];
    TableViewSectionDefinition *sectionDefinition1 = [[TableViewSectionDefinition alloc] init];
    TableViewSectionDefinition *sectionDefinition2 = [[TableViewSectionDefinition alloc] init];
    
    // Act
    [source addSection:sectionDefinition1];
    [source addSection:sectionDefinition2];
    tableView.delegate = source;
    tableView.dataSource = source;
    [tableView reloadData];
    
    // Assert
    NSInteger numberOfSections = [tableView numberOfSections];
    XCTAssertEqual(numberOfSections , 2);
}

- (void)testTableViewDataSourceAndDelegate_should_return_count_of_cells_as_number_of_rows_for_each_section{
    
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    TableViewDataSourceAndDelegate *source = [[TableViewDataSourceAndDelegate alloc] init];
    TableViewSectionDefinition *sectionDefinition1 = [[TableViewSectionDefinition alloc] init];
    TableViewCellDefinition *cell11 = [[TableViewCellDefinition alloc] init];
    TableViewCellDefinition *cell12 = [[TableViewCellDefinition alloc] init];
    TableViewCellDefinition *cell13 = [[TableViewCellDefinition alloc] init];
    [sectionDefinition1 addCell:cell11];
    [sectionDefinition1 addCell:cell12];
    [sectionDefinition1 addCell:cell13];
    TableViewSectionDefinition *sectionDefinition2 = [[TableViewSectionDefinition alloc] init];
    TableViewCellDefinition *cell21 = [[TableViewCellDefinition alloc] init];
    TableViewCellDefinition *cell22 = [[TableViewCellDefinition alloc] init];
    [sectionDefinition2 addCell:cell21];
    [sectionDefinition2 addCell:cell22];
    
    // Act
    [source addSection:sectionDefinition1];
    [source addSection:sectionDefinition2];
    tableView.delegate = source;
    tableView.dataSource = source;
    [tableView reloadData];
    
    // Assert
    NSInteger numberOfSections = [tableView numberOfSections];
    XCTAssertEqual(numberOfSections , 2);
    
    NSInteger numberOfRowsInSection1 = [tableView numberOfRowsInSection:0];
    XCTAssertEqual(numberOfRowsInSection1 , 3);
    
    NSInteger numberOfRowsInSection2 = [tableView numberOfRowsInSection:1];
    XCTAssertEqual(numberOfRowsInSection2 , 2);
}

- (void)testTableViewDataSourceAndDelegate_should_return_cells_based_on_celldefinition_in_sections{
    
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    TableViewDataSourceAndDelegate *source = [[TableViewDataSourceAndDelegate alloc] init];
    TableViewSectionDefinition *sectionDefinition1 = [[TableViewSectionDefinition alloc] init];
    TableViewCellDefinition *cell11 = [[TableViewCellDefinition alloc] init];
    TableViewCellDefinition *cell12 = [[TableViewCellDefinition alloc] init];
    TableViewCellDefinition *cell13 = [[TableViewCellDefinition alloc] init];
    [sectionDefinition1 addCell:cell11];
    [sectionDefinition1 addCell:cell12];
    [sectionDefinition1 addCell:cell13];
    [source addSection:sectionDefinition1];
    TableViewSectionDefinition *sectionDefinition2 = [[TableViewSectionDefinition alloc] init];
    TableViewCellDefinition *cell21 = [[TableViewCellDefinition alloc] init];
    TableViewCellDefinition *cell22 = [[TableViewCellDefinition alloc] init];
    [sectionDefinition2 addCell:cell21];
    [sectionDefinition2 addCell:cell22];
    [source addSection:sectionDefinition2];
    
    DefaultTableViewCellFactory *cellFactory = [[DefaultTableViewCellFactory alloc] initWithTableView:tableView];
    source.cellFactory = cellFactory;
    
    // Act
    tableView.delegate = source;
    tableView.dataSource = source;
    [tableView reloadData];
    
    // Assert
    UITableViewCell *actualCell11 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *actualCell12 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell *actualCell13 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];

    UITableViewCell *actualCell21 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    UITableViewCell *actualCell22 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    XCTAssertNotNil(actualCell11);
    XCTAssertNotNil(actualCell12);
    XCTAssertNotNil(actualCell13);
    XCTAssertNotNil(actualCell21);
    XCTAssertNotNil(actualCell22);
}

- (void)testDefaultTableViewCellFactory_should_cache_cells_already_created{
    
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    TableViewDataSourceAndDelegate *source = [[TableViewDataSourceAndDelegate alloc] init];
    TableViewSectionDefinition *sectionDefinition1 = [[TableViewSectionDefinition alloc] init];
    TableViewCellDefinitionWithView *cell11 = [[TableViewCellDefinitionWithView alloc] init];
    cell11.ownerClass = [TestTableViewCellForDequeing class];
    cell11.nibName = @"TestTableViewCellForDequeing";
    //NSStringFromClass(cell11.ownerClass);
    [sectionDefinition1 addCell:cell11];
    [source addSection:sectionDefinition1];
    
    DefaultTableViewCellFactory *cellFactory = [[DefaultTableViewCellFactory alloc] initWithTableView:tableView];
    source.cellFactory = cellFactory;
    
    // Act
    tableView.delegate = source;
    tableView.dataSource = source;
    
    [tableView reloadData];
    [tableView setNeedsDisplay];
    [tableView setNeedsLayout];
    
    [tableView reloadData];
    [tableView setNeedsDisplay];
    [tableView setNeedsLayout];

    // Assert
    TestTableViewCellForDequeing *actualCell11 = (TestTableViewCellForDequeing*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSInteger creationCount = [actualCell11 creationCount];
    XCTAssertEqual(creationCount, 1);
}

- (void)testDefaultTableViewCellFactory_cellWith_CellDefinitionWithView_should_get_nibname_from_ownerclass_if_nil{
    
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    TableViewDataSourceAndDelegate *source = [[TableViewDataSourceAndDelegate alloc] init];
    TableViewSectionDefinition *sectionDefinition1 = [[TableViewSectionDefinition alloc] init];
    TableViewCellDefinitionWithView *cell11 = [[TableViewCellDefinitionWithView alloc] init];
    cell11.ownerClass = [TestTableViewCell class];
    //cell11.nibName = @"TestTableViewCell";
    //NSStringFromClass(cell11.ownerClass);
    [sectionDefinition1 addCell:cell11];
    [source addSection:sectionDefinition1];
    
    DefaultTableViewCellFactory *cellFactory = [[DefaultTableViewCellFactory alloc] initWithTableView:tableView];
    source.cellFactory = cellFactory;
    
    // Act
    tableView.delegate = source;
    tableView.dataSource = source;
    
    [tableView reloadData];
    [tableView setNeedsDisplay];
    [tableView setNeedsLayout];
    
    // Assert
    TestTableViewCell *actualCell11 = (TestTableViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIView *contentView = [[actualCell11 subviews] firstObject];
    // Tag set in interface builder for contentview of TestTableViewCell.xib just so we
    // can compare it here and make sure we got the right view
    XCTAssertEqual(contentView.tag, 9876543210);
}

- (void)testTableViewDataSourceAndDelegate_should_return_row_height_from_CellDefinitionWithIdentifier
{
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    TableViewDataSourceAndDelegate *source = [[TableViewDataSourceAndDelegate alloc] init];
    TableViewSectionDefinition *sectionDefinition1 = [[TableViewSectionDefinition alloc] init];
    TableViewCellDefinitionWithIdentifier *cell11 = [[TableViewCellDefinitionWithIdentifier alloc] init];
    cell11.identifier = @"TestIdentifier3";
    cell11.height = 140.0;
    [sectionDefinition1 addCell:cell11];
    [source addSection:sectionDefinition1];
    
    DefaultTableViewCellFactory *cellFactory = [[DefaultTableViewCellFactory alloc] initWithTableView:tableView];
    source.cellFactory = cellFactory;
    
    // Act
    tableView.delegate = source;
    tableView.dataSource = source;
    [tableView reloadData];
    [tableView setNeedsDisplay];
    [tableView setNeedsLayout];
    
    // Assert
    UITableViewCell *actualCell11 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGRect frame = actualCell11.frame;
    float height = frame.size.height;
    XCTAssertEqual(height, 140.0);
}

- (void)testTableViewDataSourceAndDelegate_should_return_row_height_from_CellDefinitionWithView_view_frame
{
    // Arrange
    UITableView *tableView = (UITableView*)viewControllerUnderTest.view;
    TableViewDataSourceAndDelegate *source = [[TableViewDataSourceAndDelegate alloc] init];
    TableViewSectionDefinition *sectionDefinition1 = [[TableViewSectionDefinition alloc] init];
    TableViewCellDefinitionWithView *cell11 = [[TableViewCellDefinitionWithView alloc] init];
    cell11.identifier = @"TestIdentifier1_for_view";
    cell11.ownerClass = [TestTableViewCell class];
    cell11.nibName = @"TestTableViewCell";
    [sectionDefinition1 addCell:cell11];
    [source addSection:sectionDefinition1];
    
    DefaultTableViewCellFactory *cellFactory = [[DefaultTableViewCellFactory alloc] initWithTableView:tableView];
    source.cellFactory = cellFactory;
    
    // Act
    tableView.delegate = source;
    tableView.dataSource = source;
    [tableView reloadData];
    [tableView setNeedsDisplay];
    [tableView setNeedsLayout];
    
    // Assert
    UITableViewCell *actualCell11 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGRect frame = actualCell11.frame;
    float height = frame.size.height;
    XCTAssertEqual(height, 180.0);
}

/*
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
*/

@end
