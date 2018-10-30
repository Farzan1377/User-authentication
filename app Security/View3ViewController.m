//
//  View3ViewController.m
//  app Security
//
//  Created by Farzan Faghihi on 9/30/15.
//  Copyright (c) 2015 Farzan Faghihi. All rights reserved.
//

#import "View3ViewController.h"
#import "AppSecurity.h"
#import "Table1ViewController.h"
@implementation View3ViewController
-(void)viewDidLoad {
    
    self.oldPassTextField.hidden = YES;
    self.PassTextField.hidden = YES;
    self.confirmPassTextField.hidden = YES;
    
}
-(NSMutableArray *)myArray {
    
    if (!_myArray) {
        _myArray = [[NSMutableArray alloc]init];
    }
    return _myArray;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    animated = YES;
    self.addLabel.hidden = YES;
    NSString *path = [NSString stringWithFormat:@"%@/Documents/info.txt",NSHomeDirectory()];
    NSString *user = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *welcome = @"  Welcome Back ";
    self.welcomeLabel.text = [[welcome stringByAppendingString:user] stringByAppendingString:@"!"];
    
}


- (IBAction)addButtonDidTouched:(id)sender {
    
    if ([self.addTextField.text isEqualToString:@""]) {
        self.addTextField.placeholder = @"Enter Something here first!";
    }
    else {
        NSString *path2 = [NSString stringWithFormat:@"%@/Documents/info4.txt",NSHomeDirectory()];
        [self.myArray addObject:self.addTextField.text];
        [self.myArray writeToFile:path2 atomically:YES];
        self.addTextField.text = @"";
        self.addTextField.placeholder = @"Add to List";
        if ([self.addTextField.text isEqualToString:@""]) {
            [UIView animateWithDuration:4 animations:^{
                self.addLabel.hidden = NO;
                self.addLabel.alpha = 0;
            }];
        }
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    return cell;
    
}

- (IBAction)resetButtonDidTouched:(id)sender {
    
    BOOL firstTime = YES;
    NSString *path2 = [NSString stringWithFormat:@"%@/Documents/info2.txt",NSHomeDirectory()];
    NSString *data = [[NSString alloc] initWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    if (firstTime == YES) {
        
        self.oldPassTextField.hidden = NO;
        
        self.PassTextField.hidden = NO;
        self.confirmPassTextField.hidden = NO;
    }
    else {
        
        if (![self.oldPassTextField.text isEqualToString:@""]) {
            if (self.oldPassTextField.text != data) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Your old password is wrong!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if (self.PassTextField.text != self.confirmPassTextField.text) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Passwords don't match!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                AppSecurity *a1 = [[AppSecurity alloc] init];
                [a1 checkPolicyWithPassword:self.PassTextField.text];
                if ([[a1 checkPolicyWithPassword:self.PassTextField.text] isEqualToString:@"no errors"]) {
                    data = self.confirmPassTextField.text;
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Password changed successfully!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:        [a1 checkPolicyWithPassword:self.PassTextField.text] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
            
        }
        
    }
    
}

@end
