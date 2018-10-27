//
//  SolutionTypeaheadViewController.m
//  CapitalOneInterview
//
//  Created by Dan Deng on 10/23/18.
//  Copyright © 2018 Dan Deng. All rights reserved.
//

#import "SolutionTypeaheadViewController.h"

#import "TypeaheadViewController.h"
#import "SearchResultCell.h"
#import "SearchResult.h"

@interface SolutionTypeaheadViewController ()

@property (strong, atomic) NSArray *searchResults;
@property (strong, atomic) NSMutableDictionary *cachedResults;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation SolutionTypeaheadViewController

// MARK: - Properties

@synthesize searchField;
@synthesize tableView;
@synthesize autocompleteService;
@synthesize searchResults;
@synthesize cachedResults;

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
    NSString *searchText = textField.text;
    if (!searchText || searchText.length == 0) {
        return;
    }
    NSArray *results = [self.cachedResults objectForKey:searchText];
    if (results) {
        [self setSearchResults:results];
        [self.tableView reloadData];
        return;
    }
    // Cancel old autocomplete request
    [self.timer invalidate];
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:NO block:^(NSTimer *timer) {
         __strong typeof(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf.autocompleteService fetchResultsForQuery:searchText completion:^(NSArray *results, NSError *error) {
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                return;
            }
            if (searchText != strongSelf.searchField.text) {
                // Do not update UI if the search query does not match our current query
                return;
            }
            if (results.count == 0) {
                NSLog(@"No search results");
                return;
            }
            [strongSelf setSearchResults:results];
            [strongSelf.cachedResults setObject:results forKey:searchText];
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
            });
        }];
    }];
}

// MARK: - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResult *searchResult = [self.searchResults objectAtIndex:indexPath.row];
    SearchResultCell *cell = [self.tableView dequeueReusableCellWithIdentifier:SearchResultCell.reuseID];
    if (!cell) {
        return [[SearchResultCell alloc] init];
    }
    [cell inflateWith:searchResult];
    return cell;
}

@end
