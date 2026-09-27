import 'gregorian_score.dart';

/// Dados musicais das pautas gregorianas dos 4 cantos da cerimônia
/// de Adoração e Bênção com o Santíssimo Sacramento.

/// 1. Pange Lingua (Modo III - 1ª Estrofe)
final List<GregorianStaffLine> pangeLinguaChantLines = [
  // Linha 1: Pange lingua gloriosi Corporis mysterium,
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("-ange,", [GregorianNeume(0)]),
      const GregorianSyllable("lin-", [GregorianNeume(2)]),
      const GregorianSyllable("-gua,", [GregorianNeume(0)]),
      const GregorianSyllable("glo-", [GregorianNeume(0)]),
      const GregorianSyllable("-ri-", [GregorianNeume(-1)]),
      const GregorianSyllable("-ó-", [GregorianNeume(0), GregorianNeume(2)]),
      const GregorianSyllable("-si", [
        GregorianNeume(-1, hasDot: true),
      ], hasAsterisk: true),
      const GregorianSyllable("Cór-", [GregorianNeume(2)]),
      const GregorianSyllable("-po-", [GregorianNeume(0)]),
      const GregorianSyllable("-ris", [GregorianNeume(2)]),
      const GregorianSyllable("mys-", [GregorianNeume(4)]),
      const GregorianSyllable("-té-", [GregorianNeume(4), GregorianNeume(2)]),
      const GregorianSyllable("-ri-", [GregorianNeume(0)]),
      const GregorianSyllable("-um,", [
        GregorianNeume(2),
        GregorianNeume(0, isDiamond: true),
      ]),
      const GregorianBarLine(GregorianBarType.minor),
    ],
  ),
  // Linha 2: Sanguinisque pretiosi, quem in mundi pretium fructus
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("San-", [GregorianNeume(2)]),
      const GregorianSyllable("-gui-", [GregorianNeume(2)]),
      const GregorianSyllable("-nís-", [GregorianNeume(2)]),
      const GregorianSyllable("-que", [GregorianNeume(2)]),
      const GregorianSyllable("pre-", [GregorianNeume(2)]),
      const GregorianSyllable("-ti-", [GregorianNeume(4)]),
      const GregorianSyllable("-ó-", [GregorianNeume(2)]),
      const GregorianSyllable("-si,", [GregorianNeume(0, hasDot: true)]),
      const GregorianBarLine(GregorianBarType.minima),
      const GregorianSyllable("quem", [GregorianNeume(0)]),
      const GregorianSyllable("in", [GregorianNeume(2)]),
      const GregorianSyllable("mun-", [GregorianNeume(4)]),
      const GregorianSyllable("-di", [GregorianNeume(2)]),
      const GregorianSyllable("pré-", [GregorianNeume(4)]),
      const GregorianSyllable("-ti-", [GregorianNeume(6), GregorianNeume(4)]),
      const GregorianSyllable("-um", [GregorianNeume(2, hasDot: true)]),
      const GregorianBarLine(GregorianBarType.minor),
      const GregorianSyllable("fruc-", [GregorianNeume(2)]),
      const GregorianSyllable("-tus", [GregorianNeume(4)]),
    ],
  ),
  // Linha 3: ventris generosi Rex effudit gentium.
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("ven-", [GregorianNeume(2)]),
      const GregorianSyllable("-tris", [GregorianNeume(0)]),
      const GregorianSyllable("ge-", [GregorianNeume(-1)]),
      const GregorianSyllable("-ne-", [GregorianNeume(0)]),
      const GregorianSyllable("-ró-", [GregorianNeume(2)]),
      const GregorianSyllable("-si", [GregorianNeume(0)]),
      const GregorianBarLine(GregorianBarType.minima),
      const GregorianSyllable("Rex", [GregorianNeume(2)]),
      const GregorianSyllable("ef-", [GregorianNeume(2), GregorianNeume(4)]),
      const GregorianSyllable("-fú-", [GregorianNeume(4), GregorianNeume(2)]),
      const GregorianSyllable("-dit", [GregorianNeume(0)]),
      const GregorianSyllable("gén-", [
        GregorianNeume(0),
        GregorianNeume(2),
        GregorianNeume(0, isDiamond: true),
        GregorianNeume(-1, isDiamond: true),
      ]),
      const GregorianSyllable("-ti-", [GregorianNeume(-1)]),
      const GregorianSyllable("-um.", [GregorianNeume(-1, hasDot: true)]),
      const GregorianBarLine(GregorianBarType.finalis),
    ],
  ),
];

/// 5. Tantum Ergo (Modo III - Estrofes 5 e 6 com Amen)
final List<GregorianStaffLine> tantumErgoChantLines = [
  // Linha 1: Tantum ergo Sacramentum veneremur cernui:
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("-antum", [GregorianNeume(0)]),
      const GregorianSyllable("er-", [GregorianNeume(2)]),
      const GregorianSyllable("-go", [GregorianNeume(0)]),
      const GregorianSyllable("Sa-", [GregorianNeume(0)]),
      const GregorianSyllable("-cra-", [GregorianNeume(-1)]),
      const GregorianSyllable("-mén-", [GregorianNeume(0), GregorianNeume(2)]),
      const GregorianSyllable("-tum", [GregorianNeume(-1, hasDot: true)]),
      const GregorianSyllable("ve-", [GregorianNeume(2)]),
      const GregorianSyllable("-ne-", [GregorianNeume(0)]),
      const GregorianSyllable("-ré-", [GregorianNeume(2)]),
      const GregorianSyllable("-mur", [GregorianNeume(4)]),
      const GregorianSyllable("cér-", [GregorianNeume(4), GregorianNeume(2)]),
      const GregorianSyllable("-nu-", [GregorianNeume(0)]),
      const GregorianSyllable("-i:", [
        GregorianNeume(2),
        GregorianNeume(0, isDiamond: true),
      ]),
      const GregorianBarLine(GregorianBarType.minor),
    ],
  ),
  // Linha 2: et antiquum documentum novo cedat ritui; praestet
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("et", [GregorianNeume(2)]),
      const GregorianSyllable("an-", [GregorianNeume(2)]),
      const GregorianSyllable("-tí-", [GregorianNeume(2)]),
      const GregorianSyllable("-quum", [GregorianNeume(2)]),
      const GregorianSyllable("do-", [GregorianNeume(2)]),
      const GregorianSyllable("-cu-", [GregorianNeume(4)]),
      const GregorianSyllable("-mén-", [GregorianNeume(2)]),
      const GregorianSyllable("-tum", [GregorianNeume(0, hasDot: true)]),
      const GregorianBarLine(GregorianBarType.minima),
      const GregorianSyllable("no-", [GregorianNeume(0)]),
      const GregorianSyllable("-vo", [GregorianNeume(2)]),
      const GregorianSyllable("ce-", [GregorianNeume(4)]),
      const GregorianSyllable("-dat", [GregorianNeume(2)]),
      const GregorianSyllable("rí-", [GregorianNeume(4)]),
      const GregorianSyllable("-tu-", [GregorianNeume(6), GregorianNeume(4)]),
      const GregorianSyllable("-i;", [GregorianNeume(2, hasDot: true)]),
      const GregorianBarLine(GregorianBarType.minor),
      const GregorianSyllable("præ-", [GregorianNeume(2)]),
      const GregorianSyllable("-stet", [GregorianNeume(4)]),
    ],
  ),
  // Linha 3: fides supplementum sensuum defectui.
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("fi-", [GregorianNeume(2)]),
      const GregorianSyllable("-des", [GregorianNeume(0)]),
      const GregorianSyllable("sup-", [GregorianNeume(-1)]),
      const GregorianSyllable("-ple-", [GregorianNeume(0)]),
      const GregorianSyllable("-mén-", [GregorianNeume(2)]),
      const GregorianSyllable("-tum", [GregorianNeume(0)]),
      const GregorianBarLine(GregorianBarType.minima),
      const GregorianSyllable("sén-", [GregorianNeume(2)]),
      const GregorianSyllable("-su-", [GregorianNeume(2), GregorianNeume(4)]),
      const GregorianSyllable("-um", [GregorianNeume(4), GregorianNeume(2)]),
      const GregorianSyllable("de-", [GregorianNeume(0)]),
      const GregorianSyllable("féc-", [
        GregorianNeume(0),
        GregorianNeume(2),
        GregorianNeume(0, isDiamond: true),
        GregorianNeume(-1, isDiamond: true),
      ]),
      const GregorianSyllable("-tu-", [GregorianNeume(-1)]),
      const GregorianSyllable("-i.", [GregorianNeume(-1, hasDot: true)]),
      const GregorianBarLine(GregorianBarType.maior),
    ],
  ),
  // Linha 4: Genitori, Genitoque laus et iubilatio, salus, honor, virtus quoque
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("Ge-", [GregorianNeume(0)]),
      const GregorianSyllable("-ni-", [GregorianNeume(0)]),
      const GregorianSyllable("-tó-", [GregorianNeume(2)]),
      const GregorianSyllable("-ri,", [GregorianNeume(0)]),
      const GregorianSyllable("Ge-", [GregorianNeume(0)]),
      const GregorianSyllable("-ni-", [GregorianNeume(-1)]),
      const GregorianSyllable("-tó-", [GregorianNeume(0), GregorianNeume(2)]),
      const GregorianSyllable("-que", [GregorianNeume(-1, hasDot: true)]),
      const GregorianSyllable("laus", [GregorianNeume(2)]),
      const GregorianSyllable("et", [GregorianNeume(0)]),
      const GregorianSyllable("iu-", [GregorianNeume(2)]),
      const GregorianSyllable("-bi-", [GregorianNeume(4)]),
      const GregorianSyllable("-lá-", [GregorianNeume(4), GregorianNeume(2)]),
      const GregorianSyllable("-ti-", [GregorianNeume(0)]),
      const GregorianSyllable("-o,", [
        GregorianNeume(2),
        GregorianNeume(0, isDiamond: true),
      ]),
      const GregorianBarLine(GregorianBarType.minor),
      const GregorianSyllable("sa-", [GregorianNeume(2)]),
      const GregorianSyllable("-lus,", [GregorianNeume(2)]),
      const GregorianSyllable("ho-", [GregorianNeume(2)]),
      const GregorianSyllable("-nor,", [GregorianNeume(2)]),
      const GregorianSyllable("vir-", [GregorianNeume(2)]),
      const GregorianSyllable("-tus", [GregorianNeume(4)]),
      const GregorianSyllable("quo-", [GregorianNeume(2)]),
      const GregorianSyllable("-que", [GregorianNeume(0, hasDot: true)]),
      const GregorianBarLine(GregorianBarType.minima),
    ],
  ),
  // Linha 5: sit et benedictio: procedenti ab utroque compar sit laudatio. Amen.
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("sit", [GregorianNeume(0)]),
      const GregorianSyllable("et", [GregorianNeume(2)]),
      const GregorianSyllable("be-", [GregorianNeume(4)]),
      const GregorianSyllable("-ne-", [GregorianNeume(2)]),
      const GregorianSyllable("-díc-", [GregorianNeume(4)]),
      const GregorianSyllable("-ti-", [GregorianNeume(6), GregorianNeume(4)]),
      const GregorianSyllable("-o:", [GregorianNeume(2, hasDot: true)]),
      const GregorianBarLine(GregorianBarType.minor),
      const GregorianSyllable("pro-", [GregorianNeume(2)]),
      const GregorianSyllable("-ce-", [GregorianNeume(4)]),
      const GregorianSyllable("-dén-", [GregorianNeume(2)]),
      const GregorianSyllable("-ti", [GregorianNeume(0)]),
      const GregorianSyllable("ab", [GregorianNeume(-1)]),
      const GregorianSyllable("u-", [GregorianNeume(0)]),
      const GregorianSyllable("-tró-", [GregorianNeume(2)]),
      const GregorianSyllable("-que", [GregorianNeume(0)]),
      const GregorianBarLine(GregorianBarType.minima),
      const GregorianSyllable("com-", [GregorianNeume(2)]),
      const GregorianSyllable("-par", [GregorianNeume(2), GregorianNeume(4)]),
      const GregorianSyllable("sit", [GregorianNeume(4), GregorianNeume(2)]),
      const GregorianSyllable("lau-", [GregorianNeume(0)]),
      const GregorianSyllable("-dá-", [
        GregorianNeume(0),
        GregorianNeume(2),
        GregorianNeume(0, isDiamond: true),
        GregorianNeume(-1, isDiamond: true),
      ]),
      const GregorianSyllable("-ti-", [GregorianNeume(-1)]),
      const GregorianSyllable("-o.", [GregorianNeume(-1, hasDot: true)]),
      const GregorianSyllable("A-", [GregorianNeume(0), GregorianNeume(2)]),
      const GregorianSyllable("-men.", [GregorianNeume(-1, hasDot: true)]),
      const GregorianBarLine(GregorianBarType.finalis),
    ],
  ),
];

/// 9. Laudate Dominum (Tom V - Salmo 116)
final List<GregorianStaffLine> laudateDominumChantLines = [
  // Linha 1: Laudate Dominum omnes gentes: * laudate eum
  GregorianStaffLine(
    clefLine: 3,
    elements: [
      const GregorianSyllable("-u-dá-te", [
        GregorianNeume(0),
        GregorianNeume(2),
      ]),
      const GregorianSyllable("Dó-", [GregorianNeume(4)]),
      const GregorianSyllable("-mi-", [GregorianNeume(4)]),
      const GregorianSyllable("-num", [GregorianNeume(4)]),
      const GregorianSyllable("omnes", [GregorianNeume(4), GregorianNeume(4)]),
      const GregorianSyllable("gentes:", [
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
      ], hasAsterisk: true),
      const GregorianSyllable("lau-dá-te", [
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("e-um", [GregorianNeume(4), GregorianNeume(4)]),
    ],
  ),
  // Linha 2: omnes populi. || Quoniam confirmata est super nos mi-se-
  GregorianStaffLine(
    clefLine: 3,
    elements: [
      const GregorianSyllable("omnes", [GregorianNeume(2), GregorianNeume(0)]),
      const GregorianSyllable("pópu-li.", [
        GregorianNeume(0, isFlat: true),
        GregorianNeume(-1),
        GregorianNeume(-1, hasDot: true),
      ]),
      const GregorianBarLine(GregorianBarType.finalis),
      const GregorianSyllable("Quó-ni-am", [
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("con-fir-má-ta", [
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("est", [GregorianNeume(4)]),
      const GregorianSyllable("super", [GregorianNeume(4), GregorianNeume(4)]),
      const GregorianSyllable("nos", [GregorianNeume(4)]),
      const GregorianSyllable("mi-se-", [GregorianNeume(4), GregorianNeume(4)]),
    ],
  ),
  // Linha 3: ricordia eius: * et veritas Domini manet in aeternum.
  GregorianStaffLine(
    clefLine: 3,
    elements: [
      const GregorianSyllable("ri-cór-di-a", [
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("e-ius:", [
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
      ], hasAsterisk: true),
      const GregorianSyllable("et", [GregorianNeume(4)]),
      const GregorianSyllable("vé-ri-tas", [
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("Dó-mi-ni", [
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("ma-net", [GregorianNeume(4), GregorianNeume(4)]),
      const GregorianSyllable("in", [GregorianNeume(2)]),
      const GregorianSyllable("æ-tér-num.", [
        GregorianNeume(0, isFlat: true),
        GregorianNeume(-1),
        GregorianNeume(-1, hasDot: true),
      ]),
      const GregorianBarLine(GregorianBarType.maior),
    ],
  ),
  // Linha 4: Gloria Patri, et Filio, * et Spiritui Sancto. || Sicut erat in
  GregorianStaffLine(
    clefLine: 3,
    elements: [
      const GregorianSyllable("Gló-ri-a", [
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("Patri,", [GregorianNeume(4), GregorianNeume(4)]),
      const GregorianSyllable("et", [GregorianNeume(4)]),
      const GregorianSyllable("Fí-li-o,", [
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
      ], hasAsterisk: true),
      const GregorianSyllable("et", [GregorianNeume(4)]),
      const GregorianSyllable("Spi-rí-tu-i", [
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("Sancto.", [
        GregorianNeume(2),
        GregorianNeume(0, isFlat: true),
        GregorianNeume(-1),
        GregorianNeume(-1, hasDot: true),
      ]),
      const GregorianBarLine(GregorianBarType.finalis),
      const GregorianSyllable("Sicut", [GregorianNeume(4), GregorianNeume(4)]),
      const GregorianSyllable("erat", [GregorianNeume(4), GregorianNeume(4)]),
      const GregorianSyllable("in", [GregorianNeume(4)]),
    ],
  ),
  // Linha 5: principio, et nunc, et semper, * et in saecula saeculorum. Amen.
  GregorianStaffLine(
    clefLine: 3,
    elements: [
      const GregorianSyllable("prin-cí-pi-o,", [
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("et", [GregorianNeume(4)]),
      const GregorianSyllable("nunc,", [GregorianNeume(4)]),
      const GregorianSyllable("et", [GregorianNeume(4)]),
      const GregorianSyllable("semper,", [
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
      ], hasAsterisk: true),
      const GregorianSyllable("et", [GregorianNeume(4)]),
      const GregorianSyllable("in", [GregorianNeume(4)]),
      const GregorianSyllable("sæ-cu-la", [
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("sæ-cu-ló-rum.", [
        GregorianNeume(4),
        GregorianNeume(4),
        GregorianNeume(2),
        GregorianNeume(0),
      ]),
      const GregorianSyllable("Amen.", [
        GregorianNeume(-1, isFlat: true),
        GregorianNeume(-1, hasDot: true),
      ]),
      const GregorianBarLine(GregorianBarType.finalis),
    ],
  ),
];

/// 10. Salve Regina (Tonus simplex - Modo V)
final List<GregorianStaffLine> salveReginaChantLines = [
  // Linha 1: Salve, Regina, * mater misericordiae; Vita, dulcedo,
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("-alve,", [GregorianNeume(0), GregorianNeume(2)]),
      const GregorianSyllable("Re-gí-na,", [
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
      ], hasAsterisk: true),
      const GregorianSyllable("mater", [GregorianNeume(4), GregorianNeume(2)]),
      const GregorianSyllable("mi-se-ri-cór-di-æ;", [
        GregorianNeume(2),
        GregorianNeume(0),
        GregorianNeume(2),
        GregorianNeume(4),
        GregorianNeume(2),
      ]),
      const GregorianSyllable("Vi-ta,", [GregorianNeume(4), GregorianNeume(2)]),
      const GregorianSyllable("dul-cé-do,", [
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
        GregorianNeume(2),
      ]),
      const GregorianBarLine(GregorianBarType.minima),
    ],
  ),
  // Linha 2: et spes nostra, salve. || Ad te clamamus, exsules, filii Evae.
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("et", [GregorianNeume(2)]),
      const GregorianSyllable("spes", [GregorianNeume(4)]),
      const GregorianSyllable("nostra,", [
        GregorianNeume(2),
        GregorianNeume(0),
      ]),
      const GregorianSyllable("salve.", [
        GregorianNeume(0),
        GregorianNeume(0, hasDot: true),
      ]),
      const GregorianBarLine(GregorianBarType.finalis),
      const GregorianSyllable("Ad", [GregorianNeume(2)]),
      const GregorianSyllable("te", [GregorianNeume(4)]),
      const GregorianSyllable("cla-má-mus,", [
        GregorianNeume(6),
        GregorianNeume(4),
        GregorianNeume(2),
      ]),
      const GregorianSyllable("éx-su-les,", [
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("fí-li-i", [
        GregorianNeume(4),
        GregorianNeume(2),
        GregorianNeume(0),
      ]),
      const GregorianSyllable("Evæ.", [
        GregorianNeume(0),
        GregorianNeume(0, hasDot: true),
      ]),
      const GregorianBarLine(GregorianBarType.maior),
    ],
  ),
  // Linha 3: Ad te suspiramus, gementes et flentes in hac lacrimarum valle.
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("Ad", [GregorianNeume(2)]),
      const GregorianSyllable("te", [GregorianNeume(4)]),
      const GregorianSyllable("sus-pi-rá-mus,", [
        GregorianNeume(6),
        GregorianNeume(4),
        GregorianNeume(2),
        GregorianNeume(0),
      ]),
      const GregorianSyllable("ge-mén-tes", [
        GregorianNeume(2),
        GregorianNeume(4),
        GregorianNeume(6),
      ]),
      const GregorianSyllable("et", [GregorianNeume(4)]),
      const GregorianSyllable("flentes", [
        GregorianNeume(2),
        GregorianNeume(0),
      ]),
      const GregorianSyllable("in", [GregorianNeume(2)]),
      const GregorianSyllable("hac", [GregorianNeume(4)]),
      const GregorianSyllable("la-cri-má-rum", [
        GregorianNeume(6),
        GregorianNeume(4),
        GregorianNeume(2),
        GregorianNeume(0),
      ]),
      const GregorianSyllable("valle.", [
        GregorianNeume(0),
        GregorianNeume(0, hasDot: true),
      ]),
      const GregorianBarLine(GregorianBarType.maior),
    ],
  ),
  // Linha 4: Eia ergo, Advocata nostra, || illos tuos misericordes oculos
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("E-ia", [GregorianNeume(4), GregorianNeume(6)]),
      const GregorianSyllable("ergo,", [GregorianNeume(4), GregorianNeume(2)]),
      const GregorianSyllable("Ad-vo-cá-ta", [
        GregorianNeume(2),
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("nostra,", [
        GregorianNeume(2),
        GregorianNeume(0),
      ]),
      const GregorianBarLine(GregorianBarType.minor),
      const GregorianSyllable("il-los", [GregorianNeume(2), GregorianNeume(4)]),
      const GregorianSyllable("tu-os", [GregorianNeume(6), GregorianNeume(4)]),
      const GregorianSyllable("mi-se-ri-cór-des", [
        GregorianNeume(2),
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
        GregorianNeume(2),
      ]),
      const GregorianSyllable("ó-cu-los", [
        GregorianNeume(0),
        GregorianNeume(2),
        GregorianNeume(0),
      ]),
      const GregorianBarLine(GregorianBarType.minima),
    ],
  ),
  // Linha 5: ad nos converte. || Et Iesum, benedictum fructum ventris tui,
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("ad", [GregorianNeume(2)]),
      const GregorianSyllable("nos", [GregorianNeume(4)]),
      const GregorianSyllable("con-vér-te.", [
        GregorianNeume(6),
        GregorianNeume(4),
        GregorianNeume(2),
        GregorianNeume(0),
      ]),
      const GregorianBarLine(GregorianBarType.finalis),
      const GregorianSyllable("Et", [GregorianNeume(2)]),
      const GregorianSyllable("Ie-sum,", [
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("be-ne-díc-tum", [
        GregorianNeume(2),
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("fruc-tum", [
        GregorianNeume(2),
        GregorianNeume(0),
      ]),
      const GregorianSyllable("ven-tris", [
        GregorianNeume(2),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("tu-i,", [GregorianNeume(2), GregorianNeume(0)]),
      const GregorianBarLine(GregorianBarType.minima),
    ],
  ),
  // Linha 6: nobis post hoc exsilium ostende. || O clemens, O pia, O dulcis * Virgo Maria.
  GregorianStaffLine(
    clefLine: 4,
    elements: [
      const GregorianSyllable("no-bis", [GregorianNeume(2), GregorianNeume(4)]),
      const GregorianSyllable("post", [GregorianNeume(6)]),
      const GregorianSyllable("hoc", [GregorianNeume(4)]),
      const GregorianSyllable("ex-sí-li-um", [
        GregorianNeume(2),
        GregorianNeume(4),
        GregorianNeume(6),
        GregorianNeume(4),
      ]),
      const GregorianSyllable("os-tén-de.", [
        GregorianNeume(2),
        GregorianNeume(0),
        GregorianNeume(0, hasDot: true),
      ]),
      const GregorianBarLine(GregorianBarType.maior),
      const GregorianSyllable("O", [GregorianNeume(6), GregorianNeume(4)]),
      const GregorianSyllable("clemens,", [
        GregorianNeume(2),
        GregorianNeume(0),
      ]),
      const GregorianSyllable("O", [GregorianNeume(4), GregorianNeume(6)]),
      const GregorianSyllable("pi - a,", [
        GregorianNeume(4),
        GregorianNeume(2),
      ]),
      const GregorianSyllable("O", [GregorianNeume(2)]),
      const GregorianSyllable("dul-cis", [
        GregorianNeume(0),
        GregorianNeume(-1),
      ], hasAsterisk: true),
      const GregorianSyllable("Vir-go", [GregorianNeume(0), GregorianNeume(2)]),
      const GregorianSyllable("Ma-rí-a.", [
        GregorianNeume(4),
        GregorianNeume(2),
        GregorianNeume(0, hasDot: true),
      ]),
      const GregorianBarLine(GregorianBarType.finalis),
    ],
  ),
];
