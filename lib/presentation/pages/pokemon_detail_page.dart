import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/presentation/state/pokemon_detail_provider.dart';
import 'package:pokedex_app/presentation/theme/pokemon_type_colors.dart';

String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

/// Detailed view page for a specific Pokémon with animated content
class PokemonDetailPage extends ConsumerStatefulWidget {
  final String nameOrId;
  const PokemonDetailPage({super.key, required this.nameOrId});

  @override
  ConsumerState<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends ConsumerState<PokemonDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late AnimationController _statsAnimationController;
  late AnimationController _abilitiesAnimationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _mainAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _statsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _abilitiesAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainAnimationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _mainAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    // Start animations sequentially
    _mainAnimationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _abilitiesAnimationController.forward();
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        _statsAnimationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _mainAnimationController.dispose();
    _statsAnimationController.dispose();
    _abilitiesAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(pokemonDetailProvider(widget.nameOrId));
    return async.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text(e.toString()))),
      data: (d) {
        final primary = typeColor(d.types.first);
        final onPrimary = Colors.white;
        return Scaffold(
          backgroundColor: primary,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: onPrimary,
            title: AnimatedBuilder(
              animation: _mainAnimationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - _fadeAnimation.value) * 20),
                  child: Opacity(
                    opacity: _fadeAnimation.value.clamp(0.0, 1.0),
                    child: Text(
                      _cap(d.name),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                );
              },
            ),
            actions: [
              AnimatedBuilder(
                animation: _mainAnimationController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, (1 - _fadeAnimation.value) * 20),
                    child: Opacity(
                      opacity: _fadeAnimation.value.clamp(0.0, 1.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          '#${d.id.toString().padLeft(3, '0')}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              // Background Pokéball watermark
              Positioned(
                top: 24,
                right: -20,
                child: AnimatedBuilder(
                  animation: _mainAnimationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value.clamp(0.0, 1.0),
                      child: Opacity(
                        opacity: _fadeAnimation.value.clamp(0.0, 1.0),
                        child: Icon(
                          Icons.catching_pokemon,
                          size: 220,
                          color: onPrimary.withValues(alpha: 0.08),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Hero image with animation
              Positioned(
                top: 24,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: _mainAnimationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        _slideAnimation.value.dx.clamp(-1.0, 1.0),
                        _slideAnimation.value.dy.clamp(-1.0, 1.0),
                      ),
                      child: Opacity(
                        opacity: _fadeAnimation.value.clamp(0.0, 1.0),
                        child: Center(
                          child: Hero(
                            tag: 'pk-${d.id}',
                            child: Image.network(
                              d.imageUrl,
                              height: 180,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const SizedBox(
                                height: 180,
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Type chips below image
              Positioned(
                top: 220,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: _mainAnimationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        _slideAnimation.value.dx.clamp(-1.0, 1.0),
                        _slideAnimation.value.dy.clamp(-1.0, 1.0),
                      ),
                      child: Opacity(
                        opacity: _fadeAnimation.value.clamp(0.0, 1.0),
                        child: Center(
                          child: Wrap(
                            spacing: 8,
                            children: d.types
                                .map(
                                  (t) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.25,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white24),
                                    ),
                                    child: Text(
                                      _cap(t),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Main content sheet
              Positioned.fill(
                top: 280,
                child: AnimatedBuilder(
                  animation: _mainAnimationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        (1 - _fadeAnimation.value.clamp(0.0, 1.0)) * 50,
                      ),
                      child: Opacity(
                        opacity: _fadeAnimation.value.clamp(0.0, 1.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(16, 120, 16, 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: Text(
                                    'About',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: primary,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _AboutTile(
                                      icon: Icons.scale,
                                      label: 'Weight',
                                      value: '${d.weight} kg',
                                    ),
                                    _AboutTile(
                                      icon: Icons.height,
                                      label: 'Height',
                                      value: '${d.height} m',
                                    ),
                                    _AboutTile(
                                      icon: Icons.bolt,
                                      label: 'Moves',
                                      value: d.abilities.isNotEmpty
                                          ? _cap(d.abilities.first)
                                          : '-',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Abilities section
                                Center(
                                  child: Text(
                                    'Abilities',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: primary,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Animated abilities with staggered entrance
                                AnimatedBuilder(
                                  animation: _abilitiesAnimationController,
                                  builder: (context, child) {
                                    return Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: d.abilities.asMap().entries.map((
                                        entry,
                                      ) {
                                        final index = entry.key;
                                        final ability = entry.value;
                                        final delay = index * 100;
                                        final animation =
                                            Tween<double>(
                                              begin: 0.0,
                                              end: 1.0,
                                            ).animate(
                                              CurvedAnimation(
                                                parent:
                                                    _abilitiesAnimationController,
                                                curve: Interval(
                                                  delay /
                                                      _abilitiesAnimationController
                                                          .duration!
                                                          .inMilliseconds,
                                                  1.0,
                                                  curve: Curves.elasticOut,
                                                ),
                                              ),
                                            );

                                        return Transform.scale(
                                          scale: animation.value.clamp(
                                            0.0,
                                            1.0,
                                          ),
                                          child: Opacity(
                                            opacity: animation.value.clamp(
                                              0.0,
                                              1.0,
                                            ),
                                            child: Chip(
                                              label: Text(_cap(ability)),
                                              backgroundColor: primary
                                                  .withValues(alpha: 0.1),
                                              side: BorderSide(
                                                color: primary.withValues(
                                                  alpha: 0.2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                                const SizedBox(height: 8),
                                // Base stats section
                                Center(
                                  child: Text(
                                    'Base Stats',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: primary,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Animated stats with staggered entrance
                                AnimatedBuilder(
                                  animation: _statsAnimationController,
                                  builder: (context, child) {
                                    return Column(
                                      children: d.stats.entries.map((e) {
                                        final index = d.stats.keys
                                            .toList()
                                            .indexOf(e.key);
                                        final delay = index * 80;
                                        final animation =
                                            Tween<double>(
                                              begin: 0.0,
                                              end: 1.0,
                                            ).animate(
                                              CurvedAnimation(
                                                parent:
                                                    _statsAnimationController,
                                                curve: Interval(
                                                  delay /
                                                      _statsAnimationController
                                                          .duration!
                                                          .inMilliseconds,
                                                  1.0,
                                                  curve: Curves.easeOutCubic,
                                                ),
                                              ),
                                            );

                                        return Transform.translate(
                                          offset: Offset(
                                            (1 -
                                                    animation.value.clamp(
                                                      0.0,
                                                      1.0,
                                                    )) *
                                                30,
                                            0,
                                          ),
                                          child: Opacity(
                                            opacity: animation.value.clamp(
                                              0.0,
                                              1.0,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 6,
                                                  ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 90,
                                                    child: Text(
                                                      _cap(e.key),
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodyMedium,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                      child:
                                                          LinearProgressIndicator(
                                                            value:
                                                                (e.value.clamp(
                                                                  0,
                                                                  150,
                                                                )) /
                                                                150,
                                                            color: primary,
                                                            backgroundColor:
                                                                primary
                                                                    .withValues(
                                                                      alpha:
                                                                          0.15,
                                                                    ),
                                                            minHeight: 10,
                                                          ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  SizedBox(
                                                    width: 36,
                                                    child: Text(
                                                      e.value
                                                          .toString()
                                                          .padLeft(3, '0'),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Widget for displaying Pokémon information tiles
class _AboutTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _AboutTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
