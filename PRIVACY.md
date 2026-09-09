# Política de Privacidade — Coram Deo

**Última atualização:** 9 de setembro de 2026

O **Coram Deo** é um aplicativo católico dedicado à oração, meditação, leitura espiritual e acompanhamento de hábitos da vida cristã, desenvolvido de forma independente por Rafael Bilhão.

Esta Política de Privacidade descreve como os dados dos usuários são tratados no aplicativo.

---

## 1. Princípios Gerais

- O Coram Deo é um projeto gratuito, independente e **sem anúncios publicitários**.
- **Não vendemos, não alugamos e não compartilhamos** dados pessoais de nossos usuários com terceiros ou anunciantes.
- Priorizamos a privacidade e o funcionamento **offline**.

---

## 2. Dados Coletados e Finalidade

### A. Armazenamento Local (Offline)
A maioria dos recursos (leitura da Bíblia, livros de espiritualidade, orações, liturgia em cache e hábitos diários) funciona localmente no dispositivo. Esses dados ficam guardados no banco de dados SQLite e nas preferências locais (`SharedPreferences`) do seu aparelho e não saem dele a menos que você solicite o backup.

### B. Autenticação e Sincronização em Nuvem (Opcional)
Se você optar por fazer login utilizando uma conta **Google** ou cadastro de **E-mail e Senha**:
- **Dados coletados:** Nome público, endereço de e-mail e identificador único de usuário (UID) gerado pelo Firebase Authentication.
- **Finalidade:** Permitir a recuperação e sincronização dos seus hábitos do Plano de Vida e configurações entre dispositivos.
- **Armazenamento:** Os dados de backup são transmitidos de forma segura e armazenados no Google Cloud Firestore com regras de acesso restritas exclusivamente à sua conta.

---

## 3. Segurança e Exame de Consciência

- O recurso de **Exame de Consciência** pode ser protegido por autenticação biométrica (impressão digital ou reconhecimento facial) ou PIN local do dispositivo.
- O aplicativo utiliza as APIs oficiais do sistema operacional (`LocalAuthentication`). Os dados biométricos nunca saem do hardware seguro do seu aparelho e jamais são transmitidos pela internet.

---

## 4. Exclusão de Conta e Dados

Em conformidade com as diretrizes da Google Play Store e leis de proteção de dados:
- O usuário pode **excluir permanentemente sua conta e todos os dados de backup** armazenados na nuvem a qualquer momento.
- Para excluir: abra o aplicativo > **Configurações** > na seção de Backup/Conta, toque em **"Excluir conta e dados"** e confirme a ação.
- Ao confirmar, todos os registros associados ao seu UID no Firebase e a conta de autenticação serão excluídos de forma irreversível.

---

## 5. Serviços de Terceiros

O aplicativo utiliza os seguintes serviços confiáveis do Google para infraestrutura essencial:
- **Firebase Authentication**: Para login seguro.
- **Cloud Firestore**: Para armazenamento seguro do backup em nuvem (quando ativado).

---

## 6. Contato e Dúvidas

Em caso de dúvidas, solicitações ou sugestões sobre esta Política de Privacidade, entre em contato:

- **Responsável:** Rafael Bilhão
- **E-mail:** [rafaelr.bilhao@gmail.com](mailto:rafaelr.bilhao@gmail.com)
- **Repositório:** [https://github.com/Bilhao/Coram-Deo](https://github.com/Bilhao/Coram-Deo)
