//
//  main.m
//  PigLatin
//
//  Created by Johnny on 2015-01-16.
//  Copyright (c) 2015 Empath Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+PigLatinString.h"

#if __has_feature(objc_arc)
	#define MDLog(format, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:format, ## __VA_ARGS__]);
#else
	#define MDLog(format, ...) CFShow([NSString stringWithFormat:format, ## __VA_ARGS__]);
#endif


int main(int argc, const char * argv[]) {
	@autoreleasepool {

		NSString* sentence = @"Please, ensure my Awesome, excellent sentence is Pig-Latinized!";

		MDLog(@"Sentence: %@", sentence);
		MDLog(@"Pig-Latinized: %@", [sentence stringByPigLatinization]);
	}
    return 0;
}
