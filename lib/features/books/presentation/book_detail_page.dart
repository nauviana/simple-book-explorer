import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String workKey; // encoded
  final Map<String, dynamic>? extra;

  const BookDetailPage({
    super.key,
    required this.workKey,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final decodedWorkKey = Uri.decodeComponent(workKey);
    final title = extra?['title']?.toString() ?? 'Book Detail';
    final author = extra?['author']?.toString() ?? '-';
    final coverUrl = extra?['coverUrl']?.toString() ?? '';

    final topColor = Color.alphaBlend(
      cs.primary.withOpacity(0.78),
      cs.surface,
    );

    return Scaffold(
      backgroundColor: cs.surface,
      body: Column(
        children: [
          // ===== TOP SECTION (like your reference) =====
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: topColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(0),
                bottom: Radius.circular(26),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
                child: Column(
                  children: [
                    // Top actions row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _TopIcon(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: () => Navigator.pop(context),
                        ),
                        _TopIcon(
                          icon: Icons.bookmark_border_rounded,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Saved')),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Cover centered (small) with shadow
                    _CoverCentered(coverUrl: coverUrl),

                    const SizedBox(height: 18),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Author center
                    Text(
                      'by $author',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white.withOpacity(0.92),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 18),
                    const _StatsRow(),

                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ),

          // ===== BOTTOM CONTENT (white area) =====
          Expanded(
            child: Container(
              width: double.infinity,
              color: cs.surface, // base background
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sinopsis',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Halaman ini menampilkan detail buku dari data OpenLibrary (title, author, cover). ''bisa juga mengenai Sinopsis',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: cs.onSurface.withOpacity(0.75),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 14),


                      Text(
                        'Work Key',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: cs.onSurface.withOpacity(0.60),
                        ),
                      ),
                      const SizedBox(height: 6),
                      SelectableText(
                        decodedWorkKey,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: cs.onSurface.withOpacity(0.75),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Save button (only one)
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Saved')),
                            );
                          },
                          icon: const Icon(Icons.bookmark_add_rounded),
                          label: const Text('Save'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cs.primary,
                            foregroundColor: cs.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.22),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

class _CoverCentered extends StatelessWidget {
  final String coverUrl;
  const _CoverCentered({required this.coverUrl});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: 128,
      height: 184,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: coverUrl.isEmpty
            ? Container(
          color: cs.surface,
          alignment: Alignment.center,
          child: Icon(Icons.menu_book_rounded,
              size: 56, color: cs.onSurface.withOpacity(0.55)),
        )
            : CachedNetworkImage(
          imageUrl: coverUrl,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            color: cs.surface,
            alignment: Alignment.center,
            child: const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (_, __, ___) => Container(
            color: cs.surface,
            alignment: Alignment.center,
            child: Icon(Icons.broken_image_outlined,
                size: 44, color: cs.onSurface.withOpacity(0.55)),
          ),
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    // Dummy display untuk visual seperti referensi
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _Stat(label: 'Rating', value: '4.7'),
        _Stat(label: 'Pages', value: '—'),
        _Stat(label: 'Language', value: '—'),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;

  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white.withOpacity(0.90),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
