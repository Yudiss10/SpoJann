import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearching = false; // Untuk mengontrol apakah kotak pencarian ditampilkan
  final TextEditingController _searchController = TextEditingController();

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue, // Header drawer warna biru
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.music_note, size: 50, color: Colors.white), // Ikon besar
                  SizedBox(height: 8.0),
                  Text(
                    'SpoJann Menu',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Teks putih
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.blue),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_music, color: Colors.blue),
              title: const Text('Library'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.blue),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.blue),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.blue),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
              },
            ),
          ],
        ),
      ),
      body: Column(
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Album',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline, // Garis bawah
                ),
              ),
            ),
          ),
          // Grid Album (2x2)
          Expanded(
            flex: 1,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 kolom
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 4, // Jumlah album
              itemBuilder: (context, index) {
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
              },
            ),
          ),
          // Judul Music
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Music',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline, // Garis bawah
                ),
              ),
            ),
          ),
          // Kotak Music
          Expanded(
            flex: 1,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 4, // Jumlah musik
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MusicTile extends StatelessWidget {
  final IconData icon;
  final String songTitle;
  final String artist;

  const MusicTile({
    super.key,
    required this.icon,
    required this.songTitle,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[900], // Warna kotak lebih gelap
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.blue, // Ikon berwarna biru
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  songTitle,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Teks putih
                  ),
                ),
                Text(
                  artist,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey, // Teks abu-abu
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.play_arrow,
            size: 30,
            color: Colors.blue, // Ikon play berwarna biru
          ),
        ],
      ),
    );
  }
}