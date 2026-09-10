<div align="center">
  <img src="https://raw.githubusercontent.com/Bilhao/Coram-Deo/main/assets/images/complete_logo.png" alt="Coram Deo Logo" width="110" height="110"/>
  <h1>Coram Deo</h1>
  <p><strong>Plano de vida cristão, leituras litúrgicas, orações e meditações diárias.</strong></p>

  <p>
    <a href="https://play.google.com/store/apps/details?id=com.bilhao.coramdeo&hl=pt_BR&gl=BR">
      <img src="https://raw.githubusercontent.com/Bilhao/Coram-Deo/main/assets/images/google-play-badge.png" alt="Disponível no Google Play" height="56" />
    </a>
  </p>

  <p>
    <a href="https://github.com/Bilhao/Coram-Deo/releases/latest">
      <img src="https://img.shields.io/github/v/release/Bilhao/Coram-Deo?label=Vers%C3%A3o&color=2e7d32" alt="Versão Atual" />
    </a>
    <img src="https://img.shields.io/badge/Plataforma-Android-blue" alt="Plataforma Android" />
    <img src="https://img.shields.io/badge/Framework-Flutter-02569B" alt="Flutter" />
    <img src="https://img.shields.io/badge/Design-Material%203-7B1FA2" alt="Material 3" />
    <a href="PRIVACY.md">
      <img src="https://img.shields.io/badge/Privacidade-Conforme-informational" alt="Política de Privacidade" />
    </a>
  </p>

  <p>
    Também disponível para download direto de instaladores (.apk e .aab) via 
    <a href="https://github.com/Bilhao/Coram-Deo/releases/latest">GitHub Releases</a>.
  </p>
</div>

---

## Visão Geral

O termo latino **Coram Deo** traduz-se literalmente como *"na presença de Deus"* ou *"diante da face de Deus"*. O conceito expressa a disposição interior de viver a totalidade da existência sob o olhar divino, com retidão de intenção e busca constante de santidade nas atividades cotidianas.

O **Coram Deo** foi concebido como uma ferramenta completa e austera para auxiliar os fiéis católicos a estabelecerem e preservarem uma rotina consistente de práticas espirituais. Projetado sob a premissa de funcionamento prioritariamente local (*offline-first*), o aplicativo reúne liturgia diária, textos bíblicos, clássicos de espiritualidade, orações tradicionais e acompanhamento de hábitos em uma interface limpa e aderente às diretrizes do Material Design 3.

---

## Principais Recursos

### Plano de Vida Espiritual
- Estruturação e acompanhamento de práticas de piedade ao longo do dia (Santa Missa, oração mental, Santo Rosário, leitura espiritual, visita ao Santíssimo, entre outras).
- Marcação diária de cumprimento de atos e registro histórico de constância espiritual.
- Notificações programadas e discretas para recordar os momentos de oração.

### Liturgia Diária e Santo do Dia
- Acesso integral aos textos litúrgicos da Santa Missa do dia (Primeira Leitura, Salmo Responsorial, Segunda Leitura e Santo Evangelho).
- Biografia do Santo do Dia acompanhada de retrato histórico.
- Sistema de armazenamento persistente em disco: os dados e imagens são salvos localmente no primeiro carregamento, permitindo visualização instantânea e operação integral sem dependência de conexão com a internet.

### Meditações Diárias
- **Falar com Deus:** Meditações diárias baseadas na clássica obra de Francisco Fernández-Carvajal, organizadas conforme o calendário litúrgico.
- **Comentário do Evangelho:** Reflexões exegéticas e práticas sobre o Evangelho do dia, produzidas pelo Escritório de Comunicação da Prelazia do Opus Dei.
- Ambos os módulos contam com cache local automático e suporte a leitura offline.

### Bíblia Sagrada
- Leitor bíblico integral offline com navegação rápida por livros, capítulos e versículos.
- Quatro traduções tradicionais disponíveis:
  - Nova Versão Internacional (NVI)
  - Almeida Corrigida Fiel (ACF)
  - King James Version (KJV)
  - Reina-Valera (RVR)
- Mecanismo de busca textual interno e dimensionamento dinâmico de tipografia.

### Biblioteca de Clássicos de Espiritualidade
- Obras fundamentais de São Josemaria Escrivá pré-carregadas em bancos locais para leitura e oração pessoal:
  - *Caminho*
  - *Sulco*
  - *Forja*
  - *Amigos de Deus*
  - *É Cristo que Passa*
  - *Via Sacra*
  - *Santo Rosário*
- Leitura estruturada por capítulos e busca por pontos específicos.

### Orações Tradicionais da Igreja
- Vasto repertório devocional católico organizado por categorias:
  - Santo Rosário completo com contemplação dos mistérios diários e Ladainha Lauretana.
  - Orações horárias: Angelus e Regina Caeli.
  - Orações da manhã e da noite: Oferecimento de Obras, Lembrai-vos, Te Deum, Salmo 2.
  - Devoção Eucarística: Adoro Te Devote, Visita ao Santíssimo Sacramento, orações pós-comunhão.
  - Símbolos de fé: Credo Niceno-Constantinopolitano e Símbolo Atanasiano (*Quicumque*).
  - Textos disponíveis em língua portuguesa e em língua latina.

### Exame de Consciência e Preparação Penitencial
- Roteiros estruturados para exame de consciência detalhado à luz dos Mandamentos e deveres de estado.
- Orações preparatórias e orações de contrição.
- Mecanismo de proteção de privacidade: bloqueio da tela de exame de consciência por autenticação biométrica ou código PIN do dispositivo.

### Sincronização Segura e Backup em Nuvem
- Autenticação opcional por meio de credenciais Google (Google Sign-In) ou E-mail e Senha.
- Backup criptografado das preferências e do progresso do Plano de Vida via Cloud Firestore.
- Restauração de dados simplificada ao migrar de aparelho celular.

---

## Privacidade e Segurança

O aplicativo adota uma postura rigorosa em relação à integridade e confidencialidade dos dados dos fiéis:
- **Operação Local:** Textos bíblicos, orações, notas do exame de consciência e livros são processados e armazenados estritamente na memória do próprio aparelho.
- **Autenticação Opcional:** O aplicativo pode ser utilizado plenamente sem a criação de qualquer conta ou cadastro.
- **Conformidade:** Para informações detalhadas sobre a coleta mínima de dados analíticos e tratamento de dados de autenticação, consulte a [Política de Privacidade](PRIVACY.md).

---

## Especificações Técnicas

- **Plataforma Alvo:** Android (versão 5.0 Lollipop ou superior).
- **Arquiteturas Suportadas:** `arm64-v8a`, `armeabi-v7a`, `x86_64`.
- **Framework:** Flutter 3.x com Dart 3.x.
- **Gerenciamento de Estado:** Provider com herança arquitetural em camada base (`BaseProvider`).
- **Persistência de Dados:** SQLite (`sqflite`), `shared_preferences` e armazenamento em disco via `path_provider`.
- **Serviços em Nuvem:** Google Firebase Authentication e Google Cloud Firestore.
- **Design System:** Material Design 3 com suporte a temas Claro e Escuro, tipografia escalável e cores dinâmicas (*Material You*).

---

## Instruções para Compilação Local

Caso deseje compilar o projeto a partir do código-fonte para desenvolvimento ou auditoria:

### Pré-requisitos
- Flutter SDK instalado e configurado no PATH do sistema.
- Dart SDK versão 3.0 ou superior.
- Android SDK com ferramentas de compilação instaladas.

### Procedimento
1. Clone o repositório:
   ```bash
   git clone https://github.com/Bilhao/Coram-Deo.git
   cd Coram-Deo
   ```

2. Obtenha os pacotes e dependências:
   ```bash
   flutter pub get
   ```

3. Execute a análise estática para validação:
   ```bash
   flutter analyze
   ```

4. Execute o aplicativo em dispositivo físico ou emulador:
   ```bash
   flutter run
   ```

---

## Apoio ao Projeto

O desenvolvimento, manutenção e hospedagem dos serviços do Coram Deo são conduzidos de forma voluntária e independente.

Para apoiar a continuidade e expansão do projeto, o aplicativo disponibiliza uma seção de apoio nas configurações do sistema com chave PIX integrada para contribuições voluntárias.

---

## Fontes Litúrgicas e Agradecimentos

O projeto expressa reconhecimento às fontes cujos textos e referências enriquecem o aplicativo:
- **Hablar con Dios:** Textos das meditações diárias de autoria de Francisco Fernández-Carvajal ([hablarcondios.org](https://www.hablarcondios.org/pt/meditacaodiaria.aspx)).
- **Escritório de Comunicação do Opus Dei:** Textos dos comentários diários ao Santo Evangelho ([opusdei.org](https://opusdei.org/pt-br/gospel/)).
- **Santuário Nacional de Aparecida / Portal A12:** Referências do Santo do Dia ([a12.com](https://www.a12.com/reze-no-santuario/santo-do-dia)).
- **Fundação Studium e EscrivaWorks:** Textos dos livros e escritos de São Josemaria Escrivá ([escrivaworks.org](https://escrivaworks.org/)).

---

## Contato e Suporte

Para reporte de inconsistências em textos litúrgicos, sugestões de novos recursos ou suporte técnico:
- **Desenvolvedor:** Rafael Bilhão
- **E-mail:** [rafaelr.bilhao@gmail.com](mailto:rafaelr.bilhao@gmail.com)
- **Repositório Oficial:** [github.com/Bilhao/Coram-Deo](https://github.com/Bilhao/Coram-Deo)
