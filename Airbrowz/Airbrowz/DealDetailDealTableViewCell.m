//
//  DealDetailDealTableViewCell.m
//  Airbrowz

#import "DealDetailDealTableViewCell.h"

@implementation DealDetailDealTableViewCell

- (void)awakeFromNib {
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.backgroundColor = [[UIColor lightGrayColor] CGColor];
        bottomBorder.frame = CGRectMake(0, 0, self.frame.size.width, 1);
        [self.layer addSublayer:bottomBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
