//
//  TableViewController.m
//  testapp
//
//  Created by Michael on 3/7/14.
//  Copyright (c) 2014 Michael Usry. All rights reserved.
//

#import "TableViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "TwitterDetailViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController
@synthesize tweets;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

        // alert view start
        //show the alert view to let the user know we are fetching their timeline
    alert = [[UIAlertView alloc] initWithTitle:@"Please Wait..." message:@"loading info..." delegate:self cancelButtonTitle:Nil otherButtonTitles:nil, nil];
    
    [alert show];

    
        //get an instance of the ACAccountStore
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    if (accountStore != nil) {
            //set the account type to the twitter account
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        if (accountType != nil) {
                //request access to the users twitter account
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                if (granted) {
                        //if access is granted run this code
                        //get an array of the users twitter accounts
                    NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                    if (twitterAccounts != nil) {
                            //use the first account in the array
                        ACAccount *currentAccount = [twitterAccounts objectAtIndex:0];
                        if (currentAccount != nil) {
                                //set the url for the twitter call
                            NSString *userTimeString = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
                            
                                //setup the request to the twitter API
                            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:userTimeString] parameters:nil];
                            if (request != nil) {
                                    //set the account for the request
                                [request setAccount:currentAccount];
                                
                                    //perform the request
                                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                    
                                    NSInteger responseCode = [urlResponse statusCode];
                                        //check to make sure we get 200 for the response code
                                    if (responseCode == 200) {
                                            //place the JSON data into the dictionary
                                        twitterFeed = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                                        if (twitterFeed != nil) {
                                                //use grand central dispatch to run this code on the main thread.  this speeds up the loading of the twitter data
                                            dispatch_async(dispatch_get_main_queue(),^{[tweetTable reloadData];
                                                [alert dismissWithClickedButtonIndex:0 animated:YES];});
                                        }
                                    }
                                }];
                            }
                        }
                    }
                }
                    //if the user does not give access to the account log the message
                else {
                    NSLog(@"Access Denied");
                }
            }];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (twitterFeed != nil) {
        return [twitterFeed count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tweetTable dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
        // Configure the cell...
    tweets = [[NSDictionary alloc] init];
    
        //get the current tweet for the cell
    tweets = [twitterFeed objectAtIndex:indexPath.row];
    
        //create a dictonary of username information
    NSDictionary *usernames = [tweets objectForKey:@"user"];
    
        //use tags to identify the labels in the prototype cell
    UILabel *userText = (UILabel *)[cell viewWithTag:1];
    UILabel *tweetText = (UILabel *)[cell viewWithTag:2];
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:3];
    
        //set the text in each label for the cell
    userText.text = [usernames valueForKey:@"name"];
    tweetText.text = [tweets valueForKey:@"text"];
    dateLabel.text = [tweets valueForKey:@"created_at"];
    
        //get the url of the profile image as a stirng
    NSString *imageString = [NSString stringWithFormat:@"%@", [usernames valueForKey:@"profile_image_url"]];
    
        //create an NSURL with the above string
    NSURL *imageURL = [[NSURL alloc] initWithString:imageString];
    
        //create NSData with contents of the above url
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    
        //create an UIImage to use in the cell
    UIImage *userImage = [[UIImage alloc] initWithData:imageData];
    
        //set the image for the imageview in the cell
    cell.imageView.image = userImage;
    
    
    return cell;
}



#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ProfileSegue"]) {
    
        //create a variable to know what cell was clicked
    NSIndexPath *indexPath = [tweetTable indexPathForSelectedRow];
    
        //create a dictionary to use to pass to the detail view
    NSDictionary *dictToPass = [twitterFeed objectAtIndex:indexPath.row];
    
        //pass the dictionary to the detail view
    [segue.destinationViewController setPassedTweets:dictToPass];
    }
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {

            //create a variable to know what cell was clicked
        NSIndexPath *indexPath = [tweetTable indexPathForSelectedRow];
        
            //create a dictionary to use to pass to the detail view
        NSDictionary *dictToPass = [twitterFeed objectAtIndex:indexPath.row];
        
            //pass the dictionary to the detail view
        [segue.destinationViewController setPassedTweets:dictToPass];

    }
}


-(IBAction)onClick:(id)sender
{
        // which button is pressed
        // 0 = refresh
        // 1 = add
    
    switch (((UIButton*)sender).tag) {
        case 0:
            NSLog(@"refresh button pressed");
        {
            [self viewDidLoad];
        }
            
            break;
            
        case 1:
        { NSLog(@"add button pressed");
            SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            if (slComposeViewController != nil)
            {
                    //set initial text
                [slComposeViewController setInitialText:@"Posted from"];
                [slComposeViewController addImage:[UIImage imageNamed:@"cross.jpg"]];
                
                    //show tweet VC
                [self presentViewController:slComposeViewController animated:true completion:nil];
            }
        }
            
            break;
            
        default:
            break;
    }
    
}


@end
