//
//  SearchResultCell.m
//  CapitalOneInterview
//
//  Created by Dan Deng on 10/23/18.
//  Copyright © 2018 Dan Deng. All rights reserved.
//

#import "SearchResultCell.h"
#import "SearchResult.h"

@implementation SearchResultCell

+ (NSString*)reuseID {
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)inflateWith:(SearchResult*) searchResult {

}

@end
