//
//  ViewController.h
//  app Security
//
//  Created by Farzan Faghihi on 9/3/15.
//  Copyright (c) 2015 Farzan Faghihi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController <UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *logLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;
- (IBAction)saveButtonDidTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UIProgressView *passwordProgressView;
@property (weak, nonatomic) IBOutlet UILabel *strenghtLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@end

