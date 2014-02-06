//
//  TwitterCellViewCell.m
//  twitter
//
//  Created by Michael on 2/6/14.
//  Copyright (c) 2014 Michael Usry. All rights reserved.
//

#import "TwitterCellView.h"

@implementation TwitterCellView
@synthesize tweetText, username;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshCell
{
    twitterText.text = tweetText;
    twitterUserName.text = username;

    
}

@end
