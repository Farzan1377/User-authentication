//
//  View3ViewController.h
//  app Security
//
//  Created by Farzan Faghihi on 9/30/15.
//  Copyright (c) 2015 Farzan Faghihi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View3ViewController : UIViewController 

@property (nonatomic) NSMutableArray *myArray;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UITextField *oldPassTextField;
@property (weak, nonatomic) IBOutlet UITextField *PassTextField;

@property (weak, nonatomic) IBOutlet UITextField *confirmPassTextField;
@property (weak, nonatomic) IBOutlet UITextField *addTextField;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;

@end
