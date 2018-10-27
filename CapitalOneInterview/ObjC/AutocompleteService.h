//
//  AutocompleteService.h
//  CapitalOneInterview
//
//  Created by Dan Deng on 10/23/18.
//  Copyright © 2018 Dan Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FetchCompletion)(NSArray*, NSError*);

@interface AutocompleteService : NSObject

- (void)fetchResultsForQuery:(NSString*)query completion: (FetchCompletion)completion;

@end
