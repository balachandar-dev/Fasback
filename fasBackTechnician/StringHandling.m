//
//  StringHandling.m
//  fasBackTechnician
//
//  Created by User on 22/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "StringHandling.h"

@implementation StringHandling


+(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark - Validations

+(BOOL) checkIfStringHasEightCharacters:(NSMutableString *) string
{
    if (string.length >= 8) {
        return YES;
    }
    return NO;
}

+(BOOL) checkIfItHasAtleastOneUpperCase : (NSMutableString *) stringReceived
{
    //get all uppercase character set
    NSCharacterSet *cset = [NSCharacterSet uppercaseLetterCharacterSet];
    //Find range for uppercase letters
    NSRange range = [stringReceived rangeOfCharacterFromSet:cset];
    //check it conatins or not
    if (range.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
    
}

+(BOOL) checkIfItHasAtleastOneLowerCase : (NSMutableString *) stringReceived
{
    //get all uppercase character set
    NSCharacterSet *cset = [NSCharacterSet lowercaseLetterCharacterSet];
    //Find range for uppercase letters
    NSRange range = [stringReceived rangeOfCharacterFromSet:cset];
    //check it conatins or not
    if (range.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
    
}

+(BOOL) checkIfItHasAtleastOneNumber : (NSMutableString *) stringReceived
{
    //get all uppercase character set
    NSCharacterSet *cset = [NSCharacterSet decimalDigitCharacterSet];
    //Find range for uppercase letters
    NSRange range = [stringReceived rangeOfCharacterFromSet:cset];
    //check it conatins or not
    if (range.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
    
}

+(BOOL)checkIfItHasAtleastOneSpecialCharacter:(NSMutableString*)stringReceived{
    
    NSCharacterSet  *set= [NSCharacterSet characterSetWithCharactersInString:@"!@#$%^&*()_+-={}[]|\":;'<>,./?"];
    
    //Find range for uppercase letters
    NSRange range = [stringReceived rangeOfCharacterFromSet:set];
    //check it conatins or not
    
    
    if (range.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
    
    //    NSString *customStr = @"~`!@#$%^&*()+=-/;:\"\'{}[]<>^?, ";
    //    NSCharacterSet *alphaSet = [NSCharacterSet characterSetWithCharactersInString:customStr];
    //    BOOL isHaveSpecialChar = [[str stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
    //    return !isHaveSpecialChar;
}

+(NSString *) removePunctuationFromPhoneNumberString : (NSString *) stringWithPunctuations
{
    NSCharacterSet *illegalCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    NSString *phoneNumberRemovingPunctuations = [[stringWithPunctuations componentsSeparatedByCharactersInSet:illegalCharSet] componentsJoinedByString:@""];
    return phoneNumberRemovingPunctuations;
}

+(BOOL) haveOnlyAlphabets : (NSString *) stringWithPunctuations WithSpecialCharacter:(NSString *)specialCharacterIncluded
{
    NSCharacterSet *characterSetWithStrings = [[NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz %@",specialCharacterIncluded ]] invertedSet];
    
    NSRange r = [stringWithPunctuations rangeOfCharacterFromSet:characterSetWithStrings];
    if (r.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
        return NO;
    }
    return YES;
}


+(BOOL) isValidPhoneNumber : (NSString *) stringWithPunctuations
{
    NSCharacterSet *characterSetWithStrings = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890()-/ "] invertedSet];
    
    NSRange r = [stringWithPunctuations rangeOfCharacterFromSet:characterSetWithStrings];
    if (r.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
        return NO;
    }
    return YES;
}
+(BOOL) validAddress : (NSString *) stringWithPunctuations
{
    NSCharacterSet *characterSetWithStrings = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-/@, "] invertedSet];
    
    NSRange r = [stringWithPunctuations rangeOfCharacterFromSet:characterSetWithStrings];
    if (r.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
        return NO;
    }
    return YES;
}


@end
