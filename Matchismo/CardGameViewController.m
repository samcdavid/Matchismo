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
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *difficulty;
@property (weak, nonatomic) IBOutlet UILabel *turnDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *turnDescriptionSlider;

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

// Instance Methods
- (Deck *)createDeck {
    return nil;
}

- (CardMatchingGame *)newGame {
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if (self.difficulty.enabled) {
        self.difficulty.enabled = NO;
    }
    
    self.game.numberOfCardsToMatch =
    [[[self.difficulty titleForSegmentAtIndex:self.difficulty.selectedSegmentIndex] substringToIndex:1] integerValue];
    NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
}

- (IBAction)moveTurnDescriptionSlider:(UISlider *)sender {
    self.turnDescriptionLabel.enabled = NO;
    self.turnDescriptionLabel.text = [self.game getTurnDescriptionStringAtIndex:self.turnDescriptionSlider.value];
}

// Private Methods
- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.turnDescriptionLabel.enabled = YES;
    self.turnDescriptionLabel.text = [self.game getLastTurnDescriptionString];
    self.turnDescriptionSlider.minimumValue = 0.0;
    self.turnDescriptionSlider.maximumValue = [self.game getTurnDescriptionCount];
    self.turnDescriptionSlider.value = self.turnDescriptionSlider.maximumValue;
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)dealCards {
    self.game = [self newGame];
    self.difficulty.enabled = YES;
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"]
                              forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    self.scoreLabel.text = @"Score: 0";
    self.turnDescriptionLabel.text = @"Ready to Play!";
    self.turnDescriptionLabel.enabled = YES;
}

@end
