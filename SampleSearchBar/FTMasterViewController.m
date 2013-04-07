//
//  FTMasterViewController.m
//  SampleSearchBar
//
//  Created by 古山 健司 on 13/04/06.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import "FTMasterViewController.h"

#import "FTDetailViewController.h"

@interface FTMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation FTMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;

   self.filteredArray = [NSMutableArray arrayWithArray:_objects];
    
//    UISearchDisplayController* searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.statusSearchBar contentsController:self];
//    searchController.searchResultsDataSource = self;
//    searchController.searchResultsDelegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    if (!_originalArray) {
        _originalArray = [[NSMutableArray alloc] init];
    }
    NSDate* currentDate = [NSDate date];
    [_objects insertObject:currentDate atIndex:0];
    [self.originalArray insertObject:[currentDate description] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.filteredArray addObject:[(NSDate *)[_objects objectAtIndex:0] description]];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.filteredArray objectAtIndex:indexPath.row];
    }
    else {
        NSDate *object = _objects[indexPath.row];
        cell.textLabel.text = [object description];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    LOG_METHOD;
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    LOG_METHOD;
}

- (void)filterSearchText:(NSString *)text
{
    LOG_METHOD;

    [self.filteredArray removeAllObjects];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", text];
    self.filteredArray = [NSMutableArray arrayWithArray:[self.originalArray filteredArrayUsingPredicate:predicate]];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark delegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterSearchText:searchString];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    LOG_METHOD;
    return YES;
}
@end
