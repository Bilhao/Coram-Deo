import 'package:coramdeo/providers/bible_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:coramdeo/providers/santo_do_dia_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Theme.of(context).brightness == Brightness.dark
            ? Image.asset('assets/images/logo_dark.png', fit: BoxFit.cover)
            : Image.asset('assets/images/logo.png', fit: BoxFit.cover),
        leadingWidth: 70,
        title: const Text("Coram Deo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          flex: 2,
          child: ListView(children: const [
            Divider(height: 15, color: Colors.transparent),
            Text("Destaques",
                style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
            Divider(height: 15, color: Colors.transparent),
            HomePageCardCarusel(),
            Divider(height: 15, color: Colors.transparent),
            Text("Menu",
                style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
            Divider(height: 10, color: Colors.transparent),
            HomePageButtons(text: "Bíblia", route: '/bible'),
            HomePageButtons(text: "Livros", route: '/livros'),
            HomePageButtons(text: "Orações", route: '/oracoes'),
            HomePageButtons(text: "Liturgia diária", route: '/liturgia'),
            HomePageButtons(text: "Santo do Dia", route: '/santo-do-dia'),
            HomePageButtons(text: "Plano de vida", route: '/plano-de-vida'),
            // HomePageButtons(text: "Missal Romano", route: '/missal-romano'),
          ]),
        ),
      ]),
    );
  }
}

class HomePageButtons extends StatelessWidget {
  const HomePageButtons({super.key, required this.text, required this.route});

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 65.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: FilledButton.tonal(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
          child: Row(
            children: [
              Text(text, style: const TextStyle(fontSize: 16)),
              const Spacer(),
              const Icon(Icons.chevron_right),
            ],
          )),
    );
  }
}

class SantoDoDiaCard extends StatelessWidget {
  const SantoDoDiaCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SantoDoDiaProvider>(context, listen: false);
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: InkWell(
        radius: 100,
        borderRadius: BorderRadius.circular(10.0),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Row(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 25.0),
                    child: Stack(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(provider.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text("Clique para ver mais",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left),
                      )
                    ]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0, bottom: 25.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                          image: NetworkImage(provider.portrait),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ]),
        onTap: () => Navigator.pushNamed(context, '/santo-do-dia'),
      ),
    );
  }
}

class BibliaReadingCard extends StatelessWidget {
  const BibliaReadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BibleProvider>(context);
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: InkWell(
          radius: 100,
          borderRadius: BorderRadius.circular(10.0),
          child: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Row(children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0, bottom: 25.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("assets/images/bible.jpeg",
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 20.0, bottom: 25.0),
                      child: Column(children: [
                        Text("${provider.book} - ${provider.chapter}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Divider(
                            height: 20,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFFFFFFFF)
                                    : const Color(0xFF000000)),
                        Text(
                          provider.verses.join(" "),
                          maxLines: 5,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                        const Spacer(),
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Text("Clique para continuar leitura",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left),
                        )
                      ]),
                    ),
                  ),
                ]),
          onTap: () {
            Navigator.pushNamed(context, '/reading');
          }),
    );
  }
}

class HomePageCardCarusel extends StatelessWidget {
  const HomePageCardCarusel({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 250,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 10),
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        autoPlayCurve: Curves.easeInOut,
        showIndicator: true,
        indicatorMargin: 10.0,
        slideIndicator: CircularSlideIndicator(
            slideIndicatorOptions: SlideIndicatorOptions(
          currentIndicatorColor: Theme.of(context).colorScheme.primary,
          indicatorRadius: 3.0,
          itemSpacing: 12.0,
        )),
      ),
      items: const [
        SantoDoDiaCard(),
        BibliaReadingCard(),
      ],
    );
  }
}
