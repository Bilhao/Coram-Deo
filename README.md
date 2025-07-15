<div align="center">
<img src="https://raw.githubusercontent.com/Bilhao/Coram-Deo/main/logo.png" alt="coram-deo" width="100" height="100"/>
</div>
<h1 align="center">Coram Deo</h1>

Coram Deo é um aplicativo católico completo para oração, meditação, leitura espiritual e acompanhamento da vida cristã. Ele reúne diversas orações tradicionais, textos espirituais, leituras bíblicas, livros de espiritualidade, exame de consciência, plano de vida e muito mais, tudo em um só lugar, com interface moderna, personalizável e offline.

---

## Funcionalidades

- **Orações Tradicionais**

  - Angelus / Regina Cæli
  - Oferecimento de Obras
  - Lembrai-vos
  - Preces do Opus Dei
  - Credo Niceno-Constantinopolitano
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
  - Livros espirituais clássicos do Opus Dei:
    - Caminho
    - Sulco
    - Forja
    - Amigos de Deus
    - É Cristo que Passa
    - Via Sacra
    - Santo Rosário (livro)

- **Bíblia**

  - Leitura da Bíblia NVI (Nova Versão Internacional)
  - Navegação por livros, capítulos e versículos
  - Busca e seleção rápida

- **Plano de Vida**

  - Acompanhamento de práticas espirituais diárias
  - Marcação de hábitos e progresso

- **Personalização**

  - Ajuste do tamanho da fonte
  - Tema claro/escuro e cores dinâmicas (Material You)
  - Favoritos de orações
  - Suporte a português e latim em várias orações

- **Segurança**
  - Bloqueio do exame de consciência com biometria (opcional)

- **Otimizações Recentes (v0.1.9)**
  - Arquitetura otimizada com padrão BaseProvider para melhor performance
  - Correção de bugs críticos e melhor tratamento de erros
  - Gerenciamento centralizado de constantes e configurações
  - Melhoria significativa na velocidade de carregamento

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
    exame_de_consciencia/
    liturgia_diaria/
    livros/
    oracoes/
    plano_de_vida/
    ...
  utils/
    base_provider.dart
    constants.dart
    notification.dart
    routes.dart
assets/
  biblia_nvi.db
  plano_de_vida.db
  books/
    amigos_de_deus.db
    caminho.db
    e_cristo_que_passa.db
    forja.db
    santo_rosario.db
    sulco.db
    via_sacra.db
  images/
    logo.png
    logo_dark.png
    ...
```

- **lib/app/oracoes/**: Todas as telas de orações e espiritualidade.
- **lib/app/livros/**: Telas e lógica dos livros espirituais.
- **lib/app/biblia/**: Lógica e interface da Bíblia.
- **lib/utils/**: Utilitários compartilhados (BaseProvider, constantes, rotas).
- **assets/books/**: Bancos de dados SQLite dos livros.
- **assets/biblia_nvi.db**: Banco de dados da Bíblia NVI.
- **assets/images/**: Logos e imagens do app.

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
