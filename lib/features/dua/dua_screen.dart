import 'package:flutter/material.dart';

class DuaScreen extends StatefulWidget {
  final String category;

  const DuaScreen({super.key, required this.category});

  @override
  State<DuaScreen> createState() => _DuaScreenState();
}

class _DuaScreenState extends State<DuaScreen> {
  final Map<String, List<Map<String, String>>> duasByCategory = {
    'travel': [
      {
        'title': 'Dua for Starting a Journey',
        'arabic':
            'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ',
        'transliteration':
            'Subhanalladhi sakhkhara lana hadha wa ma kunna lahu muqrineen, wa inna ila rabbina lamunqaliboon',
        'translation':
            'Glory be to Him who has subjected this to us, and we could never have it (by our efforts). And verily, to our Lord we indeed are to return!',
      },
      {
        'title': 'Dua for Protection During Travel',
        'arabic':
            'اللَّهُمَّ إِنِّي أَسْأَلُكَ فِي سَفَرِي هَذَا الْبِرَّ وَالتَّقْوَى وَمِنَ الْعَمَلِ مَا تَرْضَى',
        'transliteration':
            'Allahumma inni as\'aluka fi safari hadhal birra wat-taqwa, wa minal-\'amali ma tarda',
        'translation':
            'O Allah, I ask You for righteousness and piety in this journey of mine, and such deeds as please You.',
      },
    ],
    'food': [
      {
        'title': 'Dua Before Eating',
        'arabic': 'بِسْمِ اللَّهِ',
        'transliteration': 'Bismillah',
        'translation': 'In the name of Allah',
      },
      {
        'title': 'Dua After Eating',
        'arabic':
            'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنِي هَذَا وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ',
        'transliteration':
            'Alhamdulillahilladhi at\'amani hadha wa razaqaneehi min ghayri hawlin minnee wa la quwwah',
        'translation':
            'All praise is due to Allah who has given me this food and provided it for me without any effort on my part or any power.',
      },
    ],
    'sleep': [
      {
        'title': 'Dua Before Sleeping',
        'arabic': 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
        'transliteration': 'Bismika Allahumma amootu wa ahya',
        'translation': 'In Your name, O Allah, I die and I live.',
      },
      {
        'title': 'Ayat-ul-Kursi Before Sleep',
        'arabic':
            'اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ',
        'transliteration':
            'Allahu la ilaha illa huwal hayyul qayyoom, la ta\'khudhuhu sinatun wa la nawm',
        'translation':
            'Allah - there is no deity except Him, the Ever-Living, the Sustainer of existence. Neither drowsiness overtakes Him nor sleep.',
      },
    ],
    'monsoon': [
      {
        'title': 'Dua When It Rains',
        'arabic': 'اللَّهُمَّ صَيِّبًا نَافِعًا',
        'transliteration': 'Allahumma sayyiban naafi\'an',
        'translation': 'O Allah, (bring) beneficial rain clouds.',
      },
      {
        'title': 'Dua for Rain to Stop',
        'arabic':
            'اللَّهُمَّ حَوَالَيْنَا وَلَا عَلَيْنَا اللَّهُمَّ عَلَى الْآكَامِ وَالظِّرَابِ وَبُطُونِ الْأَوْدِيَةِ وَمَنَابِتِ الشَّجَرِ',
        'transliteration':
            'Allahumma hawaalaina wa laa \'alaina. Allahumma \'alal aakaami wa dhdhiraabi wa butoonil awdiyati wa manaabitish shajar',
        'translation':
            'O Allah, let it rain around us and not upon us. O Allah, (let it rain) on the pastures, hills, valleys and the roots of trees.',
      },
      {
        'title': 'Dua During Thunder and Lightning',
        'arabic':
            'سُبْحَانَ الَّذِي يُسَبِّحُ الرَّعْدُ بِحَمْدِهِ وَالْمَلَائِكَةُ مِنْ خِيفَتِهِ',
        'transliteration':
            'Subhanalladhi yusabbihur ra\'du bihamdihi wal malaa\'ikatu min kheefatih',
        'translation':
            'Glory be to Him whom the thunder glorifies with His praise, and the angels too, out of fear of Him.',
      },
      {
        'title': 'Dua After Rain',
        'arabic': 'مُطِرْنَا بِفَضْلِ اللَّهِ وَرَحْمَتِهِ',
        'transliteration': 'Mutirnaa bifadhlillaahi wa rahmatih',
        'translation': 'It has rained by the grace and mercy of Allah.',
      },
    ],
  };

  String get categoryTitle {
    switch (widget.category) {
      case 'travel':
        return 'Travel Duas';
      case 'food':
        return 'Food Duas';
      case 'sleep':
        return 'Sleep Duas';
      case 'monsoon':
        return 'Monsoon Duas';
      default:
        return 'Duas';
    }
  }

  IconData get categoryIcon {
    switch (widget.category) {
      case 'travel':
        return Icons.flight;
      case 'food':
        return Icons.restaurant;
      case 'sleep':
        return Icons.bed;
      case 'monsoon':
        return Icons.cloud_queue;
      default:
        return Icons.menu_book;
    }
  }

  @override
  Widget build(BuildContext context) {
    final duas = duasByCategory[widget.category] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFE8F4FD),
      appBar: AppBar(
        title: Text(
          categoryTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4A90E2),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Category header
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  categoryIcon,
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Text(
                  categoryTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${duas.length} Duas',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Duas list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: duas.length,
              itemBuilder: (context, index) {
                final dua = duas[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              dua['title']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A90E2),
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'share') {
                                _shareDua(dua);
                              } else if (value == 'bookmark') {
                                _bookmarkDua(dua);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'share',
                                child: Row(
                                  children: [
                                    Icon(Icons.share),
                                    SizedBox(width: 8),
                                    Text('Share'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'bookmark',
                                child: Row(
                                  children: [
                                    Icon(Icons.bookmark),
                                    SizedBox(width: 8),
                                    Text('Bookmark'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Arabic text
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          dua['arabic']!,
                          style: const TextStyle(
                            fontSize: 24,
                            height: 2,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Transliteration
                      const Text(
                        'Transliteration:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dua['transliteration']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF4A90E2),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Translation
                      const Text(
                        'Translation:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dua['translation']!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(
                            icon: Icons.volume_up,
                            label: 'Listen',
                            onPressed: () => _playAudio(dua),
                          ),
                          _buildActionButton(
                            icon: Icons.copy,
                            label: 'Copy',
                            onPressed: () => _copyDua(dua),
                          ),
                          _buildActionButton(
                            icon: Icons.favorite_border,
                            label: 'Favorite',
                            onPressed: () => _favoriteDua(dua),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4A90E2).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4A90E2),
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A90E2),
            ),
          ),
        ],
      ),
    );
  }

  void _shareDua(Map<String, String> dua) {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon!')),
    );
  }

  void _bookmarkDua(Map<String, String> dua) {
    // Implement bookmark functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dua bookmarked!')),
    );
  }

  void _playAudio(Map<String, String> dua) {
    // Implement audio playback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Audio playback coming soon!')),
    );
  }

  void _copyDua(Map<String, String> dua) {
    // Implement copy to clipboard
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dua copied to clipboard!')),
    );
  }

  void _favoriteDua(Map<String, String> dua) {
    // Implement favorite functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dua added to favorites!')),
    );
  }
}
