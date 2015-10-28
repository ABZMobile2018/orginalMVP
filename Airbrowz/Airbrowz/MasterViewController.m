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
#import "AirbrowzCommons.h"
#import <Parse/Parse.h>
@interface MasterViewController () <UITableViewDelegate, UICollectionViewDelegate>

@property NSMutableArray *categoryFilterArray;

@end

@implementation MasterViewController {
    
    bool categoryIsHidden;
    PFGeoPoint *currentLocation;
    NSArray *dealsRawModel;
    
}


- (void) configureCategorySelector {
    
    self.categoryLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCategoryLabelClick)];
    [self.categoryLabel addGestureRecognizer:tapGesture];
 
    
    [self hideCategoriesWithAnimation: NO];

    
    
}


- (NSMutableArray *) getCategoryFilterArray {
    if (_categoryFilterArray == nil) {
        _categoryFilterArray = [[[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_CATEGORY_KEY] mutableCopy];
        
        // Is it first time creating category?
        if (_categoryFilterArray == nil) {
            
            _categoryFilterArray = [[NSMutableArray alloc] init];
            for (int i = 0 ; i <= MISC ; i++) { // MISC is the last item
                [_categoryFilterArray addObject: @YES];
            }
            
            // store
            [[NSUserDefaults standardUserDefaults] setObject: _categoryFilterArray forKey:USER_DEFAULT_CATEGORY_KEY];
        }
    }
    
    return _categoryFilterArray;
}

- (void) toggleCategoryAtIndex: (NSUInteger) index {
    BOOL curVal = [[_categoryFilterArray objectAtIndex: index] boolValue];
    
    [_categoryFilterArray setObject: [NSNumber numberWithBool:!curVal] atIndexedSubscript:index];
    [[NSUserDefaults standardUserDefaults] setObject: _categoryFilterArray forKey: USER_DEFAULT_CATEGORY_KEY];
    
    // Update Cell
    [self.categoryCollectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]]];
}

- (void) fetchDeals {
    
    NSLog(@"fetching deals");
    // First find my location
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *myLocation, NSError *error) {
        if (!error) {
            NSLog(@"success");
            currentLocation = myLocation;
            

            // Create a query for places
            PFQuery *query = [PFQuery queryWithClassName:@"Deals"];
            // Interested in locations near user.
            [query whereKey:@"location" nearGeoPoint:myLocation];
            // Limit what could be a lot of points.
            query.limit = 100;
            // Final list of objects
            dealsRawModel = [query findObjects];
            NSLog(@"%@", dealsRawModel);
        }
        else { //Error
            NSLog(@"Problem encountered while getting current geolocation");
        }
    }];
  
    // Let's fetch all deals max 100
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configureCategorySelector];
    
    [self proximityChanged: self.proximitySlider];
    
    [self.proximitySlider addTarget:self action:@selector(proximityChanged:) forControlEvents:UIControlEventValueChanged];
    [self.proximitySlider setThumbImage:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateNormal];
    [self.proximitySlider setThumbImage:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateHighlighted];
    
    
    [self fetchDeals];
    
    
    //self.proximitySlider.transform = CGAffineTransformMakeScale(0.5, 0.5);

   //[[self navigationController] setNavigationBarHidden:YES animated:YES];

}

- (void) onCategoryLabelClick {
    categoryIsHidden ? [self showCategories] : [self hideCategoriesWithAnimation: YES];
    NSLog(@"%@", dealsRawModel);
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
    [UIView animateWithDuration:0.5f animations:^{
        self.categoryCollectionView.frame =
        CGRectMake(self.categoryCollectionView.frame.origin.x,
                   self.categoryCollectionView.frame.origin.y - self.categoryCollectionView.frame.size.height,
                   self.categoryCollectionView.frame.size.width,
                   self.categoryCollectionView.frame.size.height);
    }];
}

- (void) hideCategoriesWithAnimation: (BOOL) animated {
    categoryIsHidden = true;
    NSLog(@"hide cat");
    
    CGRect rect = CGRectMake(self.categoryCollectionView.frame.origin.x,
                             self.categoryCollectionView.frame.origin.y + self.categoryCollectionView.frame.size.height,
                             self.categoryCollectionView.frame.size.width,
                             self.categoryCollectionView.frame.size.height);
    
    if (animated) {
        [UIView animateWithDuration:0.5f animations:^{
            self.categoryCollectionView.frame = rect;
        }];
    }
    else {
        NSLog(@"hiding without anim");
        self.categoryCollectionView.frame = rect;
    }

    
}


/* ------------------- Deals TableView Delegate ------------------- */

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


/* ------------------- Categories CollectionView Delegate------------------- */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [[self getCategoryFilterArray] count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
#define CATEGORY_CELL_REUSE_ID @"CategoryCell"
    
    CategoryCollectionViewCell *cell = [self.categoryCollectionView dequeueReusableCellWithReuseIdentifier:CATEGORY_CELL_REUSE_ID forIndexPath:indexPath];
    
    NSString *categoryName;
    
    switch (indexPath.row) {
        case FASHION:
            categoryName = @"Fashion";
            break;
        case FOOD:
            categoryName = @"Food";
            break;
        case ELECTRONICS:
            categoryName = @"Electronics";
            break;
        case ENTERTAINMENT:
            categoryName = @"Entertainment";
            break;
        case HEALTH_FITNESS:
            categoryName = @"Health/Fitness";
            break;
        case SERVICE:
            categoryName = @"Service";
            break;
        case LIFESTYLE:
            categoryName = @"LifeStyle";
            break;
        case FURNITURE:
            categoryName = @"Furniture";
            break;
        case MISC:
            categoryName = @"Misc.";
            break;
        default:
            categoryName = @"Uhoh...";
            break;
    }
    
    cell.label.text = categoryName;
    
    BOOL selected = [[[self getCategoryFilterArray] objectAtIndex:indexPath.row] boolValue];
    UIImage *checkBoxImg = selected ? [UIImage imageNamed:@"Checkbox_Checked"] : [UIImage imageNamed:@"Checkbox_Unchecked"];
    cell.checkboxImageView.image = checkBoxImg;
    
    
    return cell;
    
    
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self toggleCategoryAtIndex:indexPath.row];
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
