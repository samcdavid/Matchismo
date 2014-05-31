//
//  SetCard.m
//  Matchismo
//
//  Created by Sam McDavid on 5/31/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

// Property Methods

- (NSString *)symbol {
    if (!_symbol) _symbol = @"?";
    return _symbol;
}

- (NSString *)shading {
    if (!_shading) _shading = @"?";
    return _shading;
}

- (NSString *)color {
    if (!_color) _color = @"?";
    return _color;
}

// Instance Methods

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 2) {
        SetCard *firstCardToMatch = nil;
        SetCard *secondCardToMatch = nil;
        if ([[otherCards firstObject] isMemberOfClass:[SetCard class]] &&
            [[otherCards lastObject] isMemberOfClass:[SetCard class]]) {
            firstCardToMatch = [otherCards firstObject];
            secondCardToMatch = [otherCards lastObject];
            BOOL numberMatch = [SetCard matchPropertyOfFirstSetCardString:[NSString stringWithFormat:@"%ld", self.number]
                                                      andSecondCardString:[NSString stringWithFormat:@"%ld", firstCardToMatch.number]
                                                       andThirdCardString:[NSString stringWithFormat:@"%ld", secondCardToMatch.number]];
            BOOL symbolMatch = [SetCard matchPropertyOfFirstSetCardString:self.symbol
                                                      andSecondCardString:firstCardToMatch.symbol
                                                       andThirdCardString:secondCardToMatch.symbol];
            BOOL shadingMatch = [SetCard matchPropertyOfFirstSetCardString:self.shading
                                                       andSecondCardString:firstCardToMatch.shading
                                                        andThirdCardString:secondCardToMatch.shading];
            BOOL colorMatch = [SetCard matchPropertyOfFirstSetCardString:self.color
                                                     andSecondCardString:firstCardToMatch.color
                                                      andThirdCardString:secondCardToMatch.color];
            if (numberMatch && symbolMatch && shadingMatch && colorMatch) {
                score += 10;
            }
        }
    }
    
    return score;
}

// Private Methods

+ (BOOL)matchPropertyOfFirstSetCardString: (NSString *)firstCard
                    andSecondCardString: (NSString *)secondCard
                     andThirdCardString: (NSString *)thirdCard {
    BOOL match = NO;
    
    if ([firstCard isEqualToString:secondCard] && [firstCard isEqualToString:thirdCard]) {
        match = YES;
    } else if (![firstCard isEqualToString:secondCard] &&
               ![firstCard isEqualToString:thirdCard] &&
               ![secondCard isEqualToString:thirdCard]) {
        match = YES;
    }
    
    return match;
}

@end
