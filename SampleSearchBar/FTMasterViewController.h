//
//  FTMasterViewController.h
//  SampleSearchBar
//
//  Created by 古山 健司 on 13/04/06.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTMasterViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *statusSearchBar;
@property (strong, nonatomic) NSMutableArray* originalArray;

@property (strong, nonatomic) NSMutableArray* filteredArray;
@end
