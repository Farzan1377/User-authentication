//
//  ViewController.m
//  app Security
//
//  Created by Farzan Faghihi on 9/3/15.
//  Copyright (c) 2015 Farzan Faghihi. All rights reserved.
//
#import <CommonCrypto/CommonCrypto.h>
#import "ViewController.h"
#import "AppSecurity.h"
#import "View2ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmTextField.delegate = self;
    self.strenghtLabel.hidden = YES;
    self.passwordProgressView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([self.userNameTextField isFirstResponder]) {
        [self.passwordTextField becomeFirstResponder];
    }
    else if ([self.passwordTextField isFirstResponder]) {
        [self.confirmTextField becomeFirstResponder];
    }
    else{
        [self.userNameTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        [self.confirmTextField resignFirstResponder];
        if (![self.passwordTextField.text isEqualToString:self.confirmTextField.text]) {
            self.logLabel.text = @"Passwords don't match!";
        }
        else {
            AppSecurity *appSecurity = [[AppSecurity alloc] init];
            self.logLabel.text = [appSecurity checkPolicyWithPassword:self.passwordTextField.text];
            if ([self.logLabel.text  isEqual: @"no errors"]) {
                if ([self.strenghtLabel.text isEqualToString:@"Weak"] || [self.strenghtLabel.text isEqualToString:@"Not Bad"]) {
                    NSString *strenghtString = [[@"Your password is " stringByAppendingString:self.strenghtLabel.text] stringByAppendingString:@". Are you sure You want to continue?"];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:strenghtString delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Improve password", nil];
                    alert.delegate = self;
                    [alert show];
                }
                else {
                    NSString *path = [NSString stringWithFormat:@"%@/Documents/info.txt",NSHomeDirectory()];
                    NSString *path2 = [NSString stringWithFormat:@"%@/Documents/info2.txt",NSHomeDirectory()];
                    
                    
                    [self.passwordTextField.text writeToFile:path2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
                    [self.userNameTextField.text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
                    [self performSegueWithIdentifier:@"a" sender:nil];
                }
            }
        }
    }
    return YES;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        NSString *path = [NSString stringWithFormat:@"%@/Documents/info.txt",NSHomeDirectory()];
        NSString *path2 = [NSString stringWithFormat:@"%@/Documents/info2.txt",NSHomeDirectory()];
        
        [self.passwordTextField.text writeToFile:path2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [self.userNameTextField.text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [self performSegueWithIdentifier:@"a" sender:nil];
        NSLog(@"%@",NSHomeDirectory());
    }
    else {
        [self.passwordTextField becomeFirstResponder];
    }
    
}

- (IBAction)passwordTextFieldchanged:(id)sender {
    
    AppSecurity *appSecurity = [[AppSecurity alloc]init];
    if (![self.passwordTextField.text  isEqual: @""]) {
        self.passwordProgressView.hidden = NO;
        self.strenghtLabel.hidden = NO;
        if ([[appSecurity checkPasswordStrenghtWithString:self.passwordTextField.text] isEqualToString:@"Weak"]) {
            self.strenghtLabel.text = @"Weak";
            self.strenghtLabel.textColor = [UIColor redColor];
            [self.passwordProgressView setProgress:0.04 animated:YES];
            self.passwordProgressView.progressTintColor = [UIColor redColor];
        }
        if ([[appSecurity checkPasswordStrenghtWithString:self.passwordTextField.text] isEqualToString:@"Not Bad"]) {
            self.strenghtLabel.text = @"Not Bad";
            self.strenghtLabel.textColor = [UIColor yellowColor];
            [self.passwordProgressView setProgress:0.5 animated:YES];
            self.passwordProgressView.progressTintColor = [UIColor yellowColor];
        }
        if ([[appSecurity checkPasswordStrenghtWithString:self.passwordTextField.text] isEqualToString:@"Strong"]) {
            self.strenghtLabel.text = @"Strong";
            self.strenghtLabel.textColor = [UIColor greenColor];
            [self.passwordProgressView setProgress:1 animated:YES];
            self.passwordProgressView.progressTintColor = [UIColor greenColor];
        }
    }
    
}

- (IBAction)saveButtonDidTouched:(id)sender {
    
    if (![self.passwordTextField.text isEqualToString:self.confirmTextField.text]) {
        self.logLabel.text = @"Passwords don't match!";
    }
    else {
        AppSecurity *appSecurity = [[AppSecurity alloc] init];
        self.logLabel.text = [appSecurity checkPolicyWithPassword:self.passwordTextField.text];
        if ([self.logLabel.text  isEqual: @"no errors"]) {
            if ([self.strenghtLabel.text isEqualToString:@"Weak"] || [self.strenghtLabel.text isEqualToString:@"Not Bad"]) {
                NSString *strenghtString = [[@"Your password is " stringByAppendingString:self.strenghtLabel.text] stringByAppendingString:@". Are you sure You want to continue?"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:strenghtString delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Improve password", nil];
                alert.delegate = self;
                [alert show];
            }
            else {
                NSString *path = [NSString stringWithFormat:@"%@/Documents/info.txt",NSHomeDirectory()];
                NSString *path2 = [NSString stringWithFormat:@"%@/Documents/info2.txt",NSHomeDirectory()];
                [self.passwordTextField.text writeToFile:path2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
                [self.userNameTextField.text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
                [self performSegueWithIdentifier:@"a" sender:nil];
            }
        }
    }
    
}

@end

