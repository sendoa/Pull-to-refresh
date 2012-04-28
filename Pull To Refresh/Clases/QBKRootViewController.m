//
//  QBKRootViewController.m
//  Pull To Refresh
//
//  Created by Sendoa Portuondo on 27/04/12.
//  Copyright (c) 2012 Qbikode Solutions, S.L. All rights reserved.
//

#import "QBKRootViewController.h"
#import "QBKDatosStore.h"

@interface QBKRootViewController ()

@end

@implementation QBKRootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configuramos el EGORefreshTableHeaderView
    if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
	}
    
    // Indicamos el momento de la última actualización del data source
	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _datos = nil;
    _refreshHeaderView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _datos = [[QBKDatosStore sharedInstance] todosLosDatos];
    return [_datos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [[cell textLabel] setText:[_datos objectAtIndex:[indexPath row]]];
    
    return cell;
}

#pragma mark  - Métodos de UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - Métodos de EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{	
	[self recargarDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{	
	return _reloading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // fecha de última actualización
}

#pragma mark - Métodos de recarga del modelo de datos

- (void) recargarDataSource
{
    // Actualizamos el flag para indicar que EGORefreshTableHeaderView está recargando
    _reloading = YES;
    
    // Solicitamos al modelo que actualice sus datos
    // (...)
    
    // Metemos un delay para simular que la carga de datos tarda un segundo
    [self performSelector:@selector(terminaRecargaDataSource) withObject:nil afterDelay:1];
}

- (void) terminaRecargaDataSource
{
    // Actualizamos el flag para indicar que EGORefreshTableHeaderView ha terminado de recargar
    _reloading = NO;
    
    // Indicamos a _refreshHeaderView que el proceso de recarga ha terminado para que desaparezca de la vista
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    // Recargamos la tabla
    [[self tableView] reloadData];
}

@end
