//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Sam McDavid on 5/18/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableAttributedString *turnDescription;
@property (strong, nonatomic, readwrite) NSMutableArray *turnDescriptions;
@property (strong, nonatomic) NSMutableArray *matchStack;
@property (nonatomic) NSInteger currentScore;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnDescriptionLabel;

@end

@implementation CardGameViewController

// Generated Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Property Methods
- (CardMatchingGame *)game {
    if (!_game) _game = [self newGame];
    return _game;
}

@synthesize turnDescription = _turnDescription;

- (NSMutableAttributedString *)turnDescription {
    if (!_turnDescription) {
        _turnDescription = [[NSMutableAttributedString alloc] initWithString:@"Ready to Play!"];
    }
    return _turnDescription;
}

- (void)setTurnDescription:(NSMutableAttributedString *)turnDescription {
    _turnDescription = turnDescription;
}

- (NSMutableArray *)turnDescriptions {
    if (!_turnDescriptions) {
        _turnDescriptions = [[NSMutableArray alloc] initWithObjects:self.turnDescription, nil];
    }
    return _turnDescriptions;
}

- (NSMutableArray *)matchStack {
    if (!_matchStack) {
        _matchStack = [[NSMutableArray alloc] init];
    }
    return _matchStack;
}

- (NSDictionary *)attributesDictionary {
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
             
             NSForegroundColorAttributeName: [UIColor blackColor]};
}

// Instance Methods
- (Deck *)createDeck {
    return nil;
}

- (NSMutableAttributedString *)attributedContentsOfCard:(Card *)card {
    return nil;
}

- (CardMatchingGame *)newGame {
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.currentScore = self.game.score;
    self.game.numberOfCardsToMatch = self.numberOfCardsToMatch;
    NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.matchStack addObject:[self.game cardAtIndex:chooseButtonIndex]];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateTurnDescriptions];
    [self updateUI];
}

// Private Methods
- (void)updateTurnDescriptions {
    self.turnDescription = [[NSMutableAttributedString alloc]
                            initWithAttributedString:[self attributedContentsOfCard:[self.matchStack lastObject]]];
    [self.turnDescription appendAttributedString:[[NSAttributedString alloc] initWithString:@" was flipped."]];
    [self.turnDescriptions addObject:self.turnDescription];
    [self updateTurnDescriptionAttributes];
    
    if ([self.matchStack count] == self.numberOfCardsToMatch) {
        if ([[self.matchStack lastObject] isKindOfClass:[Card class]]) {
            Card *latestChosenCard = (Card *)[self.matchStack lastObject];
            if (!latestChosenCard.isChosen) {
                [self.matchStack removeObjectIdenticalTo:latestChosenCard];
            } else {
                self.turnDescription = [[NSMutableAttributedString alloc] initWithString:@""];
                if (latestChosenCard.isMatched) {
                    for (Card *matchedCard in self.matchStack) {
                        [self.turnDescription appendAttributedString:[self attributedContentsOfCard:matchedCard]];
                        [self.turnDescription appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
                    }
                    NSString *matchString =
                        [NSString stringWithFormat:@" matched for %ld points.", self.game.score - self.currentScore];
                    [self.turnDescription appendAttributedString:[[NSAttributedString alloc] initWithString:matchString]];
                    [self.matchStack removeAllObjects];
                } else {
                    for (Card *unMatchedCard in self.matchStack) {
                        [self.turnDescription appendAttributedString:[self attributedContentsOfCard:unMatchedCard]];
                        [self.turnDescription appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
                    }
                    NSString *unMatchString =
                        [NSString stringWithFormat:@" did not match for %ld points.", self.currentScore - self.game.score];
                    [self.turnDescription appendAttributedString:[[NSAttributedString alloc] initWithString:unMatchString]];
                    [self.matchStack removeAllObjects];
                    [self.matchStack addObject:latestChosenCard];
                }
            }
            [self.turnDescriptions addObject:self.turnDescription];
            [self updateTurnDescriptionAttributes];
            }
    }
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.turnDescriptionLabel.attributedText = [self.turnDescriptions lastObject];
}

- (NSAttributedString *)titleForCard:(Card *)card {
    return card.isChosen ? [self attributedContentsOfCard:card] : [[NSAttributedString alloc] initWithString:@""];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)dealCards {
    self.game = [self newGame];
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@""] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"]
                              forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    self.turnDescription = nil;
    self.turnDescriptions = nil;
    self.scoreLabel.text = @"Score: 0";
    self.turnDescriptionLabel.attributedText = self.turnDescription;
    self.turnDescriptionLabel.enabled = YES;
}

- (void)updateTurnDescriptionAttributes {
    NSRange range = NSMakeRange(0, [self.turnDescription length]);
    [self.turnDescription setAttributes:self.attributesDictionary range:range];
}

@end
