class VaccineScheduleService {
  static List<Map<String, dynamic>> getVaccinationData() => [
    { 'title': 'Nacimiento', 'children': [{ 'title': 'HepB (1era dosis)', 'yellow': false }]},
    { 'title': '1 mes', 'children': [{ 'title': 'HepB (2da dosis)', 'yellow': true }]},
    { 'title': '2 meses', 'children': [
        { 'title': 'HepB (2da dosis)', 'yellow': true }, 
        { 'title': 'RV (1era dosis)', 'yellow': false },
        { 'title': 'DTaP (1era dosis)', 'yellow': false },
        { 'title': 'Hib (1era dosis)', 'yellow': false },
        { 'title': 'PCV13 (1era dosis)', 'yellow': false },
        { 'title': 'IPV (1era dosis)', 'yellow': false },
      ]
    },
    { 'title': '4 meses', 'children': [
        { 'title': 'RV (2da dosis)', 'yellow': false },
        { 'title': 'DTaP (2da dosis)', 'yellow': false },
        { 'title': 'Hib (2da dosis)', 'yellow': false },
        { 'title': 'PCV13 (2da dosis)', 'yellow': false },
        { 'title': 'IPV (2da dosis)', 'yellow': false },
      ]
    },
    { 'title': '6 meses', 'children': [
        { 'title': 'HepB (3era dosis)', 'yellow': true }, 
        { 'title': 'RV (3era dosis)', 'yellow': false },
        { 'title': 'DTaP (3era dosis)', 'yellow': false },
        { 'title': 'Hib (3era dosis)', 'yellow': false },
        { 'title': 'PCV13 (3era dosis)', 'yellow': false },
        { 'title': 'IPV (3era dosis)', 'yellow': true },
      ]
    },
    { 'title': '12 meses', 'children': [
        { 'title': 'HepB (3era dosis)', 'yellow': true }, 
        { 'title': 'Hib (4ta dosis)', 'yellow': true },
        { 'title': 'PCV13 (4ta dosis)', 'yellow': true },
        { 'title': 'IPV (3era dosis)', 'yellow': true },
        { 'title': 'Influenza (anual)', 'yellow': true },
        { 'title': 'MMR (1era dosis)', 'yellow': true },
        { 'title': 'Varicela (1era dosis)', 'yellow': true },
        { 'title': 'HepA', 'yellow': true },
      ]
    },
    { 'title': '15 meses', 'children': [
        { 'title': 'HepB (3era dosis)', 'yellow': true }, 
        { 'title': 'DTaP (4ta dosis)', 'yellow': true },
        { 'title': 'Hib (4ta dosis)', 'yellow': true },
        { 'title': 'PCV13 (4ta dosis)', 'yellow': true },
        { 'title': 'IPV (3era dosis)', 'yellow': true },
        { 'title': 'Influenza (anual)', 'yellow': true },
        { 'title': 'MMR (1era dosis)', 'yellow': true },
        { 'title': 'Varicela (1era dosis)', 'yellow': true },
        { 'title': 'HepA', 'yellow': true },
      ]
    },
    { 'title': '18 meses', 'children': [
        { 'title': 'HepB (3era dosis)', 'yellow': true }, 
        { 'title': 'DTaP (4ta dosis)', 'yellow': true },
        { 'title': 'IPV (3era dosis)', 'yellow': true },
        { 'title': 'Influenza (anual)', 'yellow': true },
        { 'title': 'HepA', 'yellow': true },
      ]
    },
    { 'title': '19-23 meses', 'children': [
        { 'title': 'Influenza (anual)', 'yellow': true },
        { 'title': 'HepA', 'yellow': true },
      ]
    },
    { 'title': '2-3 años', 'children': [
        { 'title': 'Influenza (anual)', 'yellow': true },
      ]
    },
    { 'title': '4-6 años', 'children': [
        { 'title': 'DTaP (5ta dosis)', 'yellow': false },
        { 'title': 'IPV (4ta dosis)', 'yellow': false },
        { 'title': 'Influenza (anual)', 'yellow': true },
        { 'title': 'MMR (2da dosis)', 'yellow': true },
        { 'title': 'Varicela (2da dosis)', 'yellow': true },
      ]
    },
  ];
}