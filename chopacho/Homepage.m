//
//  homepage.m
//  chopacho
//
//  Created by aurelie ambal on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import "Homepage.h"
#import "AFNetworking.h"
#import "ViewController.h"

@interface Homepage () <UITableViewDataSource>

@end

@implementation Homepage

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSInteger selectedIndex = self.eventTableView.indexPathForSelectedRow.row;
    
    // event at index
    
    if([segue.identifier isEqualToString:@"addEventButton"])
    {
        AddEventViewController *controller = (AddEventViewController *)segue.destinationViewController;
        controller.lblFacebookID = self.lblFacebookID;
        controller.friendsList = self.friendsList;
    }
    
}

- (IBAction)addEventView:(id)sender {
    
    AddEventViewController *addEventController = [[AddEventViewController alloc] init];
    addEventController.lblFacebookID = self.lblFacebookID;
    addEventController.friendsList = self.friendsList;

    [self performSelector:@selector(addEventButton) withObject:addEventController];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //GET information in user with facebook id
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *idfacebook = self.lblFacebookID;
    
    [manager GET:[NSString stringWithFormat:@"http://chaudpaschaud.herokuapp.com/user/%@", idfacebook] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"JSON: %@", responseObject);
        
        NSError * error;
        
//        NSMutableDictionary  *json = [NSJSONSerialization JSONObjectWithData:responseObject options: NSJSONReadingMutableContainers error: &error];
        /*NSArray *jsonowner = [json valueForKeyPath:@"owner"];

        NSMutableArray *test = [NSMutableArray array];
        for (NSDictionary *owner in jsonowner)
        {
            //create our object
           // NSString *title = [item objectForKey:@"title"];
            //Add the object to our animal array
            //[test addObject:title];
        }*/
        
       // NSLog(@"The content of array is%@",test);
        
        
        
        
        if ([responseObject count] == 0)
        {
        NSLog(@"Error: vide");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    // Style
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bgNavigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    if ([self.eventTableView respondsToSelector:@selector(setSeparatorInset:)])
        [self.eventTableView setSeparatorInset:UIEdgeInsetsZero];
    
    if ([self.eventTableView respondsToSelector:@selector(setSeparatorStyle:)])
        [self.eventTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addEventButton {
    [self performSegueWithIdentifier:@"addEventButton" sender:self];
}


#pragma mark - UITableView delegate methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 1){
        return 10;
    } else {
        return 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"cellIdentifier";
    
    if (indexPath.row % 2 == 1) {
        UITableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"cellInvisible"];
        
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellInvisible"];
            [cell2.contentView setAlpha:0];
            [cell2 setUserInteractionEnabled:NO]; // prevent selection and other stuff
        }
        
        return cell2;
    }

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    NSInteger index = [indexPath row];
    // la y'a le tableau[index]
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.753 green:0.729 blue:0.675 alpha:1];
    
    [[cell textLabel] setText:@"Mon texte"];
    
    return cell;
}

#pragma mark - Navigation


@end
