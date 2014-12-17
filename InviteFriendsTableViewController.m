//
//  InviteFriendsTableViewController.m
//  chopacho
//
//  Created by Aurélien GEORGET on 17/12/14.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import "InviteFriendsTableViewController.h"

@interface InviteFriendsTableViewController ()

@end

@implementation InviteFriendsTableViewController

@synthesize myDelegate;

- (NSMutableArray *) selectedItemsArray
{
    if (!_selectedItemsArray) {
        _selectedItemsArray = [NSMutableArray new];
    }
    return _selectedItemsArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableViewData = [NSArray arrayWithObjects:@"Oeuf", @"Mayonnaise", @"Moutarde",@"Moutarde", @"Moutarde",@"Moutarde",nil];
    [self.selectedItemsArray removeObjectIdenticalTo:[NSNull null]];
    
    int i=0;
    for (i = 0; i < [self.tableViewData count]; i++)
    {
        [self.selectedItemsArray addObject:[NSNull null]];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelFriendsList:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitFriendsList:(id)sender {
    
    if([self.myDelegate respondsToSelector:@selector(secondViewControllerDismissed:)])
    {
        [self.selectedItemsArray removeObjectIdenticalTo:[NSNull null]];
        NSLog(@"String send %@", self.selectedItemsArray);
        [self.myDelegate secondViewControllerDismissed:self.selectedItemsArray];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.tableViewData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"friendCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //Adding items to cell
    if([self.selectedItemsArray containsObject:[self.tableViewData objectAtIndex:indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = [self.tableViewData objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedItemsArray insertObject:cell.textLabel.text atIndex:indexPath.row];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectedItemsArray removeObjectAtIndex:indexPath.row];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
