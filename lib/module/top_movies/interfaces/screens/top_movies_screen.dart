import 'package:flirt/module/top_movies/service/cubit/movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopMoviesScreen extends StatefulWidget {
  const TopMoviesScreen({Key? key}) : super(key: key);

  static const String routeName = '/top-movies';

  @override
  _TopMoviesScreenState createState() => _TopMoviesScreenState();
}

class _TopMoviesScreenState extends State<TopMoviesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MoviesCubit>().fetchTopMovies();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top 250 Movies'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber[600],
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (BuildContext context, MoviesState state) {
            if (state is FetchTopMoviesSuccess) {
              return ListView.builder(
                itemExtent: MediaQuery.of(context).size.height*.19,
                itemCount: state.movies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.grey[900],
                    child: Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height*.025,
                          left: MediaQuery.of(context).size.width*.035,
                        ),
                        visualDensity: VisualDensity(vertical: MediaQuery.of(context).size.height/(state.movies.length*.9)),
                        isThreeLine: true,
                        dense: false,
                        leading: SizedBox(
                          width: MediaQuery.of(context).size.width*.15,
                          child: Image.network(
                            state.movies[index].image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        title: Text(
                          '${state.movies[index].rank}. ${state.movies[index].fullTitle}',
                          style: _theme.textTheme.bodyText1
                              ?.copyWith(
                                color: Colors.white, 
                                fontWeight: FontWeight.w900
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.003),
                          child: Column(
                            children: <Widget>[
                              Text(
                                state.movies[index].crew,
                                style: _theme.textTheme.bodyText2
                                    ?.copyWith(color: Colors.grey[500]),
                              ),
                              Row(children: <Widget>[
                                Icon(Icons.star_half_rounded,color: Colors.yellow[800],),
                                Text(state.movies[index].imDbRating,
                                  style: _theme.textTheme.bodyText2
                                    ?.copyWith(color: Colors.white),
                                ),
                              ],)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                  
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow[800],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
