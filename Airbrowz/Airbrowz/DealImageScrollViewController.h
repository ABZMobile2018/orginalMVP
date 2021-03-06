//
//  DealImageScrollViewController.h
//  Airbrowz

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface DealImageScrollViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet PFImageView *imageView;
@property (weak, nonatomic) PFFile *imageFile;
@property (weak, nonatomic) NSString *contentHeading;
@property (weak, nonatomic) NSString *contentDescription;
@property (weak, nonatomic) NSString *contentURL;
@end
