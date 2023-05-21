//
//  StringHandling.h
//  fasBackTechnician
//
//  Created by User on 22/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringHandling : NSObject

+(BOOL) isValidEmail:(NSString *)checkString;

+(BOOL) checkIfStringHasEightCharacters:(NSMutableString *) string;
+(BOOL) checkIfItHasAtleastOneUpperCase : (NSMutableString *) stringReceived;
+(BOOL) checkIfItHasAtleastOneLowerCase : (NSMutableString *) stringReceived;
+(BOOL) checkIfItHasAtleastOneNumber : (NSMutableString *) stringReceived;
+(BOOL)checkIfItHasAtleastOneSpecialCharacter:(NSMutableString*)stringReceived;

+(NSString *) dateAfterFormating : (NSDate *) date;
+(NSString *) timeAfterFormating : (NSDate *) date;

+(NSString *) removePunctuationFromPhoneNumberString : (NSString *) stringWithPunctuations;
+(BOOL) haveOnlyAlphabets : (NSString *) stringWithPunctuations WithSpecialCharacter : (NSString *) specialCharacterIncluded;
+(BOOL) validAddress : (NSString *) stringWithPunctuations;
+(BOOL) isValidPhoneNumber : (NSString *) stringWithPunctuations;

@end
