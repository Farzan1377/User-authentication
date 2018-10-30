//
//  AppSecurity.m
//  app Security
//
//  Created by Farzan Faghihi on 9/3/15.
//  Copyright (c) 2015 Farzan Faghihi. All rights reserved.
//

#import "AppSecurity.h"

@implementation AppSecurity

// checks if inputPassword follows password policies
-(NSString *)checkPolicyWithPassword:(NSString *)inputPassword {
    
    if (inputPassword.length <= 4) {
        return @"Passwords need to be at least 5 letters!";
    }
    BOOL isWithUpperCase = NO;
    BOOL isWithLowerCase = NO;
    BOOL isWithNumbers = NO;
    BOOL isWithSymbols = NO;
    for (int i = 0; i<inputPassword.length; i++) {
        
        for (int ascii = 33; ascii<=47; ascii++) {
            if ((int)[inputPassword characterAtIndex:i]==ascii) {
                isWithSymbols = YES;
            }
        }
        for (int ascii = 48; ascii<=57; ascii++) {
            if ((int)[inputPassword characterAtIndex:i]==ascii) {
                isWithNumbers = YES;
            }
        }
        for (int r = 65; r<=90; r++) {
            if ((int)[inputPassword characterAtIndex:i]==r) {
                isWithUpperCase = YES;
            }
        }
        for (int s= 97; s<=122; s++) {
            if ((int)[inputPassword characterAtIndex:i]==s) {
                isWithLowerCase = YES;
            }
        }
    }
    if (isWithLowerCase == NO) {
        return @"Password need at least one lowercase";
    }
    if (isWithUpperCase == NO) {
        return @"Password need at least one uppercase";
    }
    if (isWithSymbols == YES) {
        return @"Password shouldn't contain symbols";
    }
    if (isWithNumbers == NO) {
        return @"Password need at least one number";
    }
    return @"no errors";
    
}

// checks if inputPass is strong based on # of different characters (symbol, lowercase, uppercase, etc)
-(NSString *)checkPasswordStrenghtWithString:(NSString *)inputPass {
    
    int num = 0;
    for (int i = 0 ; i<inputPass.length ; i++) {
        if (65 <= (int)[inputPass characterAtIndex:i] && (int)[inputPass characterAtIndex:i] <= 90) {
            num++;
        }
        if (97 <= (int)[inputPass characterAtIndex:i] && (int)[inputPass characterAtIndex:i] <= 122) {
            num++;
        }
        if (48 <= (int)[inputPass characterAtIndex:i] && (int)[inputPass characterAtIndex:i] <= 57) {
            num++;
        }
    }
    if (num > 8) {
        return @"Strong";
    }
    else if (num < 9 && num > 5){
        return @"Not Bad";
    }
    else {
        return @"Weak";
    }
    return @"";
    
}

// encrypts plainText using key with AES256 standard
-(NSData *)encryptString:(NSString *)plainText withKey:(NSString *)key{
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [plainText length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          nil, dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
    
}

-(BOOL)checkMasterPasswordMatchWith:(NSString *)inputPassword{
    
    if (inputPassword == self.masterPassword) {
        return YES;
    }
    else {
        return NO;
    }
    
}

@end
