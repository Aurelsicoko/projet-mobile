//
//  EventViewController.m
//  chopacho
//
//  Created by Aurélien GEORGET on 18/12/14.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"EVENT VIEW CONTROLLER %@", self.cellSegue);
    
    NSMutableArray *event = self.cellSegue;
    NSMutableArray *owner = [event valueForKey:@"createdBy"];
    self.usernameLabel.text = (NSString *)[owner valueForKey:@"username"];
    self.titleLabel.text = (NSString *)[event valueForKey:@"title"];
    self.descriptionTextView.text = (NSString *)[event valueForKey:@"content"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
