import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/events_model.dart';
import '../../data/repositories/events_repository_impl.dart';

class EventsDetailPage extends StatefulWidget {
  final String? eventId;

  const EventsDetailPage({super.key, required this.eventId});

  @override
  State<EventsDetailPage> createState() => _EventsDetailPageState();
}

class _EventsDetailPageState extends State<EventsDetailPage> {
  EventsRepositoryImpl eventsRepository = EventsRepositoryImpl();
  Result? eventDetail;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadEventDetail();
  }

  Future<void> _loadEventDetail() async {
    try {
      final result = await eventsRepository.getEventById(widget.eventId);
      setState(() {
        eventDetail = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Что-то пошло не так';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : eventDetail != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              eventDetail!.image ?? '',
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.scaleDown,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Text(
                                  'Автор:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  eventDetail!.author ?? 'Ынтымак админ',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            const SizedBox(height: 15),
                            Text(
                              eventDetail!.title ?? 'Без названия',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              eventDetail!.description ??
                                  'Описание отсутствует',
                            ),
                            Text(
                              eventDetail!.shortDescription ??
                                  'Описание отсутствует',
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Text(
                                  'Создано:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  eventDetail!.createdAt.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Center(child: Text('Мероприятие не найдено')),
    );
  }
}
