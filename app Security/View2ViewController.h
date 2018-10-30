//
//  View2ViewController.h
//  app Security
//
//  Created by Farzan Faghihi on 9/10/15.
//  Copyright (c) 2015 Farzan Faghihi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View2ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property NSString *password;
@property NSString *userName;

@end
