import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/presentation/pages/pokemon_detail_page.dart';
import 'package:pokedex_app/presentation/state/pokemon_list_controller.dart';
import 'package:pokedex_app/presentation/state/pokemon_list_filters_providers.dart';
import 'package:pokedex_app/presentation/theme/page_transitions.dart';
import 'package:pokedex_app/presentation/widgets/pokemon_card.dart';
import 'package:pokedex_app/presentation/widgets/retry_error.dart';
import 'package:pokedex_app/presentation/widgets/shimmer_loading.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        ref.read(pokemonListControllerProvider.notifier).loadInitial();
      } else {}
    });
    _scrollController.addListener(() {
      final max = _scrollController.position.maxScrollExtent;
      final offset = _scrollController.offset;
      if (offset > max - 400) {
        ref.read(pokemonListControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pokemonListControllerProvider);
    final sort = ref.watch(sortModeProvider);
    final query = ref.watch(searchQueryProvider);

    final filtered = state.items.where((e) {
      final searchTerm = query.trim().toLowerCase();
      final pokemonName = e.name.toLowerCase();
      final pokemonId = e.id.toString();
      final pokemonIdPadded = e.id.toString().padLeft(3, '0');
      final pokemonIdWithHash = '#${e.id.toString().padLeft(3, '0')}';

      if (pokemonName.contains(searchTerm)) return true;

      if (pokemonId.contains(searchTerm)) return true;
      if (pokemonIdPadded.contains(searchTerm)) return true;
      if (pokemonIdWithHash.contains(searchTerm)) return true;

      return false;
    }).toList();
    if (sort == SortMode.name) {
      filtered.sort((a, b) => a.name.compareTo(b.name));
    } else {
      filtered.sort((a, b) => a.id.compareTo(b.id));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFca2d3f),
        title: Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.catching_pokemon, color: Colors.white, size: 28),
              const SizedBox(width: 8),
              const Text(
                'Pokédex',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) =>
                          ref.read(searchQueryProvider.notifier).state = v
                              .toLowerCase(),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        isDense: true,
                        filled: true,
                        hintText: 'Search',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFca2d3f),
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Color(0xFFca2d3f),
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  ref.read(searchQueryProvider.notifier).state =
                                      '';
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: PopupMenuButton<SortMode>(
                    initialValue: sort,
                    onSelected: (v) =>
                        ref.read(sortModeProvider.notifier).state = v,
                    itemBuilder: (context) => [
                      PopupMenuItem<SortMode>(
                        enabled: false,
                        child: Align(
                          alignment: Alignment.center,
                          child: const Text(
                            'Sort by:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      PopupMenuItem<SortMode>(
                        enabled: false,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Radio<SortMode>(
                                    value: SortMode.number,
                                    groupValue: sort,
                                    onChanged: (value) {
                                      ref
                                              .read(sortModeProvider.notifier)
                                              .state =
                                          value!;
                                      Navigator.of(context).pop();
                                    },
                                    activeColor: const Color(0xFFca2d3f),
                                    focusColor: const Color(0xFFca2d3f),
                                  ),
                                  const Text('Number'),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Radio<SortMode>(
                                    value: SortMode.name,
                                    groupValue: sort,
                                    onChanged: (value) {
                                      ref
                                              .read(sortModeProvider.notifier)
                                              .state =
                                          value!;
                                      Navigator.of(context).pop();
                                    },
                                    activeColor: const Color(0xFFca2d3f),
                                    focusColor: const Color(0xFFca2d3f),
                                  ),
                                  const Text('Name'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    constraints: const BoxConstraints(
                      minWidth: 0,
                      maxWidth: double.infinity,
                    ),
                    color: const Color(0xFFca2d3f),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    icon: Icon(
                      sort == SortMode.number
                          ? Icons.numbers
                          : Icons.text_format,
                      color: Color(0xFFca2d3f),
                    ),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (state.error != null && state.items.isEmpty) {
            return RetryError(
              message: state.error!,
              onRetry: () => ref
                  .read(pokemonListControllerProvider.notifier)
                  .loadInitial(),
            );
          }
          if (state.items.isEmpty && state.loading) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: 9,
              itemBuilder: (context, index) => const ShimmerCard(),
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(pokemonListControllerProvider.notifier).loadInitial(),
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length + 1,
              itemBuilder: (context, index) {
                if (index < filtered.length) {
                  final item = filtered[index];
                  return PokemonCard(
                    item: item,
                    index: index,
                    onTap: () {
                      Navigator.of(context).push(
                        PokemonPageTransitions.slideFromBottomWithFade(
                          child: PokemonDetailPage(nameOrId: item.name),
                        ),
                      );
                    },
                  );
                }
                if (state.loading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ShimmerCard(height: 80, width: 80),
                    ),
                  );
                }
                if (!state.hasMore) {
                  return const Center(child: Text('No more results'));
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
