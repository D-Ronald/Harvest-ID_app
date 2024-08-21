import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_no_cell/pages/dashboard_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

// Classe para gerenciar o estado da tela de perfil
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
        setIndex: (index, propertyName) { // Passa a função para atualizar o índice e nome
          updateCurrentIndex(index, propertyName);
        },
      ),
      mainScreen: HomeScreen(propertytitle: currentPropertyName), // Exibe a tela correspondente ao índice atual
      borderRadius: 30, // Arredonda os cantos do drawer
      showShadow: true, // Mostra sombra ao redor do drawer
      angle: 0.0, // Define o ângulo de abertura do drawer
      menuBackgroundColor: const Color.fromARGB(255, 49, 101, 103), // Cor de fundo do menu
    );
  }
}

// Tela principal que será exibida no corpo da aplicação
class HomeScreen extends StatefulWidget {
  final String propertytitle; // Título da propriedade (se houver)
  const HomeScreen({Key? key, required this.propertytitle});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Classe para gerenciar o estado da tela principal
class _HomeScreenState extends State<HomeScreen> {
  // Função para navegar até outra página (DashboardPage)
  void navigateToAnotherPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()), // Rota para a página de dashboard
    );
  }

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
        leading: DrawerWidget(), // Botão para abrir o drawer
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
              const SizedBox(width: 60), 
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
                            fontFamily: 'inter',
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
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  navigateToAnotherPage(context); // Ação ao clicar (navegar para outra página)
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start, // Alinha o conteúdo ao início
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinha o conteúdo ao início no eixo transversal
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end, // Alinha o conteúdo ao final
                      crossAxisAlignment: CrossAxisAlignment.center, // Centraliza o conteúdo no eixo transversal
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0), // Espaçamento interno
                          child: SizedBox(
                            width: 69,
                            height: 24,
                            child: Text(
                              'Ver mais', // Texto do botão
                              style: TextStyle(
                                color: Colors.black, // Cor do texto
                                fontSize: 16,
                                fontFamily: 'Cardo', // Fonte do texto
                                fontWeight: FontWeight.w400, // Peso da fonte (normal)
                                height: 0, // Altura da linha do texto
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20, // Espaçamento vertical
              ),
              Center(
                child: Transform.rotate(
                  angle: -3.14, // Rotaciona o container (180 graus)
                  child: Container(
                    width: 354, // Largura do container
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter, // Alinhamento do traçado da borda
                          color: Colors.black.withOpacity(0.25), // Cor da borda com opacidade
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Classe para o drawer (menu lateral) que permite navegar entre as telas
class DrawerScreen extends StatefulWidget {
  final void Function(int, String) setIndex; // Função para atualizar o índice e o nome da propriedade
  DrawerScreen({Key? key, required this.setIndex});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late String userId; // ID do usuário autenticado

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser; // Obtém o usuário autenticado
    if (user != null) {
      userId = user.uid; // Define o ID do usuário
    }
  }

  void onItemTapped(int index, String propertyName) {
    widget.setIndex(index, propertyName); // Notifica a tela principal sobre o item selecionado
    ZoomDrawer.of(context)!.toggle(); // Fecha o drawer
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
  const DrawerWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, color: Colors.white), // Ícone do menu
      onPressed: () {
        ZoomDrawer.of(context)!.toggle(); // Alterna o estado do drawer
      },
    );
  }
}
