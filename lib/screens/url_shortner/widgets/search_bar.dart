import 'package:code_test/bloc/create_alias_cubit.dart';
import 'package:code_test/bloc/recent_urls_cubit.dart';
import 'package:code_test/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SearchBarKeys {
  static const Key activeSendButton = Key('activeSearchButton');
  static const Key processingUrlView = Key('loadingSearchView');
  static const Key urlTextField = Key('searchTextField');
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      key: SearchBarKeys.urlTextField,
                      controller: controller,
                      keyboardType: TextInputType.url,
                      onEditingComplete: _processUrl,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Enter a url',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller,
                    builder: (_, value, __) => Visibility(
                      visible: value.text.isNotEmpty,
                      child: IconButton(
                        onPressed: () {
                          controller.clear();
                          setState(() {});
                        },
                        icon: Image.asset(
                          'assets/cancel.png',
                          height: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          _searchButtonLayout(),
        ],
      ),
    );
  }

  Widget _searchButtonLayout() {
    return SizedBox(
      height: 35,
      width: 35,
      child: BlocConsumer<CreateAliasCubit, CreateAliasState>(
        listener: (context, state) {
          if (state.error != null) {
            _showError(state.error.toString());
          } else if (state.shortenedUrl != null) {
            BlocProvider.of<RecentUrlsCubit>(context)
                .addNewShortenedUrl(state.shortenedUrl!);
          }
        },
        builder: (context, state) {
          return state.loading == true
              ? const Center(
                  child: SizedBox(
                    key: SearchBarKeys.processingUrlView,
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: _processUrl,
                  child: CircleAvatar(
                    key: SearchBarKeys.activeSendButton,
                    radius: 20,
                    backgroundColor: AppColors.primary,
                    child: Image.asset(
                      'assets/send.png',
                      height: 17,
                      color: Colors.white,
                    ),
                  ),
                );
        },
      ),
    );
  }

  void _processUrl() {
    FocusScope.of(context).unfocus();
    String url = controller.text;
    if (url.isEmpty || Uri.parse(url).host.isEmpty) {
      _showError('Enter a valid url');
      return;
    }

    BlocProvider.of<CreateAliasCubit>(context).processUrl(controller.text);
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }
}
