import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatação de data, adicione intl: ^0.19.0 em pubspec.yaml

void main() {
  runApp(HoroscopeApp());
}

class HoroscopeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horóscopo do Dia',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto', // Usando uma fonte comum
      ),
      home: HoroscopePage(),
      debugShowCheckedModeBanner: false, // Remove o banner de debug
    );
  }
}

class HoroscopePage extends StatefulWidget {
  @override
  _HoroscopePageState createState() => _HoroscopePageState();
}

class _HoroscopePageState extends State<HoroscopePage> {
  DateTime? _selectedDate;
  String _zodiacSign = '';
  String _horoscopeMessage = '';
  String _dailyQuote = ''; // Para uma mensagem inspiradora adicional

  // Mapa de signos para mensagens de horóscopo (em português)
  final Map<String, String> _horoscopeData = {
    'Áries': '♈ Hoje é um dia para canalizar sua energia pioneira em novos começos. Aja com coragem!',
    'Touro': '♉ Busque conforto e estabilidade. Um bom momento para cuidar das suas finanças e prazeres simples.',
    'Gêmeos': '♊ Sua mente está afiada! Excelente para comunicação, aprendizado e conexões sociais.',
    'Câncer': '♋ Conecte-se com suas emoções e com seus entes queridos. O lar e a família estão em foco.',
    'Leão': '♌ Deixe seu brilho interior irradiar! Um dia favorável para a autoexpressão e criatividade.',
    'Virgem': '♍ Organize sua rotina e foque nos detalhes. A praticidade levará ao sucesso hoje.',
    'Libra': '♎ Busque harmonia e equilíbrio em seus relacionamentos. A diplomacia será sua aliada.',
    'Escorpião': '♏ Mergulhe fundo em seus projetos e paixões. A intensidade pode revelar grandes transformações.',
    'Sagitário': '♐ Aventure-se e expanda seus horizontes! Ótimo dia para aprender algo novo ou planejar uma viagem.',
    'Capricórnio': '♑ Foco e disciplina te levarão longe. Um bom momento para trabalhar em suas metas de longo prazo.',
    'Aquário': '♒ Pense fora da caixa e abrace sua originalidade. Conexões com amigos e grupos são favorecidas.',
    'Peixes': '♓ Confie na sua intuição e sensibilidade. Um dia propício para a arte, espiritualidade e compaixão.',
  };

  // Citações diárias simples
  final List<String> _dailyQuotes = [
    "Acredite em você mesmo e tudo será possível.",
    "A jornada de mil milhas começa com um único passo.",
    "Seja a mudança que você deseja ver no mundo.",
    "A felicidade não é algo pronto. Ela vem de suas próprias ações.",
    "O sucesso é a soma de pequenos esforços repetidos dia após dia."
  ];

  // Função para selecionar a data
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900), // Ano inicial permitido
      lastDate: DateTime.now(),   // Ano final permitido (não faz sentido horóscopo futuro para aniversário)
      helpText: 'Selecione sua data de nascimento',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.deepPurple,
            colorScheme: ColorScheme.light(primary: Colors.deepPurpleAccent),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _getZodiacSignAndHoroscope(picked);
        _dailyQuote = (_dailyQuotes..shuffle()).first; // Seleciona uma citação aleatória
      });
    }
  }

  // Função para determinar o signo e o horóscopo
  void _getZodiacSignAndHoroscope(DateTime birthday) {
    int day = birthday.day;
    int month = birthday.month;
    String sign = '';

    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      sign = 'Áries';
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      sign = 'Touro';
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      sign = 'Gêmeos';
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      sign = 'Câncer';
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      sign = 'Leão';
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      sign = 'Virgem';
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      sign = 'Libra';
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      sign = 'Escorpião';
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      sign = 'Sagitário';
    } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
      sign = 'Capricórnio';
    } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      sign = 'Aquário';
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      sign = 'Peixes';
    }

    setState(() {
      _zodiacSign = sign;
      _horoscopeMessage = _horoscopeData[sign] ?? 'Nenhuma mensagem encontrada para este signo.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🔮 Horóscopo do Dia ✨'),
        centerTitle: true,
        elevation: 5.0, // Adiciona uma sombra sutil
      ),
      body: Container(
        // Gradiente de fundo sutil
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade50, Colors.deepPurple.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView( // Permite rolagem se o conteúdo for grande
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Card para a citação do dia
                  if (_dailyQuote.isNotEmpty)
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      color: Colors.white.withOpacity(0.85),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _dailyQuote,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.deepPurple.shade700,
                          ),
                        ),
                      ),
                    ),

                  // Botão para selecionar data
                  ElevatedButton.icon(
                    icon: Icon(Icons.calendar_today, color: Colors.white),
                    label: Text(
                      _selectedDate == null ? 'Selecione sua Data de Nascimento' : 'Mudar Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () => _selectDate(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 5.0, // Sombra para o botão
                    ),
                  ),
                  SizedBox(height: 25),

                  // Exibição do signo e horóscopo
                  if (_zodiacSign.isNotEmpty)
                    Card(
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      color: Colors.white.withOpacity(0.9), // Leve transparência
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              'Seu signo é:',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _zodiacSign,
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber.shade700, letterSpacing: 1.2),
                            ),
                            SizedBox(height: 20),
                            Divider(color: Colors.deepPurple.shade100),
                            SizedBox(height: 15),
                            Text(
                              'Horóscopo de Hoje:',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _horoscopeMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17, color: Colors.black87, height: 1.5), // Melhor espaçamento de linha
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (_selectedDate != null) // Se data selecionada mas signo ainda não (caso raro)
                     Padding(
                       padding: const EdgeInsets.only(top: 20.0),
                       child: Text(
                         'Processando seu horóscopo...',
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                       ),
                     )
                  else // Mensagem inicial
                    Padding(
                       padding: const EdgeInsets.only(top: 20.0),
                       child: Text(
                         'Por favor, selecione sua data de nascimento para ver seu horóscopo.',
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                       ),
                     ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
