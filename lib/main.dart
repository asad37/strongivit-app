import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const StrongivityApp());
}

class StrongivityApp extends StatelessWidget {
  const StrongivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Strongivity',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          primary: const Color(0xFF6366F1),
          secondary: const Color(0xFF8B5CF6),
          tertiary: const Color(0xFFEC4899),
          surface: const Color(0xFFF8FAFC),
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFFDDD6FE),
          labelStyle: const TextStyle(
            color: Color(0xFF5B21B6),
            fontWeight: FontWeight.w500,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xFF6366F1),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF8B5CF6),
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEC4899),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class Country {
  final String code; // ISO or short code
  final String name;
  // Scores for aspects: PWR, TECH, RES, STRAT, STAB (each 0-10)
  final List<int> aspects;

  Country({required this.code, required this.name, required this.aspects});
}

class Participant {
  String name;
  List<Country> picks = [];

  Participant(this.name);

  Map<String, int> totals() {
    final totals = {'PWR': 0, 'TECH': 0, 'RES': 0, 'STRAT': 0, 'STAB': 0};
    for (var c in picks) {
      totals['PWR'] = totals['PWR']! + c.aspects[0];
      totals['TECH'] = totals['TECH']! + c.aspects[1];
      totals['RES'] = totals['RES']! + c.aspects[2];
      totals['STRAT'] = totals['STRAT']! + c.aspects[3];
      totals['STAB'] = totals['STAB']! + c.aspects[4];
    }
    return totals;
  }

  int grandTotal() {
    return totals().values.reduce((a, b) => a + b);
  }
}

// Sample country dataset with balanced scores (0–10)
// Format: Country(code, name, [PWR, TECH, RES, STRAT, STAB])
final List<Country> kCountries = [
  Country(code: 'AF', name: 'Afghanistan', aspects: [3, 2, 4, 3, 2]),
  Country(code: 'AL', name: 'Albania', aspects: [4, 4, 3, 4, 5]),
  Country(code: 'DZ', name: 'Algeria', aspects: [5, 4, 8, 5, 5]),
  Country(code: 'AD', name: 'Andorra', aspects: [3, 5, 2, 3, 7]),
  Country(code: 'AO', name: 'Angola', aspects: [4, 3, 8, 4, 3]),
  Country(code: 'AR', name: 'Argentina', aspects: [6, 6, 7, 6, 6]),
  Country(code: 'AM', name: 'Armenia', aspects: [4, 5, 3, 4, 5]),
  Country(code: 'AU', name: 'Australia', aspects: [7, 7, 8, 7, 8]),
  Country(code: 'AT', name: 'Austria', aspects: [6, 8, 4, 7, 8]),
  Country(code: 'AZ', name: 'Azerbaijan', aspects: [5, 4, 7, 5, 5]),
  Country(code: 'BS', name: 'Bahamas', aspects: [3, 5, 3, 4, 7]),
  Country(code: 'BH', name: 'Bahrain', aspects: [4, 7, 3, 5, 7]),
  Country(code: 'BD', name: 'Bangladesh', aspects: [5, 4, 5, 5, 5]),
  Country(code: 'BB', name: 'Barbados', aspects: [3, 5, 2, 4, 7]),
  Country(code: 'BY', name: 'Belarus', aspects: [5, 5, 5, 5, 4]),
  Country(code: 'BE', name: 'Belgium', aspects: [6, 8, 4, 7, 8]),
  Country(code: 'BZ', name: 'Belize', aspects: [3, 4, 3, 4, 6]),
  Country(code: 'BJ', name: 'Benin', aspects: [3, 3, 4, 3, 4]),
  Country(code: 'BT', name: 'Bhutan', aspects: [2, 4, 3, 3, 7]),
  Country(code: 'BO', name: 'Bolivia', aspects: [4, 4, 7, 4, 4]),
  Country(code: 'BA', name: 'Bosnia & Herzegovina', aspects: [4, 5, 3, 5, 5]),
  Country(code: 'BW', name: 'Botswana', aspects: [4, 5, 6, 4, 7]),
  Country(code: 'BR', name: 'Brazil', aspects: [6, 5, 9, 6, 5]),
  Country(code: 'BN', name: 'Brunei', aspects: [4, 7, 7, 5, 7]),
  Country(code: 'BG', name: 'Bulgaria', aspects: [5, 6, 4, 5, 6]),
  Country(code: 'BF', name: 'Burkina Faso', aspects: [3, 3, 5, 3, 3]),
  Country(code: 'BI', name: 'Burundi', aspects: [2, 2, 3, 2, 2]),
  Country(code: 'KH', name: 'Cambodia', aspects: [4, 4, 4, 4, 4]),
  Country(code: 'CM', name: 'Cameroon', aspects: [4, 4, 6, 4, 4]),
  Country(code: 'CA', name: 'Canada', aspects: [7, 8, 7, 7, 8]),
  Country(code: 'CV', name: 'Cape Verde', aspects: [3, 5, 3, 4, 7]),
  Country(
    code: 'CF',
    name: 'Central African Republic',
    aspects: [2, 2, 5, 2, 2],
  ),
  Country(code: 'TD', name: 'Chad', aspects: [3, 2, 6, 3, 2]),
  Country(code: 'CL', name: 'Chile', aspects: [6, 7, 6, 6, 7]),
  Country(code: 'CN', name: 'China', aspects: [9, 8, 9, 9, 7]),
  Country(code: 'CO', name: 'Colombia', aspects: [5, 5, 7, 5, 5]),
  Country(code: 'KM', name: 'Comoros', aspects: [2, 3, 2, 2, 5]),
  Country(code: 'CG', name: 'Congo', aspects: [3, 3, 7, 3, 3]),
  Country(code: 'CR', name: 'Costa Rica', aspects: [4, 6, 4, 5, 8]),
  Country(code: 'HR', name: 'Croatia', aspects: [5, 6, 4, 6, 7]),
  Country(code: 'CU', name: 'Cuba', aspects: [4, 4, 5, 4, 4]),
  Country(code: 'CY', name: 'Cyprus', aspects: [4, 7, 3, 5, 7]),
  Country(code: 'CZ', name: 'Czech Republic', aspects: [6, 7, 4, 7, 7]),
  Country(code: 'DK', name: 'Denmark', aspects: [6, 9, 4, 7, 9]),
  Country(code: 'DJ', name: 'Djibouti', aspects: [3, 3, 4, 3, 4]),
  Country(code: 'DO', name: 'Dominican Republic', aspects: [4, 5, 5, 4, 5]),
  Country(code: 'EC', name: 'Ecuador', aspects: [4, 5, 7, 5, 5]),
  Country(code: 'EG', name: 'Egypt', aspects: [6, 5, 8, 6, 5]),
  Country(code: 'SV', name: 'El Salvador', aspects: [4, 4, 4, 4, 4]),
  Country(code: 'GQ', name: 'Equatorial Guinea', aspects: [3, 3, 8, 3, 3]),
  Country(code: 'ER', name: 'Eritrea', aspects: [2, 2, 3, 2, 2]),
  Country(code: 'EE', name: 'Estonia', aspects: [5, 9, 3, 6, 8]),
  Country(code: 'ET', name: 'Ethiopia', aspects: [4, 4, 6, 4, 4]),
  Country(code: 'FI', name: 'Finland', aspects: [6, 9, 4, 7, 9]),
  Country(code: 'FR', name: 'France', aspects: [8, 8, 6, 8, 8]),
  Country(code: 'GA', name: 'Gabon', aspects: [4, 4, 8, 4, 4]),
  Country(code: 'GM', name: 'Gambia', aspects: [2, 3, 3, 3, 5]),
  Country(code: 'GE', name: 'Georgia', aspects: [4, 6, 4, 5, 5]),
  Country(code: 'DE', name: 'Germany', aspects: [8, 9, 6, 8, 8]),
  Country(code: 'GH', name: 'Ghana', aspects: [4, 5, 6, 4, 5]),
  Country(code: 'GR', name: 'Greece', aspects: [6, 7, 4, 6, 6]),
  Country(code: 'GT', name: 'Guatemala', aspects: [4, 4, 5, 4, 4]),
  Country(code: 'GN', name: 'Guinea', aspects: [3, 3, 6, 3, 3]),
  Country(code: 'GY', name: 'Guyana', aspects: [4, 4, 7, 4, 5]),
  Country(code: 'HT', name: 'Haiti', aspects: [2, 2, 3, 2, 2]),
  Country(code: 'HN', name: 'Honduras', aspects: [3, 3, 4, 3, 3]),
  Country(code: 'HU', name: 'Hungary', aspects: [5, 7, 4, 6, 6]),
  Country(code: 'IS', name: 'Iceland', aspects: [5, 8, 3, 6, 9]),
  Country(code: 'IN', name: 'India', aspects: [7, 6, 8, 7, 6]),
  Country(code: 'ID', name: 'Indonesia', aspects: [6, 5, 8, 6, 6]),
  Country(code: 'IR', name: 'Iran', aspects: [5, 4, 7, 5, 4]),
  Country(code: 'IQ', name: 'Iraq', aspects: [4, 3, 8, 4, 3]),
  Country(code: 'IE', name: 'Ireland', aspects: [6, 8, 4, 7, 8]),
  Country(code: 'IL', name: 'Israel', aspects: [6, 9, 4, 6, 6]),
  Country(code: 'IT', name: 'Italy', aspects: [6, 7, 5, 6, 7]),
  Country(code: 'JP', name: 'Japan', aspects: [7, 9, 5, 7, 8]),
  Country(code: 'JO', name: 'Jordan', aspects: [4, 5, 4, 5, 6]),
  Country(code: 'KZ', name: 'Kazakhstan', aspects: [6, 5, 8, 6, 5]),
  Country(code: 'KE', name: 'Kenya', aspects: [4, 5, 6, 4, 5]),
  Country(code: 'KR', name: 'South Korea', aspects: [7, 9, 5, 7, 8]),
  Country(code: 'KW', name: 'Kuwait', aspects: [5, 7, 9, 6, 7]),
  Country(code: 'KG', name: 'Kyrgyzstan', aspects: [3, 3, 4, 3, 4]),
  Country(code: 'LA', name: 'Laos', aspects: [3, 3, 4, 3, 4]),
  Country(code: 'LV', name: 'Latvia', aspects: [4, 7, 3, 5, 7]),
  Country(code: 'LB', name: 'Lebanon', aspects: [3, 5, 3, 4, 3]),
  Country(code: 'LS', name: 'Lesotho', aspects: [2, 3, 3, 3, 5]),
  Country(code: 'LR', name: 'Liberia', aspects: [2, 2, 4, 2, 2]),
  Country(code: 'LY', name: 'Libya', aspects: [4, 3, 8, 4, 2]),
  Country(code: 'LT', name: 'Lithuania', aspects: [5, 7, 3, 6, 7]),
  Country(code: 'LU', name: 'Luxembourg', aspects: [5, 9, 2, 6, 9]),
  Country(code: 'MG', name: 'Madagascar', aspects: [3, 3, 6, 3, 4]),
  Country(code: 'MW', name: 'Malawi', aspects: [2, 2, 4, 3, 4]),
  Country(code: 'MY', name: 'Malaysia', aspects: [6, 7, 6, 6, 7]),
  Country(code: 'MV', name: 'Maldives', aspects: [2, 5, 2, 3, 8]),
  Country(code: 'ML', name: 'Mali', aspects: [3, 3, 6, 3, 3]),
  Country(code: 'MT', name: 'Malta', aspects: [3, 7, 2, 4, 8]),
  Country(code: 'MX', name: 'Mexico', aspects: [5, 5, 7, 5, 5]),
  Country(code: 'MD', name: 'Moldova', aspects: [3, 4, 3, 4, 4]),
  Country(code: 'MN', name: 'Mongolia', aspects: [4, 4, 6, 5, 4]),
  Country(code: 'ME', name: 'Montenegro', aspects: [3, 5, 3, 4, 6]),
  Country(code: 'MA', name: 'Morocco', aspects: [5, 5, 6, 5, 6]),
  Country(code: 'MZ', name: 'Mozambique', aspects: [3, 3, 7, 3, 4]),
  Country(code: 'MM', name: 'Myanmar', aspects: [4, 3, 6, 4, 3]),
  Country(code: 'NA', name: 'Namibia', aspects: [4, 4, 7, 4, 6]),
  Country(code: 'NP', name: 'Nepal', aspects: [3, 4, 3, 4, 6]),
  Country(code: 'NL', name: 'Netherlands', aspects: [7, 9, 4, 7, 8]),
  Country(code: 'NZ', name: 'New Zealand', aspects: [6, 8, 5, 7, 9]),
  Country(code: 'NI', name: 'Nicaragua', aspects: [3, 3, 4, 3, 4]),
  Country(code: 'NE', name: 'Niger', aspects: [2, 2, 6, 2, 2]),
  Country(code: 'NG', name: 'Nigeria', aspects: [5, 4, 9, 5, 4]),
  Country(code: 'MK', name: 'North Macedonia', aspects: [4, 5, 3, 4, 6]),
  Country(code: 'NO', name: 'Norway', aspects: [7, 9, 6, 7, 9]),
  Country(code: 'OM', name: 'Oman', aspects: [5, 6, 8, 5, 7]),
  Country(code: 'PK', name: 'Pakistan', aspects: [4, 4, 6, 4, 4]),
  Country(code: 'PA', name: 'Panama', aspects: [4, 5, 5, 5, 7]),
  Country(code: 'PG', name: 'Papua New Guinea', aspects: [3, 3, 6, 3, 3]),
  Country(code: 'PY', name: 'Paraguay', aspects: [3, 4, 5, 4, 5]),
  Country(code: 'PE', name: 'Peru', aspects: [5, 5, 7, 5, 5]),
  Country(code: 'PH', name: 'Philippines', aspects: [4, 6, 6, 5, 6]),
  Country(code: 'PL', name: 'Poland', aspects: [6, 7, 4, 6, 7]),
  Country(code: 'PT', name: 'Portugal', aspects: [6, 7, 4, 6, 7]),
  Country(code: 'QA', name: 'Qatar', aspects: [6, 8, 10, 6, 8]),
  Country(code: 'RO', name: 'Romania', aspects: [5, 6, 4, 5, 6]),
  Country(code: 'RU', name: 'Russia', aspects: [8, 6, 10, 7, 5]),
  Country(code: 'RW', name: 'Rwanda', aspects: [3, 5, 4, 4, 6]),
  Country(code: 'SA', name: 'Saudi Arabia', aspects: [6, 5, 10, 6, 6]),
  Country(code: 'SN', name: 'Senegal', aspects: [4, 5, 5, 4, 5]),
  Country(code: 'RS', name: 'Serbia', aspects: [5, 6, 4, 5, 5]),
  Country(code: 'SC', name: 'Seychelles', aspects: [2, 5, 2, 3, 8]),
  Country(code: 'SL', name: 'Sierra Leone', aspects: [2, 2, 5, 2, 3]),
  Country(code: 'SG', name: 'Singapore', aspects: [7, 10, 3, 8, 9]),
  Country(code: 'SK', name: 'Slovakia', aspects: [5, 7, 4, 6, 7]),
  Country(code: 'SI', name: 'Slovenia', aspects: [5, 7, 3, 6, 8]),
  Country(code: 'SO', name: 'Somalia', aspects: [1, 2, 3, 1, 1]),
  Country(code: 'ZA', name: 'South Africa', aspects: [5, 6, 8, 5, 5]),
  Country(code: 'ES', name: 'Spain', aspects: [7, 7, 5, 7, 7]),
  Country(code: 'LK', name: 'Sri Lanka', aspects: [4, 5, 5, 5, 6]),
  Country(code: 'SD', name: 'Sudan', aspects: [3, 3, 8, 3, 2]),
  Country(code: 'SR', name: 'Suriname', aspects: [3, 4, 7, 3, 5]),
  Country(code: 'SE', name: 'Sweden', aspects: [7, 9, 4, 7, 9]),
  Country(code: 'CH', name: 'Switzerland', aspects: [7, 10, 4, 7, 10]),
  Country(code: 'SY', name: 'Syria', aspects: [3, 2, 6, 3, 2]),
  Country(code: 'TW', name: 'Taiwan', aspects: [7, 9, 5, 7, 8]),
  Country(code: 'TJ', name: 'Tajikistan', aspects: [3, 3, 4, 3, 3]),
  Country(code: 'TZ', name: 'Tanzania', aspects: [4, 4, 6, 4, 5]),
  Country(code: 'TH', name: 'Thailand', aspects: [6, 7, 6, 6, 7]),
  Country(code: 'TG', name: 'Togo', aspects: [3, 3, 4, 3, 3]),
  Country(code: 'TT', name: 'Trinidad and Tobago', aspects: [4, 6, 7, 4, 7]),
  Country(code: 'TN', name: 'Tunisia', aspects: [5, 5, 5, 5, 6]),
  Country(code: 'TR', name: 'Turkey', aspects: [6, 6, 6, 6, 6]),
  Country(code: 'TM', name: 'Turkmenistan', aspects: [4, 3, 7, 4, 3]),
  Country(code: 'UG', name: 'Uganda', aspects: [3, 4, 5, 4, 5]),
  Country(code: 'UA', name: 'Ukraine', aspects: [6, 6, 7, 6, 4]),
  Country(code: 'AE', name: 'UAE', aspects: [7, 8, 9, 7, 8]),
  Country(
    code: 'GB',
    name: 'United Kingdom',
    aspects: [8, 9, 6, 8, 8],
  ), // FIXED: Added missing stability score
  Country(code: 'US', name: 'United States', aspects: [9, 9, 8, 9, 7]),
  Country(code: 'UY', name: 'Uruguay', aspects: [5, 6, 5, 5, 7]),
  Country(code: 'UZ', name: 'Uzbekistan', aspects: [4, 4, 6, 4, 4]),
  Country(code: 'VE', name: 'Venezuela', aspects: [4, 3, 9, 4, 2]),
  Country(code: 'VN', name: 'Vietnam', aspects: [5, 6, 6, 6, 6]),
  Country(code: 'YE', name: 'Yemen', aspects: [2, 2, 5, 2, 2]),
  Country(code: 'ZM', name: 'Zambia', aspects: [3, 4, 7, 4, 5]),
  Country(code: 'ZW', name: 'Zimbabwe', aspects: [3, 3, 6, 3, 3]),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Participant> participants = [
    Participant('Qasim'),
    Participant('Asad'),
    Participant('Ibrahim'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Strongivity - Pick 10 countries'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.leaderboard),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ResultsPage(participants: participants),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: participants.length + 1,
        itemBuilder: (context, index) {
          if (index == participants.length) {
            return Card(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDD6FE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add, color: Color(0xFF6366F1)),
                ),
                title: const Text(
                  'Add participant',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                onTap: () => _addParticipantDialog(),
              ),
            );
          }
          final p = participants[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                p.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                '${p.picks.length} picks',
                style: const TextStyle(color: Color(0xFF64748B)),
              ),
              trailing: const Icon(
                Icons.navigate_next,
                color: Color(0xFF6366F1),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PickCountriesPage(
                      participant: p,
                      onChanged: () => setState(() {}),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _addParticipantDialog() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New participant'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                setState(() {
                  participants.add(Participant(ctrl.text.trim()));
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class PickCountriesPage extends StatefulWidget {
  final Participant participant;
  final VoidCallback onChanged;

  const PickCountriesPage({
    super.key,
    required this.participant,
    required this.onChanged,
  });

  @override
  _PickCountriesPageState createState() => _PickCountriesPageState();
}

class _PickCountriesPageState extends State<PickCountriesPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = kCountries
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: Text('Pick for ${widget.participant.name}'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${widget.participant.picks.length}/10',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search country',
                prefixIcon: Icon(Icons.search, color: Color(0xFF6366F1)),
              ),
              onChanged: (v) => setState(() => query = v),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final c = filtered[index];
                final picked = widget.participant.picks.contains(c);
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(
                      c.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: picked ? const Color(0xFF6366F1) : null,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          _buildAspectChip(
                            'PWR',
                            c.aspects[0],
                            const Color(0xFFEF4444),
                          ),
                          _buildAspectChip(
                            'TECH',
                            c.aspects[1],
                            const Color(0xFF3B82F6),
                          ),
                          _buildAspectChip(
                            'RES',
                            c.aspects[2],
                            const Color(0xFF10B981),
                          ),
                          _buildAspectChip(
                            'STRAT',
                            c.aspects[3],
                            const Color(0xFFF59E0B),
                          ),
                          _buildAspectChip(
                            'STAB',
                            c.aspects[4],
                            const Color(0xFF8B5CF6),
                          ),
                        ],
                      ),
                    ),
                    trailing: picked
                        ? const Icon(
                            Icons.check_circle,
                            color: Color(0xFF10B981),
                            size: 28,
                          )
                        : const Icon(
                            Icons.circle_outlined,
                            color: Color(0xFFCBD5E1),
                            size: 28,
                          ),
                    onTap: () {
                      setState(() {
                        if (picked) {
                          widget.participant.picks.remove(c);
                        } else {
                          if (widget.participant.picks.length >= 10) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'You can only pick up to 10 countries.',
                                ),
                                backgroundColor: const Color(0xFFEF4444),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                            return;
                          }
                          widget.participant.picks.add(c);
                        }
                        widget.onChanged();
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Done'),
        icon: const Icon(Icons.check),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildAspectChip(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        '$label:$value',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final List<Participant> participants;

  const ResultsPage({super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
    final sorted = List<Participant>.from(participants)
      ..sort((a, b) => b.grandTotal().compareTo(a.grandTotal()));

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Results & Leaderboard'),
        actions: [
          IconButton(icon: const Icon(Icons.emoji_events), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: sorted.length,
                itemBuilder: (context, index) {
                  final p = sorted[index];
                  final t = p.totals();
                  final isWinner = index == 0;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: isWinner
                            ? const LinearGradient(
                                colors: [Color(0xFFFEF3C7), Color(0xFFFDE68A)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: isWinner
                                              ? [
                                                  const Color(0xFFFBBF24),
                                                  const Color(0xFFF59E0B),
                                                ]
                                              : [
                                                  const Color(0xFF6366F1),
                                                  const Color(0xFF8B5CF6),
                                                ],
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          isWinner ? '👑' : '${index + 1}',
                                          style: TextStyle(
                                            fontSize: isWinner ? 20 : 18,
                                            fontWeight: FontWeight.bold,
                                            color: isWinner
                                                ? null
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      p.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isWinner
                                            ? const Color(0xFF92400E)
                                            : const Color(0xFF1E293B),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: isWinner
                                          ? [
                                              const Color(0xFFFBBF24),
                                              const Color(0xFFF59E0B),
                                            ]
                                          : [
                                              const Color(0xFF6366F1),
                                              const Color(0xFF8B5CF6),
                                            ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${p.grandTotal()}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: p.picks
                                  .map(
                                    (c) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFFE2E8F0),
                                        ),
                                      ),
                                      child: Text(
                                        c.name,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF475569),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 16),
                            AspectRow(
                              label: 'PWR',
                              value: t['PWR']!,
                              color: const Color(0xFFEF4444),
                            ),
                            AspectRow(
                              label: 'TECH',
                              value: t['TECH']!,
                              color: const Color(0xFF3B82F6),
                            ),
                            AspectRow(
                              label: 'RES',
                              value: t['RES']!,
                              color: const Color(0xFF10B981),
                            ),
                            AspectRow(
                              label: 'STRAT',
                              value: t['STRAT']!,
                              color: const Color(0xFFF59E0B),
                            ),
                            AspectRow(
                              label: 'STAB',
                              value: t['STAB']!,
                              color: const Color(0xFF8B5CF6),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                // Reset picks
                for (var p in participants) {
                  p.picks.clear();
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset picks'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tip: Edit the country list in the source (kCountries) to customize aspect values.',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class AspectRow extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const AspectRow({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: color,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: value / 100.0,
                  child: Container(
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withOpacity(0.7)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Text(
              '$value',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
