//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Sam McDavid on 5/25/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "SetCardDeck.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        for (int i = 0; i < [SetCard maxRank]; i++) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (NSString *shade in [SetCard validShades]) {
                    for (NSString *color in [SetCard validColors]) {
                        SetCard *newSetCard = [[SetCard alloc] init];
                        newSetCard.rank = i;
                        newSetCard.symbol = symbol;
                        newSetCard.shadeString = shade;
                        newSetCard.colorString = color;
                        [self addCard:newSetCard];
                    }
                }
            }
        }
    }
    return self;
}

- (NSUInteger)numberOfCardsToMatch {
    return 3;
}

@end
