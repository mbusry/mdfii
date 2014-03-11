//
//  TwitterDetailViewController.m
//  testapp
//
//  Created by Michael on 3/7/14.
//  Copyright (c) 2014 Michael Usry. All rights reserved.
//

#import "TwitterDetailViewController.h"

@interface TwitterDetailViewController ()

@end

@implementation TwitterDetailViewController
@synthesize theUserImage,usernameLabel,dateLabel,passedTweets;

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
    //get a string from the dictionary for the tweet text
    NSString *tweet = [passedTweets valueForKey:@"text"];
        //set the label to the above string
    tweetText.text = tweet;
        //get a string form the dictionary for the date
    NSString *dateString = [passedTweets valueForKey:@"created_at"];
        //set the date label to the above string
    dateLabel.text = dateString;
    
        //get a dictionary of the username information
    NSDictionary *usernames = [passedTweets objectForKey:@"user"];
    
        //set the username label to the username from the dictionary
    usernameLabel.text = [usernames valueForKey:@"name"];
    
        //get image url as a string
    NSString *imageString = [NSString stringWithFormat:@"%@", [usernames valueForKey:@"profile_image_url"]];
        //create NSURL from the above string
    NSURL *imageURL = [[NSURL alloc] initWithString:imageString];
        //create NSData with contents of above url
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
        //create UIImage form the above NSData
    UIImage *userImage = [[UIImage alloc] initWithData:imageData];
    
        //set the profile picture to the image view
    [theUserImage setImage:userImage];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
