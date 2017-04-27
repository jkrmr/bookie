//
//  LookUpReservationViewController.m
//  CoreDataHotel
//
//  Created by Jake Romer on 4/26/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

#import "LookUpReservationViewController.h"

@interface LookUpReservationViewController ()
@property(strong, nonatomic) NSArray *reservations;
@property(strong, nonatomic) UITableView *tableView;
@end

@implementation LookUpReservationViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor whiteColor]];
  [self setTableView:[[UITableView alloc] init]];
  [self.tableView setDelegate:self];
  [self.tableView setDataSource:self];
  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:@"cell"];
  [self.view addSubview:self.tableView];
  NSLayoutConstraint *tvT = [[self.tableView topAnchor]
      constraintEqualToAnchor:[self.topLayoutGuide bottomAnchor]];
  NSLayoutConstraint *tvB = [[self.tableView bottomAnchor]
      constraintEqualToAnchor:[self.bottomLayoutGuide topAnchor]];
  NSLayoutConstraint *tvL = [[self.tableView leadingAnchor]
      constraintEqualToAnchor:[self.view leadingAnchor]];
  NSLayoutConstraint *tvR = [[self.tableView trailingAnchor]
      constraintEqualToAnchor:[self.view trailingAnchor]];
  [NSLayoutConstraint activateConstraints:@[ tvT, tvB, tvL, tvR ]];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.reservations = [self fetchAllReservations];
}

- (NSArray *)fetchAllReservations {
  AppDelegate *appDelegate =
      (AppDelegate *)[[UIApplication sharedApplication] delegate];
  NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
  NSError *error;
  NSFetchRequest *request = [ReservationQuery allReservations];
  NSArray *allReservations = [context executeFetchRequest:request error:&error];
  if (error) {
    NSLog(@"Error fetching all reservations: %@", error.localizedDescription);
  }
  return allReservations;
}

// MARK: TableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return self.reservations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell =
      [self.tableView dequeueReusableCellWithIdentifier:@"cell"
                                           forIndexPath:indexPath];
  Reservation *selectedReservation = self.reservations[indexPath.row];
  cell.textLabel.text = selectedReservation.description;
  return cell;
}

// MARK: TableViewDelegate methods
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"selected a row");
}
@end