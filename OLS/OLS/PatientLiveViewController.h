//
//  PatientLiveViewController.h
//  OLS
//
//  Created by Namit Nayak on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientLiveViewController : UIViewController <NSStreamDelegate>
@property (nonatomic,strong)NSMutableArray *patientArr;
@property (nonatomic,strong)NSMutableDictionary *dataDictionary;
@end
