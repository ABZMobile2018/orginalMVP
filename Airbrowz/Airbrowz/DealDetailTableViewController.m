//
//  DealDetailTableViewController.m
//  Airbrowz
//
//  Created by Denny on 2015-11-01.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import "DealDetailTableViewController.h"
#import "DealDetailCompanyTableViewCell.h"
#import "DealDetailDealTableViewCell.h"
#import "DealDetailGmapTableViewCell.h"
#import "DealDetailYoutubeTableViewCell.h"
@import GoogleMaps;

@interface DealDetailTableViewController ()

    @property DealDetailYoutubeTableViewCell *youtubeVideoCell;


@end

@implementation DealDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Preallocate youtubeVideoCell once -- we won't dequeue from tableview since it takes bit of time for init
    NSIndexPath *ytcellIP = [NSIndexPath indexPathForRow:Cell_YoutubeVideo inSection:0];
    self.youtubeVideoCell = [self.tableView dequeueReusableCellWithIdentifier:[self cellReuseIdentifierForIndexPath:ytcellIP] forIndexPath:ytcellIP];
    
    self.tableView.separatorColor = [UIColor clearColor];
}
-(void) viewWillAppear:(BOOL)animated {
    // Preconfigure youtubeCell
    NSIndexPath *ytcellIP = [NSIndexPath indexPathForRow:Cell_YoutubeVideo inSection:0];
    [self dequeueAndConfigureCellForYoutube:ytcellIP];
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.moreDealsModel == nil || [self.moreDealsModel count] == 0) {
        return 4;
    }
    else {
        return 5+ [self.moreDealsModel count]; //Base 4 + 1 For heading + array count for items
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    switch(indexPath.row) {
        case Cell_CompanyDetails:
            cell = [self dequeueAndConfigureCellForCompanyInfo:indexPath];
            break;
        case Cell_MainDealImage:
            cell= [self dequeueAndConfigureCellForDeal:indexPath];
            break;
        
        case Cell_GoogleMaps:
            cell = [self dequeueAndConfigureCellForGmap:indexPath];
            break;
        case Cell_YoutubeVideo:
            cell = self.youtubeVideoCell; // We're preconfiguring youtube videocell since takes long time to init
            break;
        case Cell_MoreDealsHeading:
            cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellReuseIdentifierForIndexPath:indexPath] forIndexPath:indexPath];
            break;
        default:
            cell = [self dequeueAndConfigureCellForDeal:indexPath];
    }
    
    return cell;
}

-(DealDetailCompanyTableViewCell *) dequeueAndConfigureCellForCompanyInfo: (NSIndexPath *) indexPath {
    DealDetailCompanyTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellReuseIdentifierForIndexPath:indexPath] forIndexPath:indexPath];
    
    NSString *address = [NSString stringWithFormat:@"%@ %@\n%@, %@\n%@",
                         self.model[@"owner"][@"street_number"],
                         self.model[@"owner"][@"street_name"],
                         self.model[@"owner"][@"city"],
                         self.model[@"owner"][@"province"],
                         self.model[@"owner"][@"postal_code"]];
    // Set Address
    cell.companyAddressLabel.text = address;
    // Set Company Name
    cell.companyNameLabel.text = self.model[@"owner"][@"company_name"];
    
    
    // Load Logo in background
    cell.companyLogoImageView.image = [UIImage imageNamed:@"companyLogoPlaceholder"]; //placeholder
    cell.companyLogoImageView.file = self.model[@"owner"][@"company_logo"];
    [cell.companyLogoImageView loadInBackground];
    return cell;
}


-(DealDetailDealTableViewCell *) dequeueAndConfigureCellForDeal:(NSIndexPath *) indexPath {
    DealDetailDealTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellReuseIdentifierForIndexPath:indexPath] forIndexPath:indexPath];
    
    cell.dealImageView.image = [UIImage imageNamed:@"dealImagePlaceholder"];
    cell.dealImageView.file = self.model[@"mainImage"];
    cell.dealHeading.text = self.model[@"heading"];
    
    [cell.dealImageView loadInBackground];
    
    
    return cell;
}

-(DealDetailGmapTableViewCell *) dequeueAndConfigureCellForGmap:(NSIndexPath *) indexPath {
    
    DealDetailGmapTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellReuseIdentifierForIndexPath:indexPath] forIndexPath:indexPath];
    
    [cell.mapPlaceholder clear];
    GMSCameraPosition *camera = [GMSCameraPosition
                                 cameraWithLatitude:((PFGeoPoint *)self.model[@"location"]).latitude
                                 longitude:((PFGeoPoint *)self.model[@"location"]).longitude
                                 zoom:15];
    
    cell.mapPlaceholder.camera= camera;
    //cell.mapPlaceholder = [GMSMapView mapWithFrame:cell.mapPlaceholder.frame camera:camera];
    cell.mapPlaceholder.myLocationEnabled = YES;
    cell.mapPlaceholder.settings.consumesGesturesInView = NO;
    cell.mapPlaceholder.settings.scrollGestures = NO;
    //cell.mapPlaceholder.camera = camera;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(((PFGeoPoint *)self.model[@"location"]).latitude,
                                                 ((PFGeoPoint *)self.model[@"location"]).longitude);
    marker.title = self.model[@"owner"][@"company_name"];
    marker.map = cell.mapPlaceholder;
    

    return cell;
}

-(DealDetailYoutubeTableViewCell *) dequeueAndConfigureCellForYoutube: (NSIndexPath *) indexPath {
    // Do not dequeue for youtube... takes bit of time to init
    // Let's instantiate once in viewDidLoad
    if (self.model[@"youtube_video_id"] && [self.model[@"youtube_video_id"] length] != 0) {
        [self.youtubeVideoCell.youtubePlaceholder loadWithVideoId:self.model[@"youtube_video_id"]];

    }
    
    return self.youtubeVideoCell;
}


- (NSString *) cellReuseIdentifierForIndexPath: (NSIndexPath *) indexPath {
    
    static NSString *companyDetailsId = @"cell_companyDetails";
    static NSString *mainDealImageId = @"cell_mainDeal";
    static NSString *googleMapId = @"cell_googlemaps";
    static NSString *youtubeVideoId = @"cell_youtube";
    static NSString *moreDealsHeading = @"cell_moreDealsHeading";
    
    switch (indexPath.row) {
        case Cell_CompanyDetails:
            return companyDetailsId;
        case Cell_MainDealImage:
            return mainDealImageId;
        case Cell_GoogleMaps:
            return googleMapId;
        case Cell_YoutubeVideo:
            return youtubeVideoId;
        case Cell_MoreDealsHeading:
            return moreDealsHeading;
            
        default:
            return mainDealImageId;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case Cell_CompanyDetails:
            return 120.0;
        case Cell_MainDealImage:
            return 280.0;
        case Cell_GoogleMaps:
            return 200.0;
        case Cell_YoutubeVideo:
            if (self.model[@"youtube_video_id"] && [self.model[@"youtube_video_id"] length] != 0)
                return 250.0;
            else
                return 0.0;
        case Cell_MoreDealsHeading:
            return 35.0f;
            
        default: // More deals
            return 280.0;
    }
}


- (IBAction)onGoogleMapsButtonClick:(id)sender {
    
    NSString *query = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@+%@+%@+%@",
                       self.model[@"owner"][@"street_number"],
                       self.model[@"owner"][@"street_name"],
                       self.model[@"owner"][@"city"],
                       self.model[@"owner"][@"postal_code"]
                       ];
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:query]];
    
    /* Apparently there's no way to set marker when using googlemap through sharedApplication according to GoogleMaps URL scheme
    if ([[UIApplication sharedApplication] canOpenURL:
         [NSURL URLWithString:@"comgooglemaps://"]]) {
        
        //NSString *query = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%f,%f", [self.model[@"location"] latitude], [self.model[@"location" ]longitude]];

    } else {
        NSLog(@"Can't use comgooglemaps://");
    }*/

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
