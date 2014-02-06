//
//  ViewController.h
//  twitter
//
//  Created by Michael on 2/5/14.
//  Copyright (c) 2014 Michael Usry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
 
    NSArray *twitterFeed;
    IBOutlet UITableView *myTableView;
    

    
}

@end
