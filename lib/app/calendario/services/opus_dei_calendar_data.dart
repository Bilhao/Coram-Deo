import 'package:coramdeo/app/calendario/models/liturgical_day.dart';

class OpusDeiCalendarData {
  /// Celebrações e aniversários fixos do calendário da Prelazia do Opus Dei.
  static final Map<String, OpusDeiCelebration> celebrations = {
    // ==========================================
    // JANEIRO
    // ==========================================
    '01-01': const OpusDeiCelebration(
      name: 'Santa Maria, Mãe de Deus',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade da Santa Mãe de Deus e início do ano civil. Invocação da proteção maternal de Maria para toda a Igreja e a Obra.',
    ),
    '01-03': const OpusDeiCelebration(
      name: 'Santíssimo Nome de Jesus',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória do Santíssimo Nome de Jesus, invocado com amor filial e devoção constante na vida interior.',
    ),
    '01-06': const OpusDeiCelebration(
      name: 'Epifania do Senhor',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade da manifestação do Senhor a todos os povos e nações, representados nos Santos Reis Magos.',
    ),
    '01-09': const OpusDeiCelebration(
      name: 'Aniversário do nascimento de São Josemaria (1902)',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa do nascimento de São Josemaria Escrivá em Barbastro, Espanha. Bênção solene com a santa relíquia nos oratórios.',
    ),
    '01-23': const OpusDeiCelebration(
      name: 'Aniversário da nomeação do Prelado (2017)',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa do aniversário da nomeação e confirmação de Mons. Fernando Ocáriz como Prelado do Opus Dei pelo Papa Francisco.',
    ),
    '01-24': const OpusDeiCelebration(
      name: 'Santa Maria da Paz',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de Nossa Senhora da Paz, titular da Igreja Prelatícia da Obra em Roma.',
    ),
    '01-25': const OpusDeiCelebration(
      name: 'Conversão de São Paulo, Apóstolo',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração da conversão do Apóstolo dos Gentios na estrada de Damasco. Modelo de resposta generosa à vocação divina.',
    ),
    '01-28': const OpusDeiCelebration(
      name: 'São Tomás de Aquino, presbítero e doutor da Igreja',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de São Tomás de Aquino, o Doutor Angélico, patrono dos estudos teológicos e filosóficos.',
    ),

    // ==========================================
    // FEVEREIRO
    // ==========================================
    '02-02': const OpusDeiCelebration(
      name: 'Apresentação do Senhor no Templo',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa da Apresentação de Jesus no Templo e Encontro com o Santo Velho Simeão e a profetisa Ana.',
    ),
    '02-07': const OpusDeiCelebration(
      name: 'Cinco Chagas de Nosso Senhor Jesus Cristo',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória e contemplação piedosa das Cinco Chagas de Cristo Crucificado, refúgio de paz e fonte de fortaleza interior.',
    ),
    '02-11': const OpusDeiCelebration(
      name: 'Nossa Senhora de Lourdes',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração de Nossa Senhora de Lourdes, refúgio dos enfermos e modelo de pureza imaculada.',
    ),
    '02-14': const OpusDeiCelebration(
      name:
          'Início do apostolado com as mulheres (1930) e da Sociedade Sacerdotal da Santa Cruz (1943)',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade de Santa Maria, Mãe do Belo Amor. Nesta data, São Josemaria compreendeu por inspiração divina a extensão do Opus Dei às mulheres (1930) e, em 1943, a fundação da Sociedade Sacerdotal da Santa Cruz. Canto do Te Deum.',
    ),
    '02-22': const OpusDeiCelebration(
      name: 'Cátedra de São Pedro, Apóstolo',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração da autoridade apostólica e da missão confiada por Cristo a Pedro e aos seus sucessores, expressando ardente amor ao Papa.',
    ),
    '02-24': const OpusDeiCelebration(
      name: 'Aniversário do Decretum Laudis (1947)',
      classRank: OpusDeiClass.classeD,
      description:
          'Aniversário da emissão do primeiro Decreto de Louvor (Decretum Laudis) da Santa Sé concedido ao Opus Dei pelo Papa Pio XII.',
    ),

    // ==========================================
    // MARÇO
    // ==========================================
    '03-19': const OpusDeiCelebration(
      name: 'São José, Esposo da Virgem Maria e Patrono do Opus Dei',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade de São José, Patrono da Igreja universal e da Obra. Renovação solene da consagração de todos os fiéis da Prelazia.',
    ),
    '03-20': const OpusDeiCelebration(
      name: 'Festa da Família (Obra de São Gabriel)',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração dedicada às famílias dos membros e cooperadores do Opus Dei, sob o patrocínio do Arcanjo São Gabriel.',
    ),
    '03-25': const OpusDeiCelebration(
      name: 'Anunciação do Senhor',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade da Encarnação do Filho de Deus no seio puríssimo da Santíssima Virgem Maria pelo anúncio do Arcanjo Gabriel.',
    ),
    '03-28': const OpusDeiCelebration(
      name: 'Aniversário da Ordenação Sacerdotal de São Josemaria (1925)',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa da ordenação sacerdotal de São Josemaria em Saragoça. Bênção solene com a santa relíquia nos oratórios.',
    ),

    // ==========================================
    // ABRIL
    // ==========================================
    '04-23': const OpusDeiCelebration(
      name: 'Aniversário da 1ª Comunhão de São Josemaria (1912)',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa do aniversário da Primeira Comunhão de São Josemaria na festa de São Jorge em Barbastro.',
    ),
    '04-25': const OpusDeiCelebration(
      name: 'São Marcos, Evangelista',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de São Marcos Evangelista, discípulo e intérprete de São Pedro e autor do segundo Evangelho.',
    ),
    '04-27': const OpusDeiCelebration(
      name: 'Nossa Senhora de Montserrat e Cura de São Josemaria (1954)',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração de Nossa Senhora de Montserrat e ação de graças pela cura milagrosa e instantânea do diabetes de São Josemaria em 1954.',
    ),
    '04-29': const OpusDeiCelebration(
      name: 'Santa Catarina de Sena, virgem e doutora da Igreja',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de Santa Catarina de Sena, padroeira da Europa e intercessora particular no apostolado de opinião pública.',
    ),

    // ==========================================
    // MAIO
    // ==========================================
    '05-01': const OpusDeiCelebration(
      name: 'São José Operário',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de São José Operário, modelo perene do trabalho santificado no silêncio e na fidelidade da oficina de Nazaré.',
    ),
    '05-02': const OpusDeiCelebration(
      name: 'Dedicação da Igreja Prelatícia de Santa Maria da Paz (1986)',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa da dedicação solene da igreja prelatícia em Roma, onde repousam os restos sagrados de São Josemaria e do Beato Álvaro.',
    ),
    '05-03': const OpusDeiCelebration(
      name: 'São Filipe e São Tiago Menor, Apóstolos',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa dos Santos Apóstolos Filipe e Tiago, testemunhas de Cristo e pilares da Santa Igreja.',
    ),
    '05-08': const OpusDeiCelebration(
      name: 'Aniversário da Eleição do Romano Pontífice',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa em sufrágio e ação de graças pela eleição do Romano Pontífice, Sucessor de Pedro e Vigário de Cristo na terra. Canto solene do Te Deum.',
    ),
    '05-12': const OpusDeiCelebration(
      name: 'Beato Álvaro del Portillo, bispo',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa do Beato Álvaro del Portillo, bispo e primeiro sucessor de São Josemaria à frente do Opus Dei. Bênção com a santa relíquia.',
    ),
    '05-13': const OpusDeiCelebration(
      name: 'Nossa Senhora de Fátima',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração das aparições da Santíssima Virgem aos pastorinhos em Fátima, Portugal.',
    ),
    '05-14': const OpusDeiCelebration(
      name: 'São Matias, Apóstolo',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de São Matias, chamado ao colégio apostólico para ocupar o lugar de Judas Iscariotes.',
    ),
    '05-17': const OpusDeiCelebration(
      name: 'Aniversário da Beatificação de São Josemaria (1992)',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração da solene beatificação do fundador do Opus Dei pelo Papa São João Paulo II na Praça de São Pedro.',
    ),
    '05-18': const OpusDeiCelebration(
      name: 'Beata Guadalupe Ortiz de Landázuri',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória da Beata Guadalupe Ortiz de Landázuri, fiel leiga e numerária do Opus Dei, pioneira apostólica no México e na Espanha.',
    ),
    '05-30': const OpusDeiCelebration(
      name: 'Santo do Padre (São Fernando)',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa do santo onomástico do Prelado do Opus Dei (Mons. Fernando Ocáriz), sob o patrocínio de São Fernando, Rei. Canto do Te Deum.',
    ),
    '05-31': const OpusDeiCelebration(
      name: 'Visitação da Bem-Aventurada Virgem Maria',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa da Visitação de Maria Santíssima a sua prima Santa Isabel, entoando o hino do Magnificat.',
    ),

    // ==========================================
    // JUNHO
    // ==========================================
    '06-10': const OpusDeiCelebration(
      name: 'Santo Anjo da Guarda de Portugal',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória do Santo Anjo Custódio e padroeiro de Portugal.',
    ),
    '06-11': const OpusDeiCelebration(
      name: 'São Barnabé, Apóstolo',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de São Barnabé Apóstolo, companheiro de São Paulo nas primeiras missões apostólicas.',
    ),
    '06-16': const OpusDeiCelebration(
      name: 'Aniversário da Aprovação Definitiva do Opus Dei (1950)',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória do decreto de aprovação pontifícia definitiva da Obra concedida pelo Papa Pio XII através do Breve Cum Societatis.',
    ),
    '06-22': const OpusDeiCelebration(
      name: 'São Tomás Moro, mártir e intercessor',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de São Tomás Moro, chanceler e mártir inglês, modelo de santidade no exercício de cargos públicos e deveres de cidadania.',
    ),
    '06-24': const OpusDeiCelebration(
      name: 'Natividade de São João Batista',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa da Natividade de São João Batista, a voz que clama no deserto e o Precursor do Cordeiro de Deus.',
    ),
    '06-25': const OpusDeiCelebration(
      name: 'Aniversário da Ordenação dos Primeiros Sacerdotes (1944)',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória da ordenação sacerdotal de D. Álvaro del Portillo, José María Hernández Garnica e José Luis Múzquiz pelas mãos do Bispo de Madrid.',
    ),
    '06-26': const OpusDeiCelebration(
      name: 'São Josemaria Escrivá, Fundador do Opus Dei',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade litúrgica de São Josemaria Escrivá de Balaguer (1902–1975). Bênção solene com a santa relíquia nos oratórios.',
    ),
    '06-29': const OpusDeiCelebration(
      name: 'São Pedro e São Paulo, Apóstolos e Patronos',
      classRank: OpusDeiClass.classeB,
      description:
          'Solenidade em Roma e Festa na Prelazia em honra de São Pedro e São Paulo, patronos dos apostolados da Obra.',
    ),

    // ==========================================
    // JULHO
    // ==========================================
    '07-03': const OpusDeiCelebration(
      name: 'São Tomé, Apóstolo',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de São Tomé Apóstolo, que confessou a divindade de Cristo com as palavras: "Meu Senhor e meu Deus!".',
    ),
    '07-11': const OpusDeiCelebration(
      name: 'São Bento, abade e padroeiro da Europa',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de São Bento, patriarca dos monges do Ocidente e mestre da oração e do trabalho (Ora et Labora).',
    ),
    '07-16': const OpusDeiCelebration(
      name: 'Nossa Senhora do Carmo',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de Nossa Senhora do Monte Carmelo e do Santo Escapulário, sinal de proteção e devoção mariana.',
    ),
    '07-22': const OpusDeiCelebration(
      name: 'Santa Maria Madalena',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de Santa Maria Madalena, primeira testemunha da Ressurreição do Senhor e apóstola dos apóstolos.',
    ),
    '07-23': const OpusDeiCelebration(
      name: 'Santa Brígida da Suécia, religiosa e padroeira da Europa',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de Santa Brígida da Suécia, mística, mãe de família e modelo de zelo pela unidade e reforma da Igreja.',
    ),
    '07-25': const OpusDeiCelebration(
      name: 'São Tiago Maior, Apóstolo',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa do Apóstolo São Tiago, primeiro dos apóstolos a derramar o sangue por Cristo e patrono da Espanha.',
    ),
    '07-26': const OpusDeiCelebration(
      name: 'São Joaquim e Santa Ana, pais de Nossa Senhora',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração dos santos avós de Jesus, patronos dos pais de família e modelo de piedade virtuosa no lar.',
    ),

    // ==========================================
    // AGOSTO
    // ==========================================
    '08-02': const OpusDeiCelebration(
      name: 'Nossa Senhora dos Anjos (Porciúncula)',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração de Santa Maria dos Anjos e do Perdão da Porciúncula.',
    ),
    '08-04': const OpusDeiCelebration(
      name: 'São João Maria Vianney (Santo Cura de Ars)',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de São João Maria Vianney, modelo e patrono dos sacerdotes e de zelo pastoral no confessionário.',
    ),
    '08-05': const OpusDeiCelebration(
      name: 'Dedicação da Basílica de Santa Maria Maior',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória da dedicação da Basílica de Santa Maria Maior em Roma, o mais antigo templo mariano do Ocidente.',
    ),
    '08-06': const OpusDeiCelebration(
      name: 'Transfiguração do Senhor',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa da Transfiguração de Jesus no Monte Tabor na presença de Pedro, Tiago e João.',
    ),
    '08-09': const OpusDeiCelebration(
      name: 'Santa Teresa Benedita da Cruz (Edith Stein)',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de Santa Teresa Benedita da Cruz, virgem, filósofa, mártir em Auschwitz e padroeira da Europa.',
    ),
    '08-15': const OpusDeiCelebration(
      name:
          'Assunção de Nossa Senhora e Consagração ao Coração de Maria (1951)',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade da Assunção de Maria e aniversário da consagração do Opus Dei ao Santíssimo e Imaculado Coração de Maria no Santuário de Loreto. Renovação solene da consagração.',
    ),
    '08-16': const OpusDeiCelebration(
      name: 'São Roque',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração de São Roque, peregrino da caridade e intercessor em tempos de peste e enfermidade.',
    ),
    '08-21': const OpusDeiCelebration(
      name: 'São Pio X, Papa e Intercessor da Obra',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de São Pio X, Papa da Eucaristia e do Catecismo, nomeado por São Josemaria intercessor para as relações com a Santa Sé.',
    ),
    '08-22': const OpusDeiCelebration(
      name: 'Nossa Senhora Rainha',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória da realeza de Maria Santíssima, coroada no Céu como Rainha do universo ao lado de seu Divino Filho.',
    ),
    '08-23': const OpusDeiCelebration(
      name: 'Anúncio da Intenção de Ereção da Prelatura (1982)',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração do anúncio oficial emitido pela Sala de Imprensa da Santa Sé sobre a decisão do Papa São João Paulo II de erigir o Opus Dei em Prelazia Pessoal.',
    ),
    '08-24': const OpusDeiCelebration(
      name: 'São Bartolomeu, Apóstolo',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de São Bartolomeu (Natanael), apóstolo do Senhor.',
    ),

    // ==========================================
    // SETEMBRO
    // ==========================================
    '09-07': const OpusDeiCelebration(
      name: 'Petição de Admissão de São Josemaria no Seminário (1918)',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração do aniversário da petição de admissão do jovem Josemaria no Seminário Conciliar de Saragoça.',
    ),
    '09-08': const OpusDeiCelebration(
      name: 'Natividade da Bem-Aventurada Virgem Maria',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa da Natividade de Nossa Senhora, aurora da salvação e estrela da manhã que precede a vinda do Redentor.',
    ),
    '09-12': const OpusDeiCelebration(
      name: 'Santíssimo Nome de Maria',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória do dulcíssimo Nome de Maria, escudo de proteção e esperança dos cristãos.',
    ),
    '09-14': const OpusDeiCelebration(
      name: 'Exaltação da Santa Cruz',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa da Exaltação da Santa Cruz e veneração solene do Lignum Crucis nos oratórios da Obra. Canto do Te Deum.',
    ),
    '09-15': const OpusDeiCelebration(
      name: 'Nossa Senhora das Dores e Eleição do Beato Álvaro (1975)',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de Nossa Senhora das Dores e aniversário da eleição unânime do Beato Álvaro del Portillo como primeiro sucessor de São Josemaria.',
    ),
    '09-21': const OpusDeiCelebration(
      name: 'São Mateus, Apóstolo e Evangelista',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de São Mateus Apóstolo, patrono particular dos assuntos econômicos e da administração dos centros da Obra.',
    ),
    '09-24': const OpusDeiCelebration(
      name: 'Nossa Senhora das Mercês',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração de Nossa Senhora das Mercês, invocada para a redenção dos cativos e liberdade da Igreja.',
    ),
    '09-29': const OpusDeiCelebration(
      name: 'Santos Arcanjos Miguel, Gabriel e Rafael, Patronos da Obra',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa dos três Santos Arcanjos, patronos dos três apostolados da Obra: São Miguel (celibato apostólico), São Gabriel (supernumerários e cooperadores) e São Rafael (juventude). Canto do Te Deum.',
    ),

    // ==========================================
    // OUTUBRO
    // ==========================================
    '10-02': const OpusDeiCelebration(
      name: 'Fundação do Opus Dei (1928) e Santos Anjos da Guarda',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade da fundação do Opus Dei por inspiração divina recebida por São Josemaria em Madrid, no dia dos Santos Anjos da Guarda. Canto solene do Te Deum.',
    ),
    '10-04': const OpusDeiCelebration(
      name: 'São Francisco de Assis (Obra de São Rafael)',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de São Francisco de Assis, arauto do Evangelho e intercessor dos trabalhos apostólicos da Obra de São Rafael.',
    ),
    '10-06': const OpusDeiCelebration(
      name: 'Aniversário da Canonização de São Josemaria (2002)',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade do aniversário da proclamação solene de São Josemaria como Santo da Igreja por São João Paulo II na Praça de São Pedro. Bênção com a santa relíquia.',
    ),
    '10-07': const OpusDeiCelebration(
      name: 'Nossa Senhora do Rosário',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de Nossa Senhora do Rosário, poderosa arma espiritual de oração e contemplação de Cristo com os olhos de Maria.',
    ),
    '10-11': const OpusDeiCelebration(
      name: 'Aprovação do Nome "Sociedade Sacerdotal da Santa Cruz" (1943)',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração da aprovação pontifícia do nome da Sociedade Sacerdotal da Santa Cruz (Approbatio nominis) por Pio XII.',
    ),
    '10-12': const OpusDeiCelebration(
      name: 'Nossa Senhora do Pilar',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração de Nossa Senhora do Pilar em Saragoça, aos pés de cuja imagem São Josemaria rezava todos os dias na sua juventude: "Domine, ut videam!".',
    ),
    '10-18': const OpusDeiCelebration(
      name: 'São Lucas, Evangelista',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de São Lucas Evangelista, médico e pintor, historiador da infância de Jesus e dos Atos dos Apóstolos.',
    ),
    '10-22': const OpusDeiCelebration(
      name: 'São João Paulo II, Papa',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de São João Paulo II, Sumo Pontífice que erigiu o Opus Dei em Prelazia Pessoal (1982) e beatificou e canonizou São Josemaria.',
    ),
    '10-24': const OpusDeiCelebration(
      name: 'Festa da Família (Obra de São Rafael)',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração dedicada às famílias dos rapazes e moças que participam nas atividades de formação cristã da juventude.',
    ),
    '10-27': const OpusDeiCelebration(
      name: 'Aniversário do Padre (Mons. Fernando Ocáriz, 1944)',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa do aniversário natalício do Prelado do Opus Dei, Mons. Fernando Ocáriz. Oração filial e canto do Te Deum.',
    ),
    '10-28': const OpusDeiCelebration(
      name: 'Santos Simão e Judas Tadeu, Apóstolos',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa dos Santos Apóstolos Simão e Judas Tadeu, mártires e intercessores.',
    ),

    // ==========================================
    // NOVEMBRO
    // ==========================================
    '11-01': const OpusDeiCelebration(
      name: 'Solenidade de Todos os Santos',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa de Todos os Santos no calendário litúrgico da Prelazia. Celebração do chamado universal à santidade. Canto do Te Deum.',
    ),
    '11-08': const OpusDeiCelebration(
      name: 'São Severino e Relíquias dos Santos nos Oratórios',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa de São Severino mártir e de todas as relíquias de santos preservadas e veneradas nos oratórios dos centros da Prelazia.',
    ),
    '11-09': const OpusDeiCelebration(
      name: 'Dedicação da Basílica de São João de Latrão',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa da dedicação da catedral de Roma, "Mãe e Cabeça de todas as igrejas da Cidade e do Mundo".',
    ),
    '11-21': const OpusDeiCelebration(
      name: 'Apresentação de Nossa Senhora',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória da consagração total e perpétua da Virgem Maria a Deus no Templo de Jerusalém.',
    ),
    '11-27': const OpusDeiCelebration(
      name: 'Nossa Senhora da Medalha Milagrosa',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração da aparição de Nossa Senhora a Santa Catarina Labouré com a revelação da Medalha Milagrosa.',
    ),
    '11-28': const OpusDeiCelebration(
      name: 'Ereção do Opus Dei como Prelazia Pessoal (1982)',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade da publicação da Constituição Apostólica "Ut Sit", pela qual São João Paulo II erigiu o Opus Dei em Prelazia Pessoal internacional. Canto solene do Te Deum.',
    ),
    '11-30': const OpusDeiCelebration(
      name: 'Santo André, Apóstolo',
      classRank: OpusDeiClass.classeC,
      description:
          'Festa de Santo André Apóstolo, o primeiro a seguir o convite de Cristo e conduzir seu irmão Pedro até Ele.',
    ),

    // ==========================================
    // DEZEMBRO
    // ==========================================
    '12-06': const OpusDeiCelebration(
      name: 'São Nicolau de Mira, bispo e intercessor',
      classRank: OpusDeiClass.classeC,
      description:
          'Memória de São Nicolau de Mira, intercessor tradicional na Obra para providência temporal e necessidades materiais.',
    ),
    '12-08': const OpusDeiCelebration(
      name: 'Imaculada Conceição da Bem-Aventurada Virgem Maria',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade da Imaculada Conceição de Maria, padroeira principal de Espanha e objeto de singular amor e pureza no Opus Dei.',
    ),
    '12-10': const OpusDeiCelebration(
      name: 'Nossa Senhora de Loreto',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração da Santa Casa de Loreto, santuário onde São Josemaria consagrou a Obra ao Imaculado Coração de Maria em 1951.',
    ),
    '12-12': const OpusDeiCelebration(
      name: 'Nossa Senhora de Guadalupe',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração de Nossa Senhora de Guadalupe, Padroeira das Américas. Recordação da novena de São Josemaria na Villa de Guadalupe em 1970.',
    ),
    '12-25': const OpusDeiCelebration(
      name: 'Natal de Nosso Senhor Jesus Cristo',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade do Nascimento do Salvador do Mundo no presépio de Belém.',
    ),
    '12-27': const OpusDeiCelebration(
      name: 'São João, Apóstolo e Evangelista (Patrono de São Gabriel)',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa de São João Apóstolo e Evangelista, o discípulo amado, patrono do apostolado com as pessoas casadas (Obra de São Gabriel). Bênção com o Santíssimo Sacramento.',
    ),
    '12-28': const OpusDeiCelebration(
      name: 'Santos Inocentes, mártires',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa dos Santos Meninos Inocentes, mártires que confessaram a Cristo não com palavras, mas com o próprio sangue.',
    ),
    '12-31': const OpusDeiCelebration(
      name: 'Encerramento do Ano Civil (Ação de Graças)',
      classRank: OpusDeiClass.classeD,
      description:
          'Comemoração do último dia do ano civil, com canto solene do Te Deum em ação de graças por todos os benefícios recebidos de Deus.',
    ),
  };

  /// Obtém a celebração do Opus Dei para um mês e dia específicos,
  /// considerando também as celebrações móveis canônicas da Prelazia.
  static OpusDeiCelebration? getCelebration(
    int month,
    int day, {
    DateTime? date,
    DateTime? easter,
    DateTime? baptism,
    DateTime? christTheKing,
    DateTime? holyFamily,
  }) {
    if (date != null && easter != null) {
      final movable = _getMovableCelebration(
        date,
        easter: easter,
        baptism: baptism,
        christTheKing: christTheKing,
        holyFamily: holyFamily,
      );
      if (movable != null) return movable;
    }

    final key =
        '${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    return celebrations[key];
  }

  static OpusDeiCelebration? _getMovableCelebration(
    DateTime date, {
    required DateTime easter,
    DateTime? baptism,
    DateTime? christTheKing,
    DateTime? holyFamily,
  }) {
    final d = DateTime(date.year, date.month, date.day);

    // 1. Batismo do Senhor (Classe C)
    if (baptism != null &&
        d.isAtSameMomentAs(DateTime(baptism.year, baptism.month, baptism.day))) {
      return const OpusDeiCelebration(
        name: 'Batismo do Senhor',
        classRank: OpusDeiClass.classeC,
        description:
            'Festa do Batismo de Jesus no Jordão por São João Batista, conclusão do Tempo do Natal.',
      );
    }

    // 2. Sexta-feira da V Semana da Quaresma / Santa Maria da Paz (Classe C)
    final friday5thLent = DateTime(easter.year, easter.month, easter.day - 9);
    if (d.isAtSameMomentAs(friday5thLent)) {
      return const OpusDeiCelebration(
        name: 'Sexta-feira da V Semana da Quaresma / Santa Maria da Paz',
        classRank: OpusDeiClass.classeC,
        description:
            'Comemoração de Nossa Senhora da Paz e contemplação das dores da Virgem Maria junto à Cruz.',
      );
    }

    // 3. Domingo de Ramos (Classe B)
    final palmSunday = DateTime(easter.year, easter.month, easter.day - 7);
    if (d.isAtSameMomentAs(palmSunday)) {
      return const OpusDeiCelebration(
        name: 'Domingo de Ramos e da Paixão do Senhor',
        classRank: OpusDeiClass.classeB,
        description:
            'Festa da entrada messiânica de Jesus em Jerusalém e início da Semana Santa.',
      );
    }

    // 4. Quinta-feira Santa (Classe A)
    final holyThursday = DateTime(easter.year, easter.month, easter.day - 3);
    if (d.isAtSameMomentAs(holyThursday)) {
      return const OpusDeiCelebration(
        name: 'Quinta-feira Santa na Ceia do Senhor',
        classRank: OpusDeiClass.classeA,
        description:
            'Solenidade da instituição da Sagrada Eucaristia, do Sacerdócio Católico e do Mandamento Novo do Amor.',
      );
    }

    // 5. Domingo da Páscoa (Classe A)
    final easterSunday = DateTime(easter.year, easter.month, easter.day);
    if (d.isAtSameMomentAs(easterSunday)) {
      return const OpusDeiCelebration(
        name: 'Domingo da Páscoa na Ressurreição do Senhor',
        classRank: OpusDeiClass.classeA,
        description:
            'Solenidade das solenidades: a gloriosa Ressurreição de Jesus Cristo, vitória sobre o pecado e a morte.',
      );
    }

    // 6. Ascensão do Senhor (Classe A)
    final ascensionThursday =
        DateTime(easter.year, easter.month, easter.day + 39);
    final ascensionSunday =
        DateTime(easter.year, easter.month, easter.day + 42);
    if (d.isAtSameMomentAs(ascensionThursday) ||
        d.isAtSameMomentAs(ascensionSunday)) {
      return const OpusDeiCelebration(
        name: 'Ascensão do Senhor',
        classRank: OpusDeiClass.classeA,
        description:
            'Solenidade da subida triunfante de Jesus Cristo aos Céus na presença de seus discípulos.',
      );
    }

    // 7. Domingo de Pentecostes (Classe A, Cand)
    final pentecost = DateTime(easter.year, easter.month, easter.day + 49);
    if (d.isAtSameMomentAs(pentecost)) {
      return const OpusDeiCelebration(
        name: 'Domingo de Pentecostes',
        classRank: OpusDeiClass.classeA,
        description:
            'Solenidade da descida do Espírito Santo sobre os Apóstolos reunidos com a Virgem Maria no Cenáculo. Renovação da consagração.',
      );
    }

    // 8. Maria, Mãe da Igreja (Classe C)
    final maryMother = DateTime(easter.year, easter.month, easter.day + 50);
    if (d.isAtSameMomentAs(maryMother)) {
      return const OpusDeiCelebration(
        name: 'Bem-Aventurada Virgem Maria, Mãe da Igreja',
        classRank: OpusDeiClass.classeC,
        description:
            'Memória de Maria Santíssima como Mãe de toda a Igreja e da família dos filhos de Deus.',
      );
    }

    // 9. Santíssima Trindade (Classe A, +Rel)
    final trinity = DateTime(easter.year, easter.month, easter.day + 56);
    if (d.isAtSameMomentAs(trinity)) {
      return const OpusDeiCelebration(
        name: 'Santíssima Trindade',
        classRank: OpusDeiClass.classeA,
        description:
            'Solenidade de Deus Uno e Trino: Pai, Filho e Espírito Santo, mistério central da fé católica. Bênção com a santa relíquia.',
      );
    }

    // 10. Corpus Christi (Classe A)
    final corpus = DateTime(easter.year, easter.month, easter.day + 60);
    if (d.isAtSameMomentAs(corpus)) {
      return const OpusDeiCelebration(
        name: 'Santíssimo Corpo e Sangue de Cristo (Corpus Christi)',
        classRank: OpusDeiClass.classeA,
        description:
            'Solenidade do Sacramento do Amor. Louvor e ação de graças pela presença real de Jesus na Sagrada Eucaristia.',
      );
    }

    // 11. Sagrado Coração de Jesus (Classe A, Litania)
    final sacredHeart = DateTime(easter.year, easter.month, easter.day + 68);
    if (d.isAtSameMomentAs(sacredHeart)) {
      return const OpusDeiCelebration(
        name: 'Sagrado Coração de Jesus',
        classRank: OpusDeiClass.classeA,
        description:
            'Solenidade do Coração de Jesus, fornalha ardente de caridade e misericórdia infinita. Recitação das Ladainhas do Sagrado Coração.',
      );
    }

    // 12. Imaculado Coração de Maria (Classe C)
    final immaculateHeart =
        DateTime(easter.year, easter.month, easter.day + 69);
    if (d.isAtSameMomentAs(immaculateHeart)) {
      return const OpusDeiCelebration(
        name: 'Imaculado Coração da Bem-Aventurada Virgem Maria',
        classRank: OpusDeiClass.classeC,
        description:
            'Memória do Imaculado Coração de Maria, modelo de contemplação fiel e pureza de vida.',
      );
    }

    // 13. Cristo Rei (Classe A, Cand)
    if (christTheKing != null &&
        d.isAtSameMomentAs(DateTime(
          christTheKing.year,
          christTheKing.month,
          christTheKing.day,
        ))) {
      return const OpusDeiCelebration(
        name: 'Nosso Senhor Jesus Cristo, Rei do Universo',
        classRank: OpusDeiClass.classeA,
        description:
            'Solenidade de Cristo Rei. Renovação solene da consagração do Opus Dei ao Sagrado Coração de Jesus.',
      );
    }

    // 14. Sagrada Família (Classe A, Cand)
    if (holyFamily != null &&
        d.isAtSameMomentAs(DateTime(
          holyFamily.year,
          holyFamily.month,
          holyFamily.day,
        ))) {
      return const OpusDeiCelebration(
        name: 'Sagrada Família de Jesus, Maria e José',
        classRank: OpusDeiClass.classeA,
        description:
            'Solenidade da Sagrada Família de Nazaré, modelo supremo de todas as famílias e dos lares cristãos. Renovação da consagração.',
      );
    }

    return null;
  }

  /// Retorna o aviso da novena tradicional em andamento se aplicável.
  static String? getNovenaNotice(DateTime date) {
    // 1. Sete Domingos de São José (7 domingos antes de 19 de Março)
    final year = date.year;
    final sundays = <DateTime>[];
    var cursor = DateTime(year, 3, 18);
    while (sundays.length < 7) {
      if (cursor.weekday == DateTime.sunday) {
        sundays.insert(0, DateTime(cursor.year, cursor.month, cursor.day));
      }
      cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
    }

    final dateOnly = DateTime(date.year, date.month, date.day);
    for (int i = 0; i < sundays.length; i++) {
      if (dateOnly == sundays[i]) {
        return '${i + 1}º Domingo de São José (Dores e Alegrias)';
      }
    }

    // 2. Novena da Imaculada Conceição (29 de Novembro a 7 de Dezembro)
    if (date.month == 11 && date.day >= 29) {
      final dayNum = date.day - 28; // 29 -> 1, 30 -> 2
      return 'Novena da Imaculada Conceição (Dia $dayNum)';
    } else if (date.month == 12 && date.day <= 7) {
      final dayNum = date.day + 2; // 1 -> 3, 7 -> 9
      return 'Novena da Imaculada Conceição (Dia $dayNum)';
    }

    return null;
  }
}
