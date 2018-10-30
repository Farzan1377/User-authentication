//
//  View2ViewController.m
//  app Security
//
//  Created by Farzan Faghihi on 9/10/15.
//  Copyright (c) 2015 Farzan Faghihi. All rights reserved.
//

#import "View2ViewController.h"

@interface View2ViewController () <UITextFieldDelegate,UIAlertViewDelegate>

@end

@implementation View2ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [self.userNameTextField becomeFirstResponder];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    else {
        if ([self.userNameTextField.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Enter your username!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            int incorrectTimes = 0;
            NSString *path = [NSString stringWithFormat:@"%@/Documents/info.txt",NSHomeDirectory()];
            NSString *path2 = [NSString stringWithFormat:@"%@/Documents/info2.txt",NSHomeDirectory()];
            NSString *data1 = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            NSString *data2 = [[NSString alloc] initWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
            if ([self.userNameTextField.text isEqualToString:data1]  && [self.passwordTextField.text isEqualToString:data2]) {
                [self performSegueWithIdentifier:@"b" sender:nil];
            }
            else {
                if (incorrectTimes > 3) {
                    [self.userNameTextField resignFirstResponder];
                    [self.passwordTextField resignFirstResponder];
                    NSString *error = [NSString stringWithFormat:@"For security concerns, we've disabled your account."];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login attempt failed" message:error delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Your username or password was wrong!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                incorrectTimes++;
                
            }
        }
    }
    return YES;
    
}

- (IBAction)enterButtonDidChanged:(id)sender {
    
    int incorrectTimes = 0;
    NSString *path = [NSString stringWithFormat:@"%@/Documents/info.txt",NSHomeDirectory()];
    NSString *path2 = [NSString stringWithFormat:@"%@/Documents/info2.txt",NSHomeDirectory()];
    NSString *data1 = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *data2 = [[NSString alloc] initWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    if ([self.userNameTextField.text isEqualToString:data1]  && [self.passwordTextField.text isEqualToString:data2]) {
        [self performSegueWithIdentifier:@"b" sender:nil];
    }
    else {
        if (incorrectTimes > 3) {
            [self.userNameTextField resignFirstResponder];
            [self.passwordTextField resignFirstResponder];
            NSString *error = [NSString stringWithFormat:@"For security concerns, we've disabled your account."];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login attempt failed" message:error delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Your username or password was wrong!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            incorrectTimes++;
        }
    }
    
}

- (IBAction)signUpClickedOn:(id)sender {
    
    [self performSegueWithIdentifier:@"a" sender:nil];
    
}

@end
