//
//  MasterViewController.m
//  Airbrowz
//
//  Created by Denny on 2015-10-26.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import "MasterViewController.h"
#import "DealTableViewCell.h"
@interface MasterViewController () <UITableViewDelegate>



@end

@implementation MasterViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self proximityChanged: self.proximitySlider];
    
    [self.proximitySlider addTarget:self action:@selector(proximityChanged:) forControlEvents:UIControlEventValueChanged];
    [self.proximitySlider setThumbImage:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateNormal];
    [self.proximitySlider setThumbImage:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateHighlighted];
    
    
    //self.proximitySlider.transform = CGAffineTransformMakeScale(0.5, 0.5);

   //[[self navigationController] setNavigationBarHidden:YES animated:YES];

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
