//
//  FavViewController.m
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "FavViewController.h"
#import "DetailViewController.h"

@interface FavViewController ()

@end

@implementation FavViewController

@synthesize film, oneFilm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    NSLog(@"init");
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateLeftTable"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkRes:) name:@"updateLeftTable" object:nil];
}

-(void)checkRes:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"updateLeftTable"])
    {
        NSLog(@"checkRes");
        film = [[DBClient sharedInstance] selectFilmFavorite:YES];
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [film count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"FilmCell";
    FilmCell *cell;
    oneFilm = [film objectAtIndex:indexPath.row];
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    NSLog(@"init5");
    
    if ([oneFilm.favorite isEqual:[NSNumber numberWithBool:YES]])
    {
        UIImage *favOnImage = [UIImage imageNamed:@"43-film-roll"];
        [cell.favButton setBackgroundImage:favOnImage forState:UIControlStateNormal];
        NSLog(@"%lu", (long)indexPath.row);
    }else
    {
        UIImage *favOnImage = [UIImage imageNamed:@"28-star"];
        [cell.favButton setBackgroundImage:favOnImage forState:UIControlStateNormal];
    }
    
    cell.film = oneFilm;
    cell.FilmTitle.text = oneFilm.titile;
    cell.FilmYear.text = oneFilm.year;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    oneFilm = [film objectAtIndex:indexPath.row];
    
}


- (void) refreshData
{
    film = [[DBClient sharedInstance] selectFilmFavorite:YES];
    [self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self refreshData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"mainToDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [segue.destinationViewController setFilmDetail:[film objectAtIndex:indexPath.row]];
        
    }
}

@end
