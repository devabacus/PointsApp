import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointsapp/features/todos/home/cubit/home_cubit.dart';
import 'package:pointsapp/features/todos/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => HomeCubit(), child: HomeView());
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: selectedTab.index,
          children: [Text("TodosOverviewPage()"), Text("StatsPage()")],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:
            () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("New Task screen"))),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () => context.read<HomeCubit>().setTab(HomeTab.todos),
              icon: Icon(Icons.list_rounded),
            ),
            IconButton(
              onPressed: () => context.read<HomeCubit>().setTab(HomeTab.stats),
              icon: Icon(Icons.show_chart_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
