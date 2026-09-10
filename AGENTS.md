# Guia de Desenvolvimento e Manutenção para Agentes de IA — Coram Deo

Este documento estabelece as regras de ouro, padrões arquiteturais, diretrizes de design, fluxo de versionamento/CI/CD, procedimentos para publicação na Google Play Store e configuração de credenciais no Firebase para o aplicativo **Coram Deo** (`com.bilhao.coramdeo`).

Qualquer Agente de IA que atue neste repositório **DEVE** seguir integralmente estas instruções.

---

## 1. Princípios Fundamentais e Regras de Ouro

1. **Alterações Incrementais e Cirúrgicas:**
   - Faça pequenas alterações de cada vez.
   - Nunca reescreva módulos inteiros desnecessariamente.
   - Evite alterar comportamentos existentes que estejam funcionando (regra de zero regressões).
2. **Preservação de Design e Estilo:**
   - Respeite rigorosamente os componentes, paletas de cores, temas e tipografia já existentes.
   - Não invente novas cores ou estilos arbitrários que divirjam do Material Design 3 configurado no app.
3. **Validação e Testes Obrigatórios Antes de Qualquer Commit:**
   - Execute sempre `flutter analyze` para garantir que **não haja erros ou avisos**.
   - Teste fontes de dados externas e persistência em cache (online e offline).
4. **Comunicação e Documentação Profissionais:**
   - Mensagens de commit e notas de versão devem ser em português formal, claras e sem emojis casuais ou excessivos.

---

## 2. Estrutura Arquitetural do Aplicativo

O Coram Deo é desenvolvido em **Flutter** utilizando o padrão **Provider** para gerenciamento de estado e uma arquitetura baseada em camadas funcionais (`Data`, `Provider`, `Page/Widget`).

### Mapa de Diretórios Principal

```
lib/
├── app/
│   ├── app_provider.dart                 # Estado global: tema, tamanho de fonte, navegação
│   ├── home_page.dart                    # Tela inicial: carrossel de cards, atalhos, progresso
│   ├── biblia/                           # Módulo da Bíblia Sagrada (leitor, busca, SQLite)
│   ├── liturgia_diaria/                  # Leituras litúrgicas do dia (cache diário em disco)
│   ├── santo_do_dia/                     # Biografia e imagem do santo (cache de imagem em disco)
│   ├── oracoes/                          # Devoções, novenas, via-sacra e terço
│   │   ├── comentario_evangelho/         # Comentário do Evangelho (Opus Dei, cache diário)
│   │   └── falar_com_deus/               # Meditações diárias (Hablar con Dios, cache diário)
│   ├── plano_de_vida/                    # Gestão e acompanhamento diário de práticas espirituais
│   ├── exame_de_consciencia/             # Exames para preparação de confissão
│   ├── settings/                         # Configurações, backup em nuvem Firestore, conta
│   ├── contribuicao/                     # Apoio financeiro via chave PIX e QR Code
│   └── search/                           # Busca global unificada de orações e livros
├── utils/
│   ├── base_provider.dart                # Classe base de estado com safeAsync e safePrefOperation
│   └── routes.dart                       # Mapeamento de rotas nomeadas do MaterialApp
└── main.dart                             # Ponto de entrada, inicialização Firebase e MultiProvider
```

### Padrão de Gerenciamento de Estado (`BaseProvider`)

Todos os provedores de estado estendem `BaseProvider` (`lib/utils/base_provider.dart`), aproveitando os métodos utilitários:
- `safeAsync(Function operation, {String? errorContext})`: Executa chamadas assíncronas tratando erros com segurança e controlando `setLoading` e `setError`.
- `safePrefOperation(Function(SharedPreferences) operation, {String? errorContext})`: Garante leitura e gravação segura no `SharedPreferences`.

### Estratégia de Caching e Suporte Offline

O aplicativo opera no formato **Offline-First**:
1. **Dados Textuais Diários (Liturgia, Santo, Comentário, Meditação):**
   - Chave de data: `"$day-$month-$year"`.
   - Ao iniciar, o provedor verifica se a data salva no `SharedPreferences` confere com o dia de hoje. Se coincidir, os dados são carregados instantaneamente da memória local, dispensando acesso à internet.
   - Caso não haja cache do dia, realiza-se a busca na rede em segundo plano e os dados retornados são salvos em disco via `_cacheData()`.
2. **Imagens e Mídias (Santo do Dia):**
   - As imagens são baixadas e persistidas como arquivos físicos no armazenamento local do dispositivo usando `path_provider` (ex: `${saintsDir.path}/santo_${day}_$month.jpg`).
   - O card da tela inicial deve **sempre priorizar `Image.file`**, com transição suave (`frameBuilder`) e fallback gracioso para `Image.network` apenas se o arquivo local ainda não foi baixado.
3. **Dados Estáticos e Livros:**
   - Textos da Bíblia e pontos de livros espirituais são armazenados em bancos de dados locais `sqflite` em `assets/databases/`, funcionando 100% offline.
4. **Sincronização em Nuvem (Backup):**
   - Realizada sob demanda pelo usuário via Firebase Auth + Cloud Firestore na tela de Configurações.

---

## 3. Diretrizes de Design e Interface (Material Design 3)

1. **Cores do Sistema:**
   - **Nunca** utilize cores estáticas ou hardcoded que conflitem com o tema (como rosas, roxos ou azuis genéricos fora do `ColorScheme`).
   - Use as cores semânticas do tema atual:
     - Fundo de cartões/containers secundários: `Theme.of(context).colorScheme.secondaryContainer`
     - Textos em containers secundários: `Theme.of(context).colorScheme.onSecondaryContainer`
     - Acentos e destaques: `Theme.of(context).colorScheme.primary`
     - Erros ou ações destrutivas: `Theme.of(context).colorScheme.error` / `colorScheme.errorContainer`
2. **Snackbars:**
   - Devem seguir o padrão com cantos arredondados:
     ```dart
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text(
           "Mensagem descritiva",
           style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
         ),
         backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
         behavior: SnackBarBehavior.floating,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
         duration: const Duration(seconds: 3),
       ),
     );
     ```
3. **Diálogos de Alerta (`AlertDialog`):**
   - Devem estar em **português**: título `"Erro de Conexão"` ou similar, texto explicativo e botão `"OK"`.
   - Sempre chame `provider.clearError()` antes de fechar o diálogo (`Navigator.of(context).pop()`).
4. **Ações Críticas / Destrutivas:**
   - Botão de exclusão de conta deve ficar ao lado direito do botão de logout da conta em Configurações, com ícone e cor de aviso (`colorScheme.error`).
5. **Reatividade em Widgets da Home:**
   - Cards que dependem de dados do provedor (como `SantoDoDiaCard` e `LiturgiaCard`) **devem escutar** o provedor (`Provider.of<T>(context)` ou `Consumer<T>`), nunca usar `listen: false`.

---

## 4. Fluxo de Trabalho Git, Versionamento e CI/CD

O repositório utiliza GitHub Actions configurado em `.github/workflows/main.yml` para compilar e gerar os arquivos de release (`.aab` e APKs) a cada merge na branch `main`.

### Passo a Passo para Atualizações e Correções de Bugs

1. **Garantir estado limpo na `main`:**
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Criar ou alternar para a branch de versão:**
   - O projeto utiliza branches de versão (ex: `v1.0.1`):
   ```bash
   git checkout -b v1.0.1 2>/dev/null || git checkout v1.0.1
   git merge main
   ```

3. **Fazer alterações cirúrgicas no código:**
   - Modifique apenas os arquivos necessários.
   - Mantenha a formatação e os comentários existentes.

4. **Atualizar o número de versão no `pubspec.yaml`:**
   - Incremente o número de build (`+buildNumber`):
   - Exemplo: `version: 1.0.1+12` -> `version: 1.0.1+13`.
   ```yaml
   version: 1.0.1+13
   ```

5. **Testar e validar localmente (OBRIGATÓRIO):**
   ```bash
   flutter analyze
   ```
   *O comando deve retornar `No issues found!` com 0 erros e 0 avisos.*

6. **Comitar as alterações:**
   - Utilize mensagens no padrão Conventional Commits em português formal:
   ```bash
   git add <arquivos_alterados> pubspec.yaml
   git commit -m "fix(escopo): descrição concisa da alteração (v1.0.1+13)"
   ```

7. **Enviar a branch para o repositório remoto:**
   ```bash
   git push origin v1.0.1
   ```

8. **Criar o Pull Request para a `main` via GitHub CLI:**
   ```bash
   gh pr create --base main --head v1.0.1 --title "Release v1.0.1+13: Resumo das alterações" --body "### Alterações Realizadas nesta Versão: ..."
   ```

9. **Mesclar o Pull Request na `main`:**
   ```bash
   gh pr merge <NUMERO_DA_PR> --merge --admin
   ```

10. **Sincronizar a branch local `main` e a de versão:**
    ```bash
    git checkout main
    git pull origin main
    git checkout v1.0.1
    git merge main
    git push origin v1.0.1
    git checkout main
    ```

11. **Acompanhar o workflow do GitHub Actions:**
    ```bash
    gh run list --limit 2
    ```
    O workflow `Flutter Build` compilará o `app-release.aab` e criará/atualizará automaticamente a Release no GitHub na tag da versão (ex: `1.0.1+13`).

---

## 5. Passo a Passo para Atualização na Google Play Store & Assinatura SHA-1 no Firebase

Quando um aplicativo é publicado na Google Play Store, o **Google Play App Signing** re-assina o pacote final (.aab) com a **chave privada de produção da Google**. Isso gera uma impressão digital SHA-1 diferente da chave local de desenvolvimento.

### Por que a SHA-1 do Google Play deve estar no Firebase?
Se a SHA-1 de produção do Google Play não for cadastrada no Firebase Console:
- O **Google Sign-In** falhará com erro de autenticação (`ApiException: 10` ou `DEVELOPER_ERROR`).
- O backup na nuvem e o Firestore recusarão a autenticação de usuários em produção.

### Passo a Passo: Configuração da Assinatura SHA-1 no Firebase

1. **Obter a SHA-1 da Google Play Console:**
   - Acesse o [Google Play Console](https://play.google.com/console).
   - Selecione o aplicativo **Coram Deo** (`com.bilhao.coramdeo`).
   - No menu lateral, navegue até: **Versão** -> **Integridade do app** (ou **Configuração** -> **Integridade do aplicativo**).
   - Na aba **Assinatura de apps do Play**, localize:
     - **Chave de assinatura do app** (App signing key certificate): copie o valor da **Impressão digital do certificado SHA-1**.
     - *(Opcional, recomendado)*: Copie também o **SHA-256**.

2. **Adicionar a SHA-1 no Firebase Console:**
   - Acesse o [Firebase Console](https://console.firebase.google.com/).
   - Selecione o projeto **coramdeo-app** (`coramdeo-app`).
   - Clique no ícone de engrenagem no canto superior esquerdo -> **Configurações do projeto** (Project Settings).
   - Na aba **Geral**, desça até a seção **Seus aplicativos** e selecione o aplicativo Android `com.bilhao.coramdeo`.
   - Na seção **Certificados de impressão digital SHA**:
     - Clique em **Adicionar impressão digital**.
     - Cole a SHA-1 obtida da Google Play Console e salve.
     - *(Se disponível, adicione também a SHA-256)*.

3. **Atualizar `google-services.json` (se necessário):**
   - Baixe o `google-services.json` atualizado do Firebase Console e substitua em `android/app/google-services.json`.

---

### Passo a Passo: Publicação da Nova Versão na Google Play Store

1. **Baixar o artefato de Release:**
   - Após a conclusão do GitHub Actions na branch `main`, acesse a seção de **Releases** do repositório no GitHub (`https://github.com/Bilhao/Coram-Deo/releases`).
   - Baixe o arquivo `Coram-Deo-<VERSAO>.aab` gerado (ex: `Coram-Deo-1.0.1+13.aab`).

2. **Criar Nova Versão no Google Play Console:**
   - No Google Play Console, vá em **Produção** (menu lateral).
   - Clique no botão **Criar nova versão** (no canto superior direito).
   - Na área **Pacotes de apps**, faça o upload do arquivo `Coram-Deo-<VERSAO>.aab`.
   - O Google Play detectará automaticamente o `versionName` e `versionCode` (ex: `1.0.1 (13)`).

3. **Preencher as Notas de Versão (Release Notes):**
   - No campo de notas da versão em Português (Brasil):
     ```
     O que há de novo nesta versão:
     - Otimização no carregamento de imagens e conteúdos diários com suporte aprimorado offline.
     - Correções e melhorias no Comentário do Evangelho e Liturgia Diária.
     - Melhorias contínuas de estabilidade e desempenho.
     ```
   - Evite gírias, emojis ou textos informais.

4. **Revisar e Enviar:**
   - Clique em **Avançar** -> **Salvar e revisar versão**.
   - Verifique se não há avisos críticos bloqueantes.
   - Clique em **Iniciar lançamento para produção** e confirme.

---

## 6. Checklist Rápido de Verificação Pré-Envio

Antes de mesclar qualquer PR para a `main`, certifique-se de que todos os itens abaixo estão cumpridos:

- [ ] `flutter analyze` executado com 0 avisos e 0 erros.
- [ ] Versão incrementada em `pubspec.yaml` (ex: `+13`).
- [ ] O código respeita a arquitetura em camadas e herda de `BaseProvider`.
- [ ] As cores e componentes seguem estritamente o `ColorScheme` do tema Material 3.
- [ ] Snackbars usam cantos arredondados (`10.0`) e cores semânticas do tema.
- [ ] Diálogos em português e com chamada a `clearError()`.
- [ ] Caches locais (`SharedPreferences` e arquivos `path_provider`) testados e funcionais.
- [ ] Nenhum segredo ou credencial sensível adicionado ao versionamento Git.
- [ ] Commit e PR criados no padrão do projeto.
