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
#import "DealDetailTableViewController.h"
#import <Parse/Parse.h>

@interface MasterViewController () <UITableViewDelegate, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *categoryFilterArray;
@property (strong, nonatomic)  NSArray *dealsRawModel;
@property (strong, nonatomic) NSArray *dealsFilteredModel;
@property PFGeoPoint *currentLocation;
@property DealDetailTableViewController *detailViewController;
@end



@implementation MasterViewController {
    int runTwiceToken;
    bool categoryIsHidden;
    double categoryViewOriginYWhenClosed;
    double categoryViewOriginYWhenOpened;
}

- (void) setDealsFilteredModel:(NSArray *)dealsFilteredModel {
    
    _dealsFilteredModel = dealsFilteredModel;
    [self.tableView reloadData];
}

- (void) setDealsRawModel:(NSArray *)dealsRawModel {
    // Apply Filter
 

    _dealsRawModel = dealsRawModel;
    self.dealsFilteredModel = [self applyFilterOnRawModel: _dealsRawModel];
}

-(NSMutableArray *) applyFilterOnRawModel: (NSArray *) rawModel {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (PFObject *deal in rawModel) {
        
        NSInteger cat = [deal[@"category"] intValue];
        PFGeoPoint *dealLoc = deal[@"location"];

        if ([[self.categoryFilterArray objectAtIndex:cat] boolValue]) {
            // * 1000 for km to m conversion
  
            if ([dealLoc distanceInKilometersTo: self.currentLocation] * 1000 <= self.proximitySlider.value) {
                [result addObject: deal];
            }
        }
    }

//    for (PFObject *item in result) {
//        NSLog(@"%@", [item objectId]);
//    }
    
    return result;
}

- (void) configureCategorySelector {
    
    self.categoryLabel.userInteractionEnabled = YES;
    self.categoryArrow.userInteractionEnabled =YES;
    
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCategoryLabelClick)];
    [self.categoryLabel addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGesture2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCategoryLabelClick)];
    [self.categoryArrow addGestureRecognizer:tapGesture2];
    
    
    [self.proximitySlider addTarget:self action:@selector(proximityChanged:) forControlEvents:UIControlEventValueChanged];
    [self.proximitySlider setThumbImage:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateNormal];
    [self.proximitySlider setThumbImage:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateHighlighted];

}


- (NSMutableArray *) categoryFilterArray {

    if (_categoryFilterArray == nil) {
        _categoryFilterArray = [[[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_CATEGORY_KEY] mutableCopy];
        
        // Is it first time creating category?
        if (_categoryFilterArray == nil) {
            
            _categoryFilterArray = [[NSMutableArray alloc] init];
            for (int i = 0 ; i <= Misc ; i++) { // MISC is the last item
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
    
    //NSLog(@"fetching deals");
    // First find my location
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *myLocation, NSError *error) {
        if (!error) {
            self.currentLocation = myLocation;
            

            // Create a query for places
            PFQuery *query = [PFQuery queryWithClassName:@"Deals"];
            // Interested in locations near user.
            [query whereKey:@"location" nearGeoPoint:myLocation];
            // Include User object
            [query includeKey:@"owner"];
            
            NSDate *currentDate =  [[NSDate alloc] init];
            [query whereKey:@"expiry" greaterThan: currentDate];
            [query orderByAscending:@"expiry"];
            // Limit what could be a lot of points.
            query.limit = 100;
            
            
            
            
            // Final list of objects
          
            [query findObjectsInBackgroundWithBlock:^(NSArray *deals, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    self.dealsRawModel = deals;
                    
           
                    
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];

            
            
        }
        else { //Error
            
            NSLog(@"Problem encountered while getting current geolocation");
            NSLog(@"%@", error);
        }
    }];
  
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"AirbrowzLogo"]];

    [self configureCategorySelector];
    
    self.proximitySlider.value = [[[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_PROXIMITY_KEY] floatValue];
    [self proximityChanged: self.proximitySlider];


    
    [self fetchDeals];
    
    categoryViewOriginYWhenOpened = self.categoryCollectionView.frame.origin.y;
    categoryViewOriginYWhenClosed = self.categoryCollectionView.frame.origin.y - self.categoryCollectionView.frame.size.height;
    
    // User white indicator for better visibility
    self.categoryCollectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    

    // Update deals every 5 secs..  TODO: this can be optimized... web request every 5s is too much... use comet or something.
    [NSTimer scheduledTimerWithTimeInterval: 5.0
                                             target: self
                                           selector: @selector(fetchDeals)
                                           userInfo: nil
                                            repeats: YES];
    
    

 
}



-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    runTwiceToken = 0;
    self.categoryCollectionView.hidden = NO;
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (runTwiceToken < 2) { // This block must exactly run twice... it's a hack fix... only god knows why... sorry...
        CGRect rect = CGRectMake(self.categoryCollectionView.frame.origin.x,
                                 categoryViewOriginYWhenClosed,
                                 self.categoryCollectionView.frame.size.width,
                                 self.categoryCollectionView.frame.size.height);
        
        self.categoryCollectionView.frame = rect;
        categoryIsHidden = true;
        runTwiceToken++;
        
    }
    NSLog(@"here");
}




- (void) onCategoryLabelClick {
    categoryIsHidden ? [self showCategories] : [self hideCategoriesWithAnimation: YES];
   
}

- (IBAction)proximityChanged:(UISlider *)sender {
    runTwiceToken = 0; // Hack Fix regarding collectionview
    
    NSString *distanceString;
    
    if (sender.value >= 1000.0) {
        distanceString = [NSString stringWithFormat:@"%.1f km", sender.value/1000];
    }
    else {
        distanceString = [NSString stringWithFormat:@"%.f m", sender.value];
    }
    self.proximityRangeLabel.text = distanceString;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}



- (void) showCategories {
    categoryIsHidden = false;

    [UIView animateWithDuration:0.5f animations:^{
        self.categoryCollectionView.frame =
        CGRectMake(self.categoryCollectionView.frame.origin.x,
                   categoryViewOriginYWhenOpened,
                   self.categoryCollectionView.frame.size.width,
                   self.categoryCollectionView.frame.size.height);
        self.categoryArrow.transform = CGAffineTransformRotate(self.categoryArrow.transform, M_PI );
    } completion:^(BOOL finished){
        [self.categoryCollectionView flashScrollIndicators]; // Let userknow it's scrollable!!
    }];
    
}

- (void) hideCategoriesWithAnimation: (BOOL) animated {
    categoryIsHidden = true;

    
    CGRect rect = CGRectMake(self.categoryCollectionView.frame.origin.x,
                             categoryViewOriginYWhenClosed,
                             self.categoryCollectionView.frame.size.width,
                             self.categoryCollectionView.frame.size.height);
    
    if (animated) {
        [UIView animateWithDuration:0.5f animations:^{
            self.categoryCollectionView.frame = rect;
            self.categoryArrow.transform = CGAffineTransformRotate(self.categoryArrow.transform, M_PI );
        }];
    }
    else {
     
        self.categoryCollectionView.frame = rect;
    }
  
    
}


/* ------------------- Deals TableView Delegate ------------------- */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // No data yet or no elements in filtered model
    if (self.dealsFilteredModel == nil || [self.dealsFilteredModel count] == 0)
        return 1;
    
    return [self.dealsFilteredModel count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

#define DEAL_CELL_LOADING_REUSE_ID @"DealLoadingCell"
#define DEAL_CELL_REUSE_ID @"DealCell"
#define DEAL_CELL_NO_RESULT_ID @"DealNoResultCell"
    DealTableViewCell *cell;
    
    // No model yet - Display loading cell
    if (self.dealsFilteredModel == nil) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:DEAL_CELL_LOADING_REUSE_ID forIndexPath:indexPath];
    }
    // Filtered model has no deals
    else if ([self.dealsFilteredModel count] == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:DEAL_CELL_NO_RESULT_ID forIndexPath:indexPath];
    }
    // Have something to show..
    else {
        PFObject * model = [self.dealsFilteredModel objectAtIndex:indexPath.row];
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:DEAL_CELL_REUSE_ID forIndexPath:indexPath];
        
        // Set Heading Label
        cell.dealHeadingLabel.text = model[@"heading"];
        
        // Set Distance String Label
        double distance = [self.currentLocation distanceInKilometersTo:model[@"location"]] * 1000;
        NSString *distanceString = [NSString stringWithFormat:@"%.f meters from you", distance];
        cell.dealDistanceLabel.text = distanceString;
        
        // Set Image in background
        cell.mainImageView.image = [UIImage imageNamed:@"dealImagePlaceholder"];
        cell.mainImageView.file = model[@"mainImage"];
        [cell.mainImageView loadInBackground];
        
        
        // Set Expiry Label
        NSDate *expiry = model[@"expiry"];
        cell.expiryLabel.text = [AirbrowzCommons stringForExpirayLabel:expiry];
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.detailViewController == nil) {
        self.detailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"detailView"];
    }
    if (self.detailViewController) {
        PFObject *dealDetail = [self.dealsFilteredModel objectAtIndex:indexPath.row];
        self.detailViewController.model = dealDetail;
        
        [self.detailViewController.tableView reloadData];

        self.detailViewController.title = dealDetail[@"owner"][@"company_name"];
        
        
        self.detailViewController.moreDealsModel =
        [self moreDealsFromOwner:[dealDetail[@"owner"] objectId] except: [dealDetail objectId]];
        
        // Push the view controller.
        [self.detailViewController.tableView reloadData];
        [self.navigationController pushViewController:self.detailViewController animated:YES];
        
        self.categoryCollectionView.hidden = true;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(NSArray *) moreDealsFromOwner:(NSString *) ownerId except:(NSString*) exceptObjectId {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (PFObject *deal in self.dealsFilteredModel) {
        if ([[deal[@"owner"] objectId] isEqualToString: ownerId]) {

            if (![[deal objectId] isEqualToString:exceptObjectId]) {
                [result addObject:deal];
            }
        }
    }
    
    return result;
}

/* ------------------- Categories CollectionView Delegate------------------- */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.categoryFilterArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
#define CATEGORY_CELL_REUSE_ID @"CategoryCell"
    
    CategoryCollectionViewCell *cell = [self.categoryCollectionView dequeueReusableCellWithReuseIdentifier:CATEGORY_CELL_REUSE_ID forIndexPath:indexPath];
    
    NSString *categoryName;
    
    switch (indexPath.row) {
        case MaternityAndChildrensWear:
            categoryName = @"Maternity & Children’s wear";
            break;
        case MensFashion:
            categoryName = @"Men’s Fashion";
            break;
        case WomensFashion:
            categoryName = @"Women’s Fashion";
            break;
        case BooksMusicGamesGifts:
            categoryName = @"Books, Music, Games & Gifts";
            break;
        case ComputersTabletsMobiles:
            categoryName = @"Computers, Tablets & Mobiles";
            break;
        case HandbagsFootwear:
            categoryName = @"Handbags & Footwear";
            break;
        case HealthBeauty:
            categoryName = @"Health & Beauty";
            break;
        case FitnessWellBeing:
            categoryName = @"Fitness & Well-Being";
            break;
        case FoodDrink:
            categoryName = @"Food & Drink";
            break;
        case ElectronicsEntertainment:
            categoryName = @"Electronics & Entertainment";
            break;
        case Automotive:
            categoryName = @"Automotive";
            break;
        case HomeGarden:
            categoryName = @"Home & Garden";
            break;
        case Services:
            categoryName = @"Services";
            break;
        case SportsOutdoorTravel:
            categoryName = @"Sports, Outdoor & Travel";
            break;
        case Events:
            categoryName = @"Events";
            break;
        case Grocery:
            categoryName = @"Grocery";
            break;
        case Misc:
            categoryName =@"Misc";
            break;
        default:
            categoryName = @"Uhoh...";
            break;
    }
    
    cell.label.text = categoryName;
    
    BOOL selected = [[self.categoryFilterArray objectAtIndex:indexPath.row] boolValue];
    UIImage *checkBoxImg = selected ? [UIImage imageNamed:@"Checkbox_Checked"] : [UIImage imageNamed:@"Checkbox_Unchecked"];
    cell.checkboxImageView.image = checkBoxImg;
    
    
    return cell;
    
    
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self toggleCategoryAtIndex:indexPath.row];

    self.dealsFilteredModel = [self applyFilterOnRawModel: self.dealsRawModel];
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
    self.dealsFilteredModel = [self applyFilterOnRawModel: self.dealsRawModel];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:self.proximitySlider.value] forKey:USER_DEFAULT_PROXIMITY_KEY];
}
@end
