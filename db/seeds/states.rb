country = Spree::Country.find_by(name: 'Malaysia')

Spree::State.create!([
  { name: 'Federal Territory of Kuala Lumpur', abbr: 'KUL', country: country },
  { name: 'Federal Territory of Labuan', abbr: 'LBN', country: country },
  { name: 'Federal Territory of Putrajaya', abbr: 'PJY', country: country },
  
  { name: 'Johor', abbr: 'JHR', country: country },
  { name: 'Kedah', abbr: 'KDH', country: country },
  { name: 'Kelantan', abbr: 'KTN', country: country },
  { name: 'Malacca', abbr: 'MLK', country: country },
  { name: 'Negeri Sembilan', abbr: 'NSN', country: country },
  { name: 'Pahang', abbr: 'PHG', country: country },
  { name: 'Perak', abbr: 'PRK', country: country },
  { name: 'Perlis', abbr: 'PLS', country: country },
  { name: 'Penang', abbr: 'PNG', country: country },
  { name: 'Sabah', abbr: 'SBH', country: country },
  { name: 'Sarawak', abbr: 'SWK', country: country },
  { name: 'Selangor', abbr: 'SGR', country: country },
  { name: 'Terengganu', abbr: 'TRG', country: country }
])
  
 