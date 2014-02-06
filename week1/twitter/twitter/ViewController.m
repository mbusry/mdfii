//
//  ViewController.m
//  twitter
//
//  Created by Michael on 2/5/14.
//  Copyright (c) 2014 Michael Usry. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "TwitterCellView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
        // custom cell for table view
    UINib *twitterCellNib = [UINib nibWithNibName:@"TwitterCellView" bundle:nil];
    if (twitterCellNib !=nil) {
        [myTableView registerNib:twitterCellNib forCellReuseIdentifier:@"TwitterCell"];
    }
    
    
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    if (accountStore != nil)
    {
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        if (accountType != nil) {
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
             {
                 if (granted) {
                         // if access is granted all code goes here
                     
                     NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                     if (twitterAccounts != nil) {
                             //    NSLog(@"%@", [twitterAccounts description]);
                         
                         ACAccount *currentAccount = [twitterAccounts objectAtIndex:0];
                         if (currentAccount !=nil) {
                                 // for a single user and all info
                                 //  NSString *userTimeString = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
                             
                                 //single string below
                                 //                         NSString *userTimeString = @"https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=fullsail";
                             
                                 //string with format for multiple options
                             NSString *userTimeString = [NSString stringWithFormat:@"%@?%@&%@",@"https://api.twitter.com/1.1/statuses/user_timeline.json",@"screen_name=fullsail",@"count=3"];
                             
                             
                             SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:userTimeString] parameters:nil];
                             if (request !=nil)
                             {
                                 [request setAccount:currentAccount];
                                 
                                 [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                                  {
                                      NSInteger responseCode = [urlResponse statusCode];
                                          // response is good
                                      if (responseCode == 200) {
                                          
                                              //twitterFeed is available to all since it's in .h
                                          
                                          twitterFeed = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                                          if (twitterFeed != nil) {
                                              
                                              [myTableView reloadData];
                                              NSLog(@"%@", [twitterFeed description]);
                                                  //                                         NSLog(@"%@", [[twitterFeed objectAtIndex:0] description]);
                                          }
                                          
                                      }
                                  }];
                             }
                         }
                     }
                 }
                 else {
                     NSLog(@"Access is not allowed");
                 }
                 
             }];
        }
    }
    
    [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (twitterFeed != nil) {
        NSLog(@"%lu", (unsigned long)[twitterFeed count]);

        return [twitterFeed count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //cell for the table setup above
    TwitterCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"TwitterCell"];
    if (cell != nil)
    {
        cell.tweetText = @"tweet";
        cell.username = @"username";
        
        [cell refreshCell];
        return cell;
    }
    return nil;
}


@end
