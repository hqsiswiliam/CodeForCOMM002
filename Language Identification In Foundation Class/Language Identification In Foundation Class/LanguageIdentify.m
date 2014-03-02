//
//  LanguageIdentify.m
//  Language Identification In Foundation Class
//
//  Created by H QS on 14-1-8.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "LanguageIdentify.h"

@implementation LanguageIdentify
-(NSString*) lookingForNonce:(NSString *)inputString{
    self.outputString = @"";
    NSLinguisticTaggerOptions options = NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerJoinNames;
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes: [NSLinguisticTagger availableTagSchemesForLanguage:@"en"] options:options];
    tagger.string = inputString;
    [tagger enumerateTagsInRange:NSMakeRange(0, [inputString length]) scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass options:options usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
        NSString *token = [inputString substringWithRange:tokenRange];
        if ([tag isEqualToString:NSLinguisticTagNoun]) {
            self.outputString = token;
            NSLog(@"%@",self.outputString);
        }
    }];
    return self.outputString;
}
@end
