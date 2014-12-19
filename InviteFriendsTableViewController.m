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
    
    // Create shadow array with same number of entries
    int i=0;
    for (i = 0; i < self.facebookFriendsList.count; i++) {
        [self.selectedItemsArray addObject:[NSNull null]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)cancelFriendsList:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitFriendsList:(id)sender {
    
    if([self.myDelegate respondsToSelector:@selector(secondViewControllerDismissed:)]) {
        [self.selectedItemsArray removeObjectIdenticalTo:[NSNull null]];
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
    return self.facebookFriendsList.count;
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
    
    NSMutableDictionary *d = (NSMutableDictionary*)[self.facebookFriendsList objectAtIndex:indexPath.row];
    cell.textLabel.text = [d valueForKey:@"name"];
    cell.accessibilityValue = [d valueForKey:@"id"];
    
    // Rounded Rect for cell image
    CALayer *cellImageLayer = cell.imageView.layer;
    [cellImageLayer setCornerRadius:25];
    [cellImageLayer setMasksToBounds:YES];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", cell.accessibilityValue]]]];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmarkNone.png"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark.png"]];
        [self.selectedItemsArray insertObject:cell.accessibilityValue atIndex:indexPath.row];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmarkNone.png"]];
        [self.selectedItemsArray removeObjectAtIndex:indexPath.row];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
