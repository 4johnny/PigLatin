//
//  PigLatinString.m
//  PigLatin
//
//  Created by Johnny on 2015-01-16.
//  Copyright (c) 2015 Empath Solutions. All rights reserved.
//

#import "NSString+PigLatinString.h"


@interface NSString (PigLatinStringPrivate)

-(NSString*) pigLatinizeWord;

@end

	
@implementation NSString (PigLatinStringPrivate)

-(NSString*) pigLatinizeWord {

	NSString* word = self;
	
	NSCharacterSet* vowels = [NSCharacterSet characterSetWithCharactersInString:@"aeiou"];
	NSRange range = [word rangeOfCharacterFromSet:vowels];
	
	if (range.location != NSNotFound) {
		NSString* consonantsPrefix = [word substringToIndex:range.location];
		word = [word substringFromIndex:range.location];
		word = [word stringByAppendingString:consonantsPrefix];
	}
	
	return [word stringByAppendingString:@"ay"];
}

@end


@implementation NSString (PigLatinString)

-(NSString*) stringByPigLatinization {
	
	// Tokenize sentence into array of words.
	NSArray* words = [[self componentsSeparatedByString:@" "] mutableCopy];

	// Pig-latinize each word and accumulate in new array.
	NSMutableArray* pigWords = [[NSMutableArray alloc] initWithCapacity:words.count];
	for (NSString* word in words) {
		[pigWords addObject:[word pigLatinizeWord]];
	}
	
	// Join words back into sentence.
	return [pigWords componentsJoinedByString:@" "];
}


@end
