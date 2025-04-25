import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearching = false; // Untuk mengontrol apakah kotak pencarian ditampilkan
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0; // Untuk mengontrol navigasi bottom bar
  String? _currentPlayingMusic; // Untuk menyimpan musik yang sedang diputar

  // Fungsi untuk menangani perubahan tab di Bottom Navigation Bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Fungsi untuk menangani klik pada musik
  void _playMusic(String musicTitle) {
    setState(() {
      _currentPlayingMusic = musicTitle; // Set musik yang sedang diputar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Header warna biru biasa
        title: Row(
          children: [
            const Icon(Icons.music_note, color: Colors.white), // Music icon warna putih
            const SizedBox(width: 8.0), // Spacing between icon and text
            const Text(
              'SpoJann',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white, // Teks warna putih
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white), // Tombol search
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching; // Toggle pencarian
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kotak pencarian dengan animasi
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300), // Durasi animasi
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, -1.0), // Mulai dari atas
                        end: Offset.zero, // Berakhir di posisi normal
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: _isSearching
                      ? Padding(
                          key: const ValueKey('searchBox'),
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              // Logika pencarian dapat ditambahkan di sini
                              print('Searching for: $value');
                            },
                          ),
                        )
                      : const SizedBox(key: ValueKey('emptySpace')), // Placeholder kosong jika tidak mencari
                ),
                // Judul Album
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Album',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline, // Garis bawah
                    ),
                  ),
                ),
                // Grid Album (2x2)
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(), // Non-scrollable
                  shrinkWrap: true, // Agar GridView menyesuaikan tinggi konten
                  crossAxisCount: 2, // 2 kolom
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: List.generate(4, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          'Album ${index + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }),
                ),
                // Judul Music
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Music',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline, // Garis bawah
                    ),
                  ),
                ),
                // Kotak Music
                Column(
                  children: List.generate(4, (index) {
                    return GestureDetector(
                      onTap: () => _playMusic('Music ${index + 1}'), // Klik untuk memutar musik
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                        width: double.infinity, // Memenuhi lebar layar
                        height: 100, // Tinggi kotak musik
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            'Music ${index + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          // Kotak Musik yang Sedang Diputar
          if (_currentPlayingMusic != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 80.0), // Di bawah tombol Add
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900], // Warna latar belakang kotak
                  borderRadius: BorderRadius.circular(12.0), // Border radius
                  border: Border.all(color: Colors.white, width: 2.0), // Border putih dengan 2px
                ),
                width: MediaQuery.of(context).size.width * 0.9, // Lebar kotak 90% dari layar
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.music_note, color: Colors.white, size: 40), // Ikon musik
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _currentPlayingMusic ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const Text(
                                  'Artist Name', // Nama artist
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Text(
                          '0:00 / 3:45', // Waktu musik
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Garis penanda progress musik
                    Stack(
                      children: [
                        Container(
                          height: 4.0,
                          width: double.infinity,
                          color: Colors.grey, // Warna background progress
                        ),
                        Container(
                          height: 4.0,
                          width: 100.0, // Panjang progress musik
                          color: Colors.blue, // Warna progress
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logika untuk tombol Add
          print('Add button pressed');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Indeks tab yang dipilih
        onTap: _onItemTapped, // Fungsi untuk menangani perubahan tab
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.album),
            label: 'Album',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        selectedItemColor: Colors.white, // Warna item yang dipilih (ikon dan teks)
        unselectedItemColor: Colors.white, // Warna item yang tidak dipilih (ikon dan teks)
        backgroundColor: Colors.blue, // Warna latar belakang navigasi bawah
      ),
    );
  }
}