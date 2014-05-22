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

- (void)chooseCardAtIndex:(NSUInteger)index andMatchCount:(NSUInteger)count{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    NSInteger matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
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
