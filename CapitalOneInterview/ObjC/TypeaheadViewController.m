//
//  TypeaheadViewController.m
//  CapitalOneInterview
//
//  Created by Dan Deng on 10/23/18.
//  Copyright © 2018 Dan Deng. All rights reserved.
//

#import "TypeaheadViewController.h"
#import "SearchResultCell.h"
#import "SearchResult.h"

@interface TypeaheadViewController ()

@end

@implementation TypeaheadViewController

// MARK: - Properties

@synthesize searchField;
@synthesize tableView;

// MARK: - Lifecycle

- (instancetype)init {
    self.searchField = [[UITextField alloc] init];
    self.tableView = [[UITableView alloc] init];
    return [super init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Setup searchField
    [self.view addSubview:self.searchField];
    [self.searchField addTarget:self action:@selector(searchTextDidUpdate:) forControlEvents:UIControlEventEditingChanged];

    // Setup tableView
    [self.view addSubview:self.tableView];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView registerClass:[SearchResultCell class] forCellReuseIdentifier:SearchResultCell.reuseID];
}

// MARK: - Text field handler

// Called when the text in searchField is updated
- (void)searchTextDidUpdate:(UITextField*)textField {
    // TODO: Candidate implements this
}

// MARK: - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // TODO: Candidate implements this
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Candidate implements this
    return [[UITableViewCell alloc] init];
}

@end

