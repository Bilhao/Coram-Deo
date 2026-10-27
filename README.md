<div align="center">
  <img src="https://raw.githubusercontent.com/Bilhao/Coram-Deo/main/assets/images/complete_logo.png" alt="Coram Deo Logo" width="110" height="110"/>
  <h1>Coram Deo</h1>
  <p><strong>Plano de vida cristão, Missal Romano, Bíblia Sagrada, liturgia, orações e meditações diárias.</strong></p>

  <p>
    <a href="https://play.google.com/store/apps/details?id=com.bilhao.coramdeo&hl=pt_BR&gl=BR">
      <img src="https://raw.githubusercontent.com/Bilhao/Coram-Deo/main/assets/images/google-play-badge.png" alt="Disponível no Google Play" height="56" />
    </a>
  </p>

  <p>
    <a href="https://github.com/Bilhao/Coram-Deo/releases/latest">
      <img src="https://img.shields.io/github/v/release/Bilhao/Coram-Deo?label=Vers%C3%A3o&color=2e7d32" alt="Versão Atual" />
    </a>
    <img src="https://img.shields.io/badge/Plataforma-Android%20%7C%20Web%20(PWA)-blue" alt="Plataformas Android e Web" />
    <img src="https://img.shields.io/badge/Framework-Flutter-02569B" alt="Flutter" />
    <img src="https://img.shields.io/badge/Design-Material%203-7B1FA2" alt="Material 3" />
    <a href="PRIVACY.md">
      <img src="https://img.shields.io/badge/Privacidade-Conforme-informational" alt="Política de Privacidade" />
    </a>
  </p>

  <p>
    Também disponível para download direto de instaladores (<code>.apk</code> e <code>.aab</code>) via 
    <a href="https://github.com/Bilhao/Coram-Deo/releases/latest">GitHub Releases</a>.
  </p>
</div>

---

## Visão Geral

O termo latino **Coram Deo** traduz-se literalmente como *"na presença de Deus"* ou *"diante da face de Deus"*. O conceito expressa a disposição interior de viver a totalidade da existência sob o olhar divino, com retidão de intenção e busca constante de santidade nas atividades cotidianas.

O **Coram Deo** foi concebido como uma ferramenta completa e sóbria para auxiliar os fiéis católicos a estabelecerem e preservarem uma rotina consistente de práticas espirituais. Projetado sob a premissa de funcionamento prioritariamente local (*offline-first*), o aplicativo reúne Plano de Vida, Missal Romano bilíngue, Bíblia Sagrada Católica, Calendário Litúrgico, Santo do Dia, clássicos de espiritualidade, devocionário e diário espiritual em uma interface limpa e aderente às diretrizes do Material Design 3 — disponível tanto para **Android** quanto como **Web App / PWA**.

---

## Principais Recursos

### Plano de Vida Espiritual e Widgets Interativos
- Estruturação e acompanhamento diário de práticas de piedade (Santa Missa, oração da manhã/noite, Santo Rosário, leitura espiritual, visita ao Santíssimo, exame de consciência e normas personalizadas).
- **Vínculo Direto com Orações:** Toque sobre o nome da norma para abrir diretamente a oração correspondente (oficial do catálogo ou personalizada pelo usuário).
- **Widget Interativo na Tela Inicial (Android):** Mini checklist exibindo o percentual de progresso do dia e permitindo marcar o cumprimento das normas diretamente da tela inicial do aparelho.
- Notificações programadas e registro histórico de constância espiritual.

### Missal Romano Completo (*Ordo Missae* & Próprio)
- **Ordinário da Missa (*Ordo Missae*):** Ritos Iniciais, Liturgia da Palavra, Liturgia Eucarística, Rito da Comunhão e Ritos Finais.
- **Orações Eucarísticas e Prefácios:** Seleção rápida entre as Orações Eucarísticas I (*Cânon Romano*), II, III e IV, além dos principais Prefácios.
- **Modo Bilíngue Nativo e Rubricas:** Alternância instantânea entre leitura lado a lado (**Latim / Português**) e modo vernáculo simples, com rubricas (*rubricae*) destacadas em vermelho litúrgico.
- **Próprio do Tempo e dos Santos:** Antífonas, Coleta, Oração sobre as Oferendas, Pós-Comunhão e leituras do dia articuladas automaticamente com o Calendário Litúrgico.
- **Antes e Depois da Missa:** Orações clássicas de preparação (*Praeparatio ad Missam*) e ação de graças pós-comunhão (*Gratiarum Actio post Missam* — São Tomás de Aquino, Santo Ambrósio, São Boaventura, *Anima Christi*, *Adoro Te Devote*).

### Calendário Litúrgico, Liturgia Diária e Santo do Dia (100% Offline)
- **Calendário Unificado da Igreja & Prelazia do Opus Dei:** Cálculo automático de datas móveis, cores litúrgicas oficiais, lembretes de novenas e celebrações próprias da Prelazia classificadas tradicionalmente (**Classes A, B e C**).
- **Santo do Dia 100% Offline:** Banco local curado (`santos.db`) com biografias diretas, históricas e sem jargões para os 366 dias do ano, acompanhadas de gravuras em cache permanente.
- **Widget do Santo e Tempo Litúrgico (Android):** Exibe a miniatura do Santo do Dia, celebração e cor litúrgica na tela inicial com atualização automática à meia-noite.
- **Liturgia Diária e Pipeline em Nuvem:** Leituras completas da Missa do dia com pré-processamento serverless na nuvem para carregamento instantâneo e cache local offline.

### Bíblia Sagrada Católica (Multi-Versões, Destaques e Notas)
- Cânon Católico completo de **73 livros** (46 no Antigo Testamento e 27 no Novo Testamento), totalmente offline.
- **5 Traduções Católicas:** *Bíblia Ave Maria* (nativa offline), *Pe. Manuel de Matos Soares (1956)*, *Vulgata Clementina (Latim)*, *Douay-Rheims (Inglês)* e *Torres Amat (Espanhol)*.
- **Destaques e Notas Pessoais:** Toque em qualquer versículo para destacar com paleta suave (amarelo, verde, azul, rosa) vinculada à versão bíblica, adicionar notas pessoais, copiar ou compartilhar com citação formatada, e consultar na tela **"Meus Versículos e Destaques"**.
- **Cache LRU em Memória:** Alternância instantânea (0ms) entre capítulos bíblicos e pontos de livros espirituais.

### Devocionário Tradicional e Orações Personalizadas
- **Modos de Exibição (*Todas* vs. *Categorias*):** Navegação inferior ágil com lista geral (incluindo seção de Favoritas) e cartões expansíveis por temas (*Orações do Dia*, *Santa Missa*, *Devoções Marianas*, *Santíssimo Sacramento*, *Espírito Santo*, *Hinos e Símbolos da Fé*, *Santos e Intercessores* e *Penitenciais*).
- **Modo Coluna Bilíngue (Latim / Português):** Mais de 40 orações e hinos tradicionais (*Te Deum*, *Veni Creator*, *Veni Sancte Spiritus*, *Pange Lingua*, *Alma Redemptoris Mater*, *Ave Regina Caelorum*, *Salve Regina*, *Sub Tuum Praesidium*, *Magnificat*, *Benedictus*, *Nunc Dimittis*, *Miserere*, *Credo Atanasiano*, *Triságio Angélico*, entre outras).
- **Orações Personalizadas pelo Usuário:** Cadastre, edite e organize suas próprias orações devocionais (Título, Subtítulo e Texto) com backup automático na nuvem.

### Diário Espiritual ("Luzes de Oração")
- Espaço minimalista e privativo acessível pelo ícone de caderno na barra superior da tela inicial.
- Registro estruturado por **Data**, **Título** e **Texto da Anotação**, com atalho rápido para salvar reflexões ao concluir o *Exame de Consciência* ou a meditação diária *Falar com Deus*.
- Sincronização automática com **criptografia ponta a ponta** no Cloud Firestore.

### Busca Global Inteligente Unificada
- Pesquisa simultânea e instantânea com filtros rápidos por categoria em:
  - **Orações** (pelo título e pelo corpo completo em português/latim, incluindo orações personalizadas).
  - **Livros de São Josemaría** (*Caminho*, *Sulco*, *Forja*, *Amigos de Deus*, *É Cristo que Passa*, *Santo Rosário*, *Via Sacra* — por palavra-chave ou número direto do ponto, ex: `"Caminho 28"`).
  - **Bíblia Sagrada** (por termo ou referência).
  - **Santos e Celebrações do Calendário**.

---

## Como Acessar e Testar o Web App (PWA)

A partir da versão **v1.2.0**, o Coram Deo conta com suporte completo para execução no navegador (Desktop, Tablet e Mobile) via **SQLite WebAssembly (`sqflite_common_ffi_web`)** e layout adaptativo Material Design 3 (`NavigationRail` em telas largas).

### Opção 1: Executar em Modo de Desenvolvimento (Chrome / Web Server)
Ideal para testar alterações em tempo real com *Hot Reload*:

1. No terminal, na raiz do projeto, liste os dispositivos disponíveis ou rode diretamente no Chrome:
   ```bash
   flutter run -d chrome
   ```
   *(Caso não tenha o Chrome instalado ou queira abrir em outro navegador como Firefox/Brave, utilize o servidor web do Flutter):*
   ```bash
   flutter run -d web-server --web-port 8080
   ```
2. Abra o navegador e acesse: **`http://localhost:8080`**

### Opção 2: Testar a Versão Final de Produção (PWA Offline-First)
Ideal para testar o desempenho real de produção, o *Service Worker*, o carregamento do banco SQLite Wasm (`sqlite3.wasm` e `sqflite_sw.js`) e a instalação como aplicativo (PWA):

1. Gere o build otimizado de produção para Web:
   ```bash
   flutter build web --release
   ```
2. Sirva a pasta `build/web` localmente usando Python (já instalado no Linux):
   ```bash
   python3 -m http.server 8080 --directory build/web
   ```
3. Abra o navegador em **`http://localhost:8080`**.
4. **Dicas de teste no navegador:**
   - **Layout Responsivo:** Redimensione a janela do navegador acima e abaixo de `720px` de largura para ver a transição automática entre o layout clássico mobile e o layout Desktop/Tablet com barra lateral (`NavigationRail`) e grade em duas colunas.
   - **Bancos SQLite no Navegador:** Abra a *Bíblia*, *Livros*, *Santo do Dia* ou *Plano de Vida* — os bancos `.db` são carregados via WebAssembly (`sqlite3.wasm`) e persistidos no **IndexedDB** do navegador.
   - **Instalação do PWA:** Na barra de endereços do Chrome/Edge/Brave, clique no ícone **"Instalar Coram Deo"** para testar o aplicativo em janela dedicada (*standalone*).

---

## Instruções para Compilação Android

### Pré-requisitos
- Flutter SDK (`>=3.38.9`) e Dart SDK (`^3.9.0`).
- Android SDK configurado.

### Procedimento
```bash
# 1. Instalar dependências
flutter pub get

# 2. Executar análise estática (deve retornar 0 problemas)
flutter analyze

# 3. Executar em dispositivo ou emulador Android
flutter run

# 4. Compilar pacote de lançamento (.aab ou .apk)
flutter build appbundle --release
flutter build apk --release
```

---

## Privacidade e Segurança

- **Operação Local (*Offline-First*):** Textos bíblicos, santos, orações, notas do exame de consciência, diário espiritual e livros são armazenados localmente no dispositivo.
- **Proteção Biométrica e Criptografia:** O Exame de Consciência conta com bloqueio opcional por biometria/PIN, e as anotações do Diário Espiritual ("Luzes de Oração") são criptografadas antes do envio ao backup em nuvem.
- **Conformidade:** Consulte a [Política de Privacidade](PRIVACY.md) para mais detalhes.

---

## Contato e Suporte

- **Desenvolvedor:** Rafael Bilhão
- **E-mail:** [rafaelr.bilhao@gmail.com](mailto:rafaelr.bilhao@gmail.com)
- **Repositório Oficial:** [github.com/Bilhao/Coram-Deo](https://github.com/Bilhao/Coram-Deo)
