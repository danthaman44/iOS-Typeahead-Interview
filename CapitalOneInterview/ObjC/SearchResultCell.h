//
//  SearchResultCell.h
//  CapitalOneInterview
//
//  Created by Dan Deng on 10/23/18.
//  Copyright © 2018 Dan Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResult.h"

@interface SearchResultCell : UITableViewCell

+ (NSString*) reuseID;
- (void)inflateWith:(SearchResult*) searchResult;

@end
