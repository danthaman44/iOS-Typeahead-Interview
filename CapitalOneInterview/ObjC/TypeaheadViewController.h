//
//  TypeaheadViewController.h
//  CapitalOneInterview
//
//  Created by Dan Deng on 10/23/18.
//  Copyright © 2018 Dan Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeaheadViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITextField *searchField;
@property (strong, nonatomic) UITableView *tableView;

@end
