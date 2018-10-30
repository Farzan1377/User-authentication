//
//  AppSecurity.h
//  app Security
//
//  Created by Farzan Faghihi on 9/3/15.
//  Copyright (c) 2015 Farzan Faghihi. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import <Foundation/Foundation.h>

@interface AppSecurity : NSObject 
@property NSString *masterPassword;
@property NSString *userName;
-(BOOL)checkMasterPasswordMatchWith:(NSString *)inputPassword;
-(NSString *)checkPolicyWithPassword:(NSString *)inputPassword;
-(NSString *)checkPasswordStrenghtWithString:(NSString *)inputPass;
-(NSData *) encryptString:(NSString *)plainText withKey:(NSString *)key;
-(NSString *) decryptData:(NSData *)cipherText withKey:(NSString *)key;
-(void)writeDataToFile: (NSString *)path withData: (NSString *)data1 and:(NSString *)data2;

@end
