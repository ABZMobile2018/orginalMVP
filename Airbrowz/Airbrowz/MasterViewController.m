//
//  MasterViewController.m
//  Airbrowz
//
//  Created by Denny on 2015-10-26.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import "MasterViewController.h"
#import "DealTableViewCell.h"
#import "CategoryCollectionViewCell.h"
@interface MasterViewController () <UITableViewDelegate, UICollectionViewDelegate>



@end

@implementation MasterViewController {
    
    bool categoryIsHidden;
    
    
}




- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self proximityChanged: self.proximitySlider];
    
    [self.proximitySlider addTarget:self action:@selector(proximityChanged:) forControlEvents:UIControlEventValueChanged];
    [self.proximitySlider setThumbImage:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateNormal];
    [self.proximitySlider setThumbImage:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateHighlighted];
    
    
    categoryIsHidden = true;
    self.categoryLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCategoryLabelClick)];
    [self.categoryLabel addGestureRecognizer:tapGesture];
    
    //self.proximitySlider.transform = CGAffineTransformMakeScale(0.5, 0.5);

   //[[self navigationController] setNavigationBarHidden:YES animated:YES];

}

- (void) onCategoryLabelClick {
    categoryIsHidden ? [self showCategories] : [self hideCategories];
}

- (IBAction)proximityChanged:(UISlider *)sender {
    NSString *distanceString;
    
    if (sender.value >= 1000.0) {
        distanceString = [NSString stringWithFormat:@"%.1f km", sender.value/1000];
    }
    else {
        distanceString = [NSString stringWithFormat:@"%.f m", sender.value];
    }
    self.proximityRangeLabel.text = distanceString;
    NSLog(@"slider value = %f", sender.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}



- (void) showCategories {
    categoryIsHidden = false;
    NSLog(@"show cat");
    [UIView animateWithDuration:0.1f animations:^{
        self.categoryCollectionView.frame =
        CGRectMake(self.categoryCollectionView.frame.origin.x,
                   self.categoryCollectionView.frame.origin.y - self.categoryCollectionView.frame.size.height,
                   self.categoryCollectionView.frame.size.width,
                   self.categoryCollectionView.frame.size.height);
    }];
}

- (void) hideCategories {
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

#define DEAL_CELL_LOADING_REUSE_ID @"DealLoadingCell"
#define DEAL_CELL_REUSE_ID @"DealCell"
    DealTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:DEAL_CELL_REUSE_ID forIndexPath:indexPath];
    cell.mainImageView.image = [UIImage imageNamed:@"tmp"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"selected");
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
#define CATEGORY_CELL_REUSE_ID @"CategoryCell"
    CategoryCollectionViewCell *cell = [self.categoryCollectionView dequeueReusableCellWithReuseIdentifier:CATEGORY_CELL_REUSE_ID forIndexPath:indexPath];
    
    return cell;
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onProximitySelect:(id)sender {
    NSLog(@"selected!!\n");
}
@end
