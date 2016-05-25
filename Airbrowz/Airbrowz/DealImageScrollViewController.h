//
//  DealImageScrollViewController.h
//  Airbrowz
//
//  Created by Denny on 2016-05-24.
//  Copyright © 2016 Kiwi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface DealImageScrollViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet PFImageView *imageView;
@property (weak, nonatomic) PFFile *imageFile;
@end
