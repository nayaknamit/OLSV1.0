//
//  SuggestPrescriptionViewController.m
//  OLS
//
//  Created by Hackathon on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "SuggestPrescriptionViewController.h"

@interface SuggestPrescriptionViewController (){
    UIDatePicker* datepicker;
}
@property (weak, nonatomic) IBOutlet UITextField *reportSelection;
@property (weak, nonatomic) IBOutlet UITextField *timeSelection;
@property (weak, nonatomic) IBOutlet UITextView *textArea;

@end

@implementation SuggestPrescriptionViewController
- (IBAction)submitAction:(id)sender {

    self.reportSelection.text=@"";
    self.timeSelection.text=@"";
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"The prescription has been saved to database" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];

}

- (IBAction)date:(id)sender {
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 300)];
    datepicker.datePickerMode = UIDatePickerModeDate;
    datepicker.hidden = NO;
    datepicker.date = [NSDate date];
    
    [datepicker addTarget:self
                   action:@selector(LabelChange:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datepicker]; //this can set value of selected date to your label change according to your condition
    
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"]; // from here u can change format..
    self.timeSelection.text=[df stringFromDate:datepicker.date];
}
- (void)LabelChange:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"];
    self.timeSelection.text = [NSString stringWithFormat:@"%@",
                          [df stringFromDate:datepicker.date]];
    [datepicker removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
