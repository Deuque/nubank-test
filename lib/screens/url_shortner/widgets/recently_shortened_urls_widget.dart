import 'package:code_test/bloc/recent_urls_cubit.dart';
import 'package:code_test/repository/data/shortened_url_model.dart';
import 'package:code_test/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RecentlyShortenedUrlsWidgetKeys {
  static const Key emptyDataLayout = Key('emptyDataLayout');
  static const Key loadedUrlLayout = Key('loadedUrlLayout');
}

class RecentlyShortenedUrlsWidget extends StatelessWidget {
  const RecentlyShortenedUrlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Recent urls',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<RecentUrlsCubit, List<ShortenedUrl>>(
              builder: (_, state) {
                return state.isEmpty
                    ? _emptyDataLayout()
                    : _loadedUrlsLayout(context, state);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _emptyDataLayout() => Column(
        key: RecentlyShortenedUrlsWidgetKeys.emptyDataLayout,
        children: [
          const Spacer(
            flex: 2,
          ),
          CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.primary.withOpacity(.15),
            child: const Text(
              '🖇️',
              style: TextStyle(fontSize: 50),
            ),
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      );

  Widget _loadedUrlsLayout(
    BuildContext context,
    List<ShortenedUrl> shortenedUrls,
  ) =>
      ListView.separated(
        key: RecentlyShortenedUrlsWidgetKeys.loadedUrlLayout,
        itemBuilder: (_, i) => _urlItem(context, shortenedUrls[i]),
        separatorBuilder: (_, __) => Divider(
          height: 1,
          color: Colors.grey[400],
        ),
        itemCount: shortenedUrls.length,
      );

  Widget _urlItem(BuildContext context, ShortenedUrl shortenedUrl) {
    return Dismissible(
      key: ValueKey(shortenedUrl.alias),
      onDismissed: (_) {
        BlocProvider.of<RecentUrlsCubit>(context)
            .removeShortenedUrl(shortenedUrl.alias);
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        title: Text(shortenedUrl.alias),
        subtitle: Text(shortenedUrl.short),
      ),
    );
  }
}
