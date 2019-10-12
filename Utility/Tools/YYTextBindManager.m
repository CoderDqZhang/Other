//
//  YYTextBindManager.m
//  Touqiu
//
//  Created by Zhang on 2019/10/11.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

#import "YYTextBindManager.h"
@implementation YYTextBindManager

- (instancetype)init {
    self = [super init];
    NSString *pattern = @"@[-_a-zA-Z0-9\u4E00-\u9FA5]+[,，]";
    self.regex = [[NSRegularExpression alloc] initWithPattern:pattern options:kNilOptions error:nil];
    return self;
}

- (BOOL)parseText:(NSMutableAttributedString *)text selectedRange:(NSRangePointer)range {
    __block BOOL changed = NO;
    [_regex enumerateMatchesInString:text.string options:NSMatchingWithoutAnchoringBounds range:text.yy_rangeOfAll usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        if (!result) return;
        NSRange range = result.range;
        if (range.location == NSNotFound || range.length < 1) return;
        if ([text attribute:YYTextBindingAttributeName atIndex:range.location effectiveRange:NULL]) return;
        
        NSRange bindlingRange = NSMakeRange(range.location, range.length - 1);
        YYTextBinding *binding = [YYTextBinding bindingWithDeleteConfirm:YES];
        [text yy_setTextBinding:binding range:bindlingRange]; /// Text binding
        [text yy_setColor:[UIColor colorWithRed:0.000 green:0.519 blue:1.000 alpha:1.000] range:bindlingRange];
        changed = YES;
    }];
    return changed;
}

@end
