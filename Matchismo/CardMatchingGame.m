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
@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation CardMatchingGame

// Constants
static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

// Property Methods
- (NSMutableArray *)cards {
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

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen &&
                    !otherCard.isMatched &&
                    [chosenCards count] != (self.numberOfCardsToMatch -1)) {
                    [chosenCards addObject:otherCard];
                }
                if ([chosenCards count] == (self.numberOfCardsToMatch - 1)) {
                    NSInteger matchScore = [card match:chosenCards] * MATCH_BONUS * self.numberOfCardsToMatch;
                    if (matchScore) {
                        self.score += matchScore;
                        for (Card *matchedCard in chosenCards) {
                            matchedCard.matched = YES;
                        }
                        card.matched = YES;
                    } else {
                        NSInteger penalty = MISMATCH_PENALTY * (self.numberOfCardsToMatch - 1);
                        self.score -= penalty;
                        for (Card *unmatchedCard in chosenCards) {
                            unmatchedCard.chosen = NO;
                        }
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index <[self.cards count]) ? self.cards[index] : nil;
}

@end
