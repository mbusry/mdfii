//
//  TwitterDetailViewController.h
//  testapp
//
//  Created by Michael on 3/7/14.
//  Copyright (c) 2014 Michael Usry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterDetailViewController : UIViewController
{
    IBOutlet UIImageView *theUserImage;
    IBOutlet UILabel *usernameLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UITextView *tweetText;
    NSDictionary *passedTweets;
}

@property (nonatomic, strong) IBOutlet UIImageView *theUserImage;
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) NSDictionary *passedTweets;

@end
