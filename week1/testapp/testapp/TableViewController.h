//
//  TableViewController.h
//  testapp
//
//  Created by Michael on 3/7/14.
//  Copyright (c) 2014 Michael Usry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController
{
    NSArray *twitterFeed;
    NSDictionary *tweets;
    UIAlertView *alert;
    IBOutlet UITableView *tweetTable;
    __weak IBOutlet UIButton *tweetProfile;
}

@property (nonatomic, strong) NSDictionary *tweets;

-(IBAction)onClick:(id)sender;

@end
