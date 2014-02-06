//
//  TwitterCellViewCell.h
//  twitter
//
//  Created by Michael on 2/6/14.
//  Copyright (c) 2014 Michael Usry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterCellView : UITableViewCell
{
    IBOutlet UILabel *twitterText;
    IBOutlet UILabel *twitterUserName;
}

@property (nonatomic, strong) NSString *tweetText;
@property (nonatomic, strong) NSString *username;

-(void)refreshCell;

@end
