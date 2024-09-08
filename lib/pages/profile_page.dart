import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_no_cell/Repositories/Culture_repository.dart';
import 'package:debug_no_cell/pages/inspection_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentIndex = 0; // Índice da tela atual no drawer (menu lateral)
  String currentPropertyName = ''; // Nome da propriedade atual

  void updateCurrentIndex(int index, String propertyName) {
    setState(() {
      currentIndex = index; // Atualiza o índice com base no item selecionado
      currentPropertyName = propertyName; // Atualiza o nome da propriedade
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: ZoomDrawerController(), // Controlador para o drawer
      menuScreen: DrawerScreen(
        setIndex: (index, propertyName) {
          updateCurrentIndex(index, propertyName);
        },
      ),
      mainScreen: HomeScreen(propertytitle: currentPropertyName), // Exibe a tela correspondente ao índice atual
      borderRadius: 30,
      showShadow: true,
      angle: 0.0,
      menuBackgroundColor: const Color.fromARGB(255, 49, 101, 103), // Cor de fundo do menu
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String propertytitle; // Título da propriedade (se houver)

  const HomeScreen({Key? key, required this.propertytitle});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          widget.propertytitle.isEmpty ? 'Home' : widget.propertytitle, // Define o título da AppBar
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(19, 56, 58, 1),
        shadowColor: const Color.fromRGBO(19, 56, 60, 38),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1),
            topRight: Radius.circular(1),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        leading: const DrawerWidget(), // Botão para abrir o drawer
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Container(
                  width: 260,
                  height: 185,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/Tomateiro.jpg',
                      width: width(context, 50),
                      height: height(context, 30),
                      fit: BoxFit.cover, // Ajuste da imagem dentro do container
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 145,
                        height: 26,
                        child: Text(
                          'TOMATE',
                          style: TextStyle(
                            color: Color(0xFF13383A),
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: Text(
                      'Solanum Lycopersicum',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 50), //espaçamento entre a imagem e a listaç
              Center(
                child: Transform.rotate(
                  angle: -3.14, // Rotaciona o container (180 graus)
                  child: Container(
                    width: 354,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: ListView.separated(
                  shrinkWrap: true, // Ajusta o tamanho da lista
                  itemBuilder: (BuildContext context, int culture) {
                    final tabela = CultureRepository.tabela; // Corrigido o uso da variável
                    return ListTile(
                      tileColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFF13383A)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.only(left: 20.0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            tabela[culture].identificador,
                            style: const TextStyle(
                              color: Color(0xFF13383A),
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 220),
                          tabela[culture].icone, // Adiciona o ícone ao Row
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InspectionPage(), // Redireciona para a página InspectionPage
                          ),
                        );
                      },
                    );
                  },
                  padding: const EdgeInsets.all(15),
                  separatorBuilder: (_, __) => const Divider(
                    color: Colors.transparent,
                  ),
                  itemCount: CultureRepository.tabela.length, // Corrigido o acesso ao length
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Drawer para navegação
class DrawerScreen extends StatefulWidget {
  final void Function(int, String) setIndex;

  DrawerScreen({Key? key, required this.setIndex});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late String userId;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }
  }

  void onItemTapped(int index, String propertyName){
    widget.setIndex(index, propertyName); // Atualiza o índice e o nome da propriedade
    ZoomDrawer.of(context)!.toggle(); //fecha o drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 101, 103), // Cor de fundo do drawer
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(userId)
            .collection('properties')
            .snapshots(), // Escuta alterações na coleção de propriedades do usuário
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'OCORREU UM ERRO AO CARREGAR OS DADOS.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Text(
                  'AINDA NÃO HÁ PROPRIEDADES.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length, // Número de propriedades
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index]; // Documento da propriedade
                return Column(
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            title: Text(
                              "Propriedade: ${document['name']}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cep: ${document['cep']}", 
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 227, 220, 220),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              onItemTapped(index, document['name']); // Chama a função quando o item é pressionado
                            },
                          ),
                        ],
                      ),
                    ),
                    if (index != snapshot.data!.docs.length - 1)
                      const Divider(
                        height: 1.0, // Divisor entre propriedades
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Widget para o botão de abrir o drawer
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ZoomDrawer.of(context)!.toggle(); // Alternar a abertura do drawer
      },
      child: const Icon(Icons.menu),
    );
  }
}
