//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Sam McDavid on 5/20/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

/**
 *  Redeclare score so that it may be editable within the implementation of CardMatchingGame.
 */
@property (nonatomic, readwrite) NSInteger score;

/**
 *  Cards in use in the game.
 */
@property (nonatomic) NSMutableArray *cards;

@end

@implementation CardMatchingGame

// Property Methods
- (NSMutableArray *)_cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

// Public Methods
- (instancetype)init {
    return nil;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}


@end
