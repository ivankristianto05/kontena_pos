// addons_data.dart

// addons_data.dart

const Map<String, Map<String, double>> addonsByType = {
  'food': {
    'Extra Cheese': 10000,    // 1.0 * 10,000 = 10,000
    'Extra Sauce': 5000,      // 0.5 * 10,000 = 5,000
    'Extra Spice': 2000,      // 0.2 * 10,000 = 2,000
  },
  'beverage': {
    'Coconut Jelly': 15000,  // 1.5 * 10,000 = 15,000
    'Whipped Cream': 10000,   // 1.0 * 10,000 = 10,000
    'Soy Milk': 12000,        // 1.2 * 10,000 = 12,000
    'Boba': 10000,            // 1.0 * 10,000 = 10,000
    'Chocolate': 8000,        // 0.8 * 10,000 = 8,000
    'Oreo': 10000,            // 1.0 * 10,000 = 10,000
  },
  'breakfast': {
    'Extra Egg': 8000,   // 0.8 * 10,000 = 8,000
    'Bacon': 15000,     // 1.5 * 10,000 = 15,000
    'Sausage': 12000,   // 1.2 * 10,000 = 12,000
  },
};



const Map<String, List<String>> preferencesByType = {
  'food': [
    'original',
    'hot',
    'very hot',
    'no sauce',
    'no MSG',
    'no salt'
  ],
  'beverage': ['less sugar', 'less ice'],
  'breakfast': ['small', 'medium', 'jumbo'],
};
