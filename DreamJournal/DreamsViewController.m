//
//  DreamsViewController.m
//  DreamJournal
//
//  Created by Divya Reddy on 15/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import "DreamsViewController.h"
#import "DreamsCell.h"
#import "Dreams.h"
#import "Reachability.h"
#import "SDCoreDataController.h"
#import "SDSyncEngine.h"

@interface DreamsViewController ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end


@implementation DreamsViewController
@synthesize dateFormatter;
@synthesize managedObjectContext;

@synthesize entityName;

@synthesize dreams;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadRecordsFromCoreData {
    [self.managedObjectContext performBlockAndWait:^{
        [self.managedObjectContext reset];
        NSError *error = nil;
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Dreams"];
        [request setSortDescriptors:[NSArray arrayWithObject:
                                     [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        self.dreams = [self.managedObjectContext executeFetchRequest:request error:&error];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back3.jpg"]];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    refreshControl.tintColor = [UIColor blackColor];
     refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating New Entries"];
    [refreshControl addTarget:self action:@selector(changeSorting) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    self.refreshControl.layer.zPosition = self.tableView.backgroundView.layer.zPosition + 1;
    self.tableView.backgroundView.layer.zPosition -= 1;
    self.tableView.backgroundView = imageView;


    
    
    self.managedObjectContext = [[SDCoreDataController sharedInstance] newManagedObjectContext];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [self loadRecordsFromCoreData];
    
      self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
   // [self checkSyncStatus];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"SDSyncEngineSyncCompleted" object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self loadRecordsFromCoreData];
        [self.tableView reloadData];
    }];
    [[SDSyncEngine sharedEngine] addObserver:self forKeyPath:@"syncInProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SDSyncEngineSyncCompleted" object:nil];
    [[SDSyncEngine sharedEngine] removeObserver:self forKeyPath:@"syncInProgress"];
}

- (void)viewDidUnload {
   /// [self setRefreshButton:nil];
    [super viewDidUnload];
}

- (void)changeSorting {
    
    Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
    
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
    if (netStatus!=ReachableViaWiFi)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No network Connection" message:@"There is no network connection available.Please try again later" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alertView show];
    }
    else
    {
    [[SDSyncEngine sharedEngine] startSync];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    }
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *date = [self.dreams objectAtIndex:indexPath.row];
        [self.managedObjectContext performBlockAndWait:^{
            [self.managedObjectContext deleteObject:date];
            NSError *error = nil;
            BOOL saved = [self.managedObjectContext save:&error];
            if (!saved) {
                NSLog(@"Error saving main context: %@", error);
            }
            [[SDCoreDataController sharedInstance] saveMasterContext];
            [self loadRecordsFromCoreData];
            [self.tableView reloadData];
        }];
        
      
    
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.dreams count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"DreamCell";
    DreamsCell *cell;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero] ;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[DreamsCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                reuseIdentifier:CellIdentifier];
    }
    //
    
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    
    // Configure the cell...
    
    Dreams *dreammodel = [self.dreams objectAtIndex:indexPath.row];
    
    cell.dreamName.text = dreammodel.name;
    
    
    cell.dreamDesc.text = dreammodel.dreamdescription;
    
    cell.emotion.text = dreammodel.emotion;
    
    cell.mood.text = dreammodel.mood;
    
    cell.clarity.text = dreammodel.clarity;
    
    cell.dreamDate.text = dreammodel.date;
    
    return cell;
}

- (void)checkSyncStatus {
    if ([[SDSyncEngine sharedEngine] syncInProgress]) {
        
       // [self replaceRefreshButtonWithActivityIndicator];
    } else {
        [self.refreshControl endRefreshing];
       // [self removeActivityIndicatorFromRefreshButon];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"syncInProgress"]) {
        
        [self checkSyncStatus];
    }
}



@end
