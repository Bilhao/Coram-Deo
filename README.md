<div align="center">
  <img src="https://raw.githubusercontent.com/Bilhao/Coram-Deo/main/assets/images/complete_logo.png" alt="coram-deo" width="100" height="100"/>
  <h1>Coram Deo</h1>
  <p>Aplicativo católico completo para oração, meditação, leitura espiritual e acompanhamento da vida cristã.</p>

  <a href="https://play.google.com/store/apps/details?id=com.bilhao.coramdeo">
    <img src="https://play.google.com/intl/en_us/badges/static/images/badges/pt-br_badge_web_generic.png" alt="Disponível no Google Play" height="60" />
  </a>
</div>

Coram Deo é um aplicativo católico completo para oração, meditação, leitura espiritual e acompanhamento da vida cristã. Ele reúne diversas orações tradicionais, textos espirituais, leituras bíblicas, livros de espiritualidade, exame de consciência, plano de vida e muito mais, tudo em um só lugar, com interface moderna, personalizável e offline.

---

## Funcionalidades

- **Orações Tradicionais**
  - Angelus / Regina Cæli
  - Oferecimento de Obras
  - Lembrai-vos
  - Preces do Opus Dei
  - Credo Niceno-Constantinopolitano
  - Credo Atanasiano
  - Santo Rosário (com mistérios diários e ladainha)
  - Te Deum
  - Adoro Te Devote
  - Gratias tibi ago
  - Salmo 2
  - Visita ao Santíssimo
  - Exame de Consciência (com orações preparatórias)
  - Estampa de São Josemaria Escrivá

- **Meditação e Espiritualidade**
  - Meditação diária do "Falar com Deus"
  - Comentário do Evangelho do dia (Opus Dei)
  - Santo do Dia (com fonte e referência)
  - Livros espirituais clássicos de São Josemaria Escrivá:
    - Caminho
    - Sulco
    - Forja
    - Amigos de Deus
    - É Cristo que Passa
    - Via Sacra
    - Santo Rosário (livro)

- **Bíblia Sagrada**
  - Leitura bíblica completa com suporte a múltiplas versões:
    - NVI (Nova Versão Internacional)
    - ACF (Almeida Corrigida Fiel)
    - KJV (King James Version)
    - RVR (Reina-Valera)
  - Navegação intuitiva por livros, capítulos e versículos
  - Busca de texto e seleção rápida
  - 100% offline

- **Sincronização e Backup em Nuvem**
  - Autenticação segura com Google Sign-In ou E-mail e Senha via Firebase
  - Backup na nuvem e restauração dos hábitos do Plano de Vida e preferências
  - Sincronização automática e contínua entre dispositivos

- **Apoio e Contribuição**
  - Canal para apoiar a manutenção e o desenvolvimento contínuo do projeto
  - Chave PIX integrada disponível exclusivamente na tela de Configurações

- **Plano de Vida**
  - Acompanhamento de práticas espirituais diárias
  - Marcação de hábitos e progresso espiritual

- **Personalização e Segurança**
  - Ajuste do tamanho da fonte e tipografia de leitura
  - Tema claro/escuro e cores dinâmicas (Material You)
  - Favoritos de orações
  - Suporte a português e latim em várias orações
  - Bloqueio do exame de consciência com biometria ou PIN

- **Novidades da Versão (v1.0.1)**
  - Sincronização em nuvem e autenticação (Google e E-mail/Senha com Firebase)
  - Remoção de dependências de áudio/TTS da Bíblia para um app mais leve e estável
  - Nova tela de contribuição via PIX nas configurações
  - Opção de login e sincronização no onboarding inicial
  - Atualização para Android Gradle Plugin 8.11+ e melhorias de compatibilidade

---

## Instalação

### Pré-requisitos

- [Flutter](https://flutter.dev/) 3.x
- [Dart](https://dart.dev/) 2.x
- Android Studio ou VS Code

### Passos

1. Clone o repositório:

   ```sh
   git clone https://github.com/Bilhao/Coram-Deo.git
   cd Coram-Deo
   ```

2. Instale as dependências:

   ```sh
   flutter pub get
   ```

3. Rode o app:
   ```sh
   flutter run
   ```

---

## Estrutura do Projeto

```
lib/
  main.dart
  app/
    app_provider.dart
    home_page.dart
    settings_page.dart
    biblia/
    contribuicao/
    exame_de_consciencia/
    liturgia_diaria/
    livros/
    onboarding/
    oracoes/
    plano_de_vida/
    santo_do_dia/
    search/
  services/
    auth_service.dart
    cloud_sync_service.dart
  widgets/
    auth_dialog.dart
  utils/
    base_provider.dart
    constants.dart
    notification.dart
    routes.dart
assets/
  biblia_acf.db
  biblia_kjv.db
  biblia_nvi.db
  biblia_rvr.db
  plano_de_vida.db
  books/
    amigos_de_deus.db
    caminho.db
    e_cristo_que_passa.db
    forja.db
    santo_rosario_livro.db
    sulco.db
    via_sacra_livro.db
  images/
    complete_logo.png
    logo.png
    logo_dark.png
    ...
```

- **lib/app/oracoes/**: Orações e espiritualidade cristã.
- **lib/app/livros/**: Telas e leituras dos livros de São Josemaria Escrivá.
- **lib/app/biblia/**: Lógica e interface de leitura da Bíblia (offline e multi-versões).
- **lib/app/contribuicao/**: Tela para contribuição e suporte via PIX.
- **lib/services/**: Serviços de autenticação e sincronização em nuvem com Firebase.
- **lib/utils/**: Provedores base, constantes globais, notificações e rotas.
- **assets/books/**: Bancos de dados SQLite dos livros espirituais.
- **assets/biblia_*.db**: Bancos de dados SQLite das traduções bíblicas (ACF, KJV, NVI, RVR).
- **assets/images/**: Identidade visual e imagens do aplicativo.

---

## Créditos e Fontes

- Meditações diárias: [Hablar con Dios](https://www.hablarcondios.org/pt/meditacaodiaria.aspx)
- Comentários do Evangelho: [Opus Dei](https://opusdei.org/pt-br/gospel/)
- Santo do Dia: [A12 - Santuário Nacional](https://www.a12.com/reze-no-santuario/santo-do-dia)
- Livros de São Josemaria: [escrivaworks.org](https://escrivaworks.org/), [opusdei.org](https://opusdei.org/pt-br/saint-josemaria/)
- Imagens: [assets/images/](assets/images/)

---

## Licença

Este projeto possui uma **licença pessoal** e não deve ser utilizado, distribuído ou modificado sem autorização prévia do autor. Para mais informações entre em contato diretamente.

---

## Contato

Dúvidas, sugestões ou colaborações:  
[Rafael Bilhão](mailto:rafaelr.bilhao@gmail.com)  
[github.com/Bilhao/Coram-Deo](https://github.com/Bilhao/Coram-Deo)
