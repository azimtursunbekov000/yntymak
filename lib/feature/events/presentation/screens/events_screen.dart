import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../internal/theme/text_helper.dart';
import '../../data/models/events_model.dart';
import '../../data/repositories/events_repository_impl.dart';
import '../../domain/use_case/events_use_case.dart';
import '../logic/events_bloc.dart';

class EventsScreen extends StatelessWidget {
  final EventsModel? newsModel;

  const EventsScreen({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsBloc(
        EventsUseCase(
          newsRepository: EventsRepositoryImpl(),
        ),
      )..add(
          GetNewsEvent(newsModel: newsModel),
        ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Ынтымак',
              style: TextHelper.poppins16w400,
            ),
          ),
        ),
        body: BlocConsumer<EventsBloc, NewsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsLoadedState) {
              final newsModel = state.newsModel;
              if (newsModel.results == null || newsModel.results!.isEmpty) {
                return const Center(
                  child: Text('Нет новостей'),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<EventsBloc>().add(
                        GetNewsEvent(newsModel: newsModel),
                      );
                },
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  shrinkWrap: true,
                  itemCount: newsModel.results!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        final eventId = newsModel.results![index].id;
                        context.go('/event_detail/$eventId');
                      },
                      child: Card(
                        color: Theme.of(context).drawerTheme.scrimColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      newsModel.results?[index].image ?? '',
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsModel.results![index].title ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        newsModel.results![index].description ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                ),
              );
            } else if (state is NewsErrorState) {
              return const Center(child: Text('Что-то пошло не так'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
