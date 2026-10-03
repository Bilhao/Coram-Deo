# Coram Deo — Versão 1.0.5 (Build 33)

## Notas da Versão / Release Notes (GitHub)

### 📿 Ordenação Alfabética das Orações
- As orações devocionais nas seções **"Todas"** e **"Favoritas"** passam a ser exibidas em rigorosa ordem alfabética, normalizando caracteres acentuados da língua portuguesa.
- Sincronização do catálogo interno de busca (`SearchProvider`) com a ordenação alfabética padronizada.

### 🇧🇷 Alinhamento ao Calendário Litúrgico da CNBB (Brasil)
- Atualização das biografias e orações do acervo de Santos do Dia para total consonância com as memórias e festas oficiais da Igreja no Brasil:
  - **São José de Anchieta** (09/06 — Apóstolo e Padroeiro do Brasil).
  - **Santo Efrém** (10/06 — Diácono e Doutor da Igreja).
  - **Santa Dulce dos Pobres** (13/08 — O Anjo Bom da Bahia, memória obrigatória).
  - **Quarenta Mártires do Brasil** (17/07 — Bem-Aventurado Inácio de Azevedo e companheiros).
  - **São João Câncio** (20/10 — Presbítero, rito romano comum).

### 🎨 Otimização do Aplicativo e Acervo Remoto de Imagens
- Redução substancial do tamanho do instalador (`.apk` / `.aab`), removendo o pacote estático de imagens dos santos do aplicativo.
- O aplicativo agora busca as pinturas sacras remotamente sob demanda com cache persistente em disco e suporte offline total após o primeiro carregamento.
- Mais de 80 retratos sacros barrocos de alta fidelidade artística adicionados e validados por inteligência artificial.

### ⚙️ Preferências e Backup em Nuvem
- O seletor de celebrações próprias da Prelazia do Opus Dei agora permanece desativado por padrão.
- Inclusão de todas as preferências do usuário no backup seguro na nuvem (Cloud Firestore).

### 🎶 Novas Devoções e Partituras Gregorianas
- Adição das liturgias da **Adoração e Bênção com o Santíssimo Sacramento** e do **Responso**.
- Novo componente de partituras gregorianas em alta definição com suporte aos modos de visualização em coluna única e bilíngue.

---

## Google Play Console — Release Notes (< 500 caracteres)

```xml
<pt-BR>
O que há de novo nesta versão:
- Orações organizadas em ordem alfabética nas seções Todas e Favoritas.
- Calendário litúrgico de Santos do Dia alinhado às diretrizes oficiais da CNBB.
- Aplicativo mais leve com download de imagens de santos sob demanda e cache offline.
- Backup seguro na nuvem de todas as configurações do usuário.
- Novas devoções: Adoração ao Santíssimo e Responso com partituras gregorianas.
- Melhorias gerais de estabilidade e interface.
</pt-BR>
<en-US>
What's new in this release:
- Prayers organized alphabetically across All and Favorites sections.
- Saints of the Day calendar fully aligned with Brazilian liturgical norms (CNBB).
- Lighter app download size with on-demand saint portrait caching and offline support.
- Secure cloud backup covering all user settings and preferences.
- New devotions: Eucharistic Adoration and Blessing, and the Libera Me with Gregorian scores.
- General stability and interface refinements.
</en-US>
```
