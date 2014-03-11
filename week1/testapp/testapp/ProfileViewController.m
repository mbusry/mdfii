//
//  ProfileViewController.m
//  testapp
//
//  Created by Michael on 3/7/14.
//  Copyright (c) 2014 Michael Usry. All rights reserved.
//

#import "ProfileViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize nameLabel,descriptionLabel,followersLabel,friendsLabel,imageView,twitterFeed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
        //This code is identical to the code on the TwitterFeedTableViewController except for the url.
        //This code gathers the profile information for the user that is currently signed in
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    if (accountStore != nil) {
        
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        if (accountType != nil) {
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                if (granted) {
                    
                    NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                    if (twitterAccounts != nil) {
                        ACAccount *currentAccount = [twitterAccounts objectAtIndex:0];
                        if (currentAccount != nil) {
                            NSString *baseString = @"https://api.twitter.com/1.1/users/show.json?screen_name=";
                            NSString *theUsername = [twitterAccounts[0] valueForKey:@"username"];
                            
                            NSString *userTimeString = [NSString stringWithFormat:@"%@%@", baseString, theUsername];
                            
                            
                            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:userTimeString] parameters:nil];
                            if (request != nil) {
                                [request setAccount:currentAccount];
                                
                                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                    
                                    NSInteger responseCode = [urlResponse statusCode];
                                    if (responseCode == 200) {
                                        twitterFeed = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                                        if (twitterFeed != nil) {
                                            dispatch_async(dispatch_get_main_queue(),^{[self getInfo];;});
                                            
                                            
                                        }
                                    }
                                }];
                            }
                        }
                    }
                }
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

-(void)getInfo
{
        //set the name label text
    nameLabel.text = [twitterFeed valueForKey:@"name"];
    
        //get the friend count as a string
    NSString *friends = [twitterFeed valueForKey:@"friends_count"];
        //set the string to an int value
    int new = [friends intValue];
        //make a formatted string for the friend count
    NSString *friendString = [NSString stringWithFormat:@"%d", new];
        //set the friends count label text
    friendsLabel.text = friendString;
    
        //get the followers count as a string
    NSString *followers = [twitterFeed valueForKey:@"followers_count"];
        //set the string to an int value
    int new2 = [followers intValue];
        //make a formatted string for the followers count
    NSString *followersString = [NSString stringWithFormat:@"%d", new2];
    
        //set the followers count label text
    followersLabel.text = followersString;
    
        //get a stirng of the image url
    NSString *imageString = [NSString stringWithFormat:@"%@", [twitterFeed valueForKey:@"profile_image_url"]];
        //create an NSURL from the string
    NSURL *imageURL = [[NSURL alloc] initWithString:imageString];
        //create an NSData object form the contents of the url
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
        //create an UIImage from the NSData object
    UIImage *userImage = [[UIImage alloc] initWithData:imageData];
    
        //set the image in the image view
    imageView.image = userImage;
    
        //get the users description as a stirng
    NSString *description = [twitterFeed valueForKey:@"description"];
        //    NSLog(@"%@", description);
    
        //set the description labels text
    descriptionLabel.text = description;
    
}


@end
