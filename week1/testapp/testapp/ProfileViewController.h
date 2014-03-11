//
//  ProfileViewController.h
//  testapp
//
//  Created by Michael on 3/7/14.
//  Copyright (c) 2014 Michael Usry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
{
        //IBOutlets and variables
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *followersLabel;
    IBOutlet UILabel *friendsLabel;
    IBOutlet UILabel *descriptionLabel;
    NSDictionary *twitterFeed;
    NSString *nameString;
}
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *followersLabel;
@property (nonatomic, strong) IBOutlet UILabel *friendsLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) NSDictionary *twitterFeed;

    //method to place information in the labels
-(void)getInfo;

@end
