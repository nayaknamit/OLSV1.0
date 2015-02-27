//
//  PatientLiveCellTableViewCell.h
//  OLS
//
//  Created by Namit Nayak on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientLiveCellTableViewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *itemTypeLabel;
@property (nonatomic,strong)IBOutlet UIImageView *bgImageView;
@property (nonatomic,strong)IBOutlet UIImageView *itemTypeImageView;
@end
