//
//  DealImageScrollViewController.m
//  Airbrowz
//
//  Created by Denny on 2016-05-24.
//  Copyright © 2016 Kiwi. All rights reserved.
//

#import "DealImageScrollViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
@interface DealImageScrollViewController ()

@end

@implementation DealImageScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.file = self.imageFile;
    [self.imageView loadInBackground];
    
    // Share Button
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(didTabShareButton)];
    self.navigationItem.rightBarButtonItem = shareButton;


}

- (void) didTabShareButton {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Share" message:@"Please choose platform" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Facebook button tapped.
        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
        content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
        content.contentTitle = @"Content Title";
        content.contentDescription = @"Content Description";

        FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
        dialog.fromViewController = self;
        dialog.shareContent = content;
        dialog.mode = FBSDKShareDialogModeNative; // if you don't set this before canShow call, canShow would always return YES
        if (![dialog canShow]) {
            // fallback presentation when there is no FB app
            dialog.mode = FBSDKShareDialogModeFeedBrowser;
        }
        [dialog show];
        NSLog(@"content should show");
        
        [self dismissViewControllerAnimated:YES completion:^{
     
        }];
        
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];

    
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.imageView loadInBackground:^(UIImage *image , NSError *err){
        float widthScale = self.view.bounds.size.width / self.imageView.image.size.width;
        float heightScale = self.view.bounds.size.height / self.imageView.image.size.height;
        float minScale = MIN(widthScale, heightScale);
        
        self.scrollView.minimumZoomScale = minScale;
        NSLog(@"width:%f, height: %f", widthScale, heightScale);
        self.scrollView.zoomScale = minScale;
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    NSLog(@"viewForZoomingInScrollView");
    return self.imageView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
