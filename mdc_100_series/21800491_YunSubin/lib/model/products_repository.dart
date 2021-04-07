// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    const allProducts = <Product> [
      Product(
        category: Category.accessories,
        id: 0,
        isFeatured: true,
        name: 'LondonHouse Chicago',
        place: '85 East Wacker Drive, Chicago, IL 60601, Illinois, United States',
        stars :4,
        detail: 'Welcome to the LondonHouse Chicago, Curio Collection by Hilton, a modern hotel set within the iconic London Guarantee & Accident building in the heart of Chicago.  Find yourself on the iconic Chicago River, on the corner of Wacker Drive and Michigan Avenue, just minutes away from Millennium Park and the citys theater and business districts.  Embodying elegance, outspoken design, and first-class service, the LondonHouse Chicago hotel is one of the citys foremost new hotels.  Each spacious guest room features a 55-inch HDTV, complimentary WiFi, and high-tech design features. All rooms exude modern style and timeless elegance.',
        number: '02 1234 12010',
      ),
      Product(
        category: Category.accessories,
        id: 1,
        isFeatured: true,
        name: 'Aurico Kata',
        place: '45 Taina road,Tambon Karon, Amphoe Muang Phuket, Phuket, 83100, Phuket Province, Thailand',
        stars :3,
        detail: 'Property Location With a stay at Aurico Kata Resort & Spa in Karon, youll be within a 10-minute walk of Dino Park Mini Golf and Karon Beach. This family-friendly hotel is 5.9 mi (9.4 km) from Patong Beach and 5.6 mi (9.1 km) from Chalong Temple. Rooms Make yourself at home in one of the 144 air-conditioned rooms featuring refrigerators and LED televisions. Rooms have private balconies. Complimentary wireless Internet access keeps you connected, and satellite programming is available for your entertainment. ',
        number: '02 1134 347985',
      ),
      Product(
        category: Category.accessories,
        id: 2,
        isFeatured: false,
        name: 'Pamookkoo Resort',
        place: '70/1 Kata Beach, Tambon Karon, Muang District, Phuket 83100, Phuket, 83100, Phuket Province, Thailand',
        stars :5,
        detail: 'Situated in Kata Beach, 1.5 km from Dino Park Mini Golf, Pamookkoo features accommodation with a restaurant, free private parking, an outdoor swimming pool and a fitness centre. 200 m from Surf House Phuket and 1.2 km from The Coffee Club Kata Beach, the property offers a bar and a garden. The accommodation provides a 24-hour front desk, airport transfers, room service and free WiFi.The hotel offers a buffet or American breakfast.Popular points of interest near Pamookkoo include SC Plaza Kata, Kata Noi Beach and Kittisangkraram Temple. The nearest airport is Phuket International Airport, 46 km from the accommodation.',
        number: '01 1134 347985',
      ),
      Product(
        category: Category.accessories,
        id: 3,
        isFeatured: true,
        name: 'Marina Phuket Resort',
        place: '47 Karon Road, Phuket, 83100, Phuket Province, Thailand',
        stars :5,
        detail: 'Marina Phuket Resort Nestled on the beach, close to Dino Park Mini Golf and Kata Porpeang Market. Also nearly Karon Beach and Karon Temple. Marina Phuket Resort, Modern Thai décor and wooden flooring feature throughout the elegant suites. Guestrooms come with private balcony, refrigerator and flat-screen TV. All rooms provide free wireless internet access, Shower facilities are included in an en suite bathroom.Marina Phuket Resort, Hotel offers an outdoor pool, tour desk and beachfront restaurant and pool bar. Guests can relax and have a traditional Thai massage. Laundry services and 24 hours reception.',
        number: '11 11333 347985',
      ),
      Product(
        category: Category.accessories,
        id: 4,
        isFeatured: false,
        name: 'Beyond Resort Kata',
        place: '1 Pakbang Road, Phuket, 83100, Phuket Province, Thailand',
        stars :4,
        detail: 'Beyond Resort Kata situated on the beach in Karon, Kata Beach Resort is close to Kata Noi Beach, Big Buddha, and Dino Park Mini Golf. Additional attractions near this spa resort include Kok Chang Safari Elephant Trekking and Kata View Point. Beyond Resort Kata include minibars and safes. Televisions are equipped with cable channels. All accommodations provide desks and phones. Bathrooms offer shower/tub combinations, designer toiletries, and hair dryers. All units feature refrigerators, coffee/tea makers, and complimentary bottled water. In addition, amenities available on request include in-room massages and irons/ironing boards.',
        number: '11 11313 89985',
      ),
      Product(
        category: Category.accessories,
        id: 5,
        isFeatured: false,
        name: 'Harman Hotel Sanya',
        place: 'No.136 Yuya Road, Sanya, 572000, Hainan, China',
        stars :5,
        detail: 'Harman Hotel Sanya, facing the 3km beautiful “white beach” coastline of south China, boasts a 270-degree superb view of the ocean in Sanya Dadonghai Tourist Resort. Situated between mountain and sea, the hotel offers a miraculous mixture of tropical rain forest mountains and endless stretch of sea water, and the beauty of the rising and setting sun. Integrated with the No.1 Harbour City – the largest shopping & recreational complex in Dadonghai Tourist Resort, it provides access to a sightseeing elevator taking tourists to the fine-sand private beach to enjoy the exclusive leisure of a seaside vacation.',
        number: '11 78789 89985',
      ),
      Product(
        category: Category.accessories,
        id: 6,
        isFeatured: false,
        name: 'Central Airport Plaza',
        place: '205 Mahidol Rd, Tambon Pa Daet, Amphoe Mueang, Chiang Mai, 50100, Thailand',
        stars :3,
        detail: 'The apartment is located between Chiang Mai Airport and the old city, a 3-minute drive from the airport, a 3-minute drive from the old city and a 5-minute walk to the Saturday Night Market. Opposite the hotel is one of Chiang Mais largest shopping malls, Central Airport Plaza, with a variety of local specialties, specialty shops, drugstores, cinemas, supermarkets, etc., all kinds of choices, Good quality and low price',
        number: '10 1234 89985',
      ),
      Product(
        category: Category.accessories,
        id: 7,
        isFeatured: true,
        name: 'SAii Phi Phi',
        place: '49 Moo 8, Phi Phi Island, Ao Nang, Amphoe Muang, Phi Phi Islands, 81000, Krabi, Thailand',
        stars :5,
        detail: 'This 4.5 star tropical resort is surrounded by lush greenery and overlooks the Andaman Sea. Each of the Thai style bungalows are individually built with luxurious interior designs of traditional fabrics and settings. Guests at the SAii Phi Phi Island Village can choose from a range of dining options offering local specialties, international delicacies, and seafood dishes. Facilities at the hotel include a swimming pool, private beach, gift shop, and hotel speedboat transfer between Koh Phi Phi and Phuket. Recreational activities include a modern, fully equipped dive center, spa, snorkeling, hiking, fishing, and nature excursions.',
        number: '10 1239 89985',
      ),
      Product(
        category: Category.accessories,
        id: 8,
        isFeatured: true,
        name: 'Sofitel Krabi Phokeethra Resort',
        place: '200 Moo 3 T.Nongtalay, A.Muang Krabi, Krabi, 81000, Thailand',
        stars :4,
        detail: 'Stunning resort providing traditional Thai hospitality. Close to AoNang, Phi Phi & James Bond Island. 276 Victorian-style rooms & suites with spectacular views. Includes Thailands largest pool (75,347 sq. ft/7000 m2), private yachts, golf course, tenniscourts, Kids club, Spa and a line-up of restaurants: Pizzeria, White Lotus with Thai & Indian recipes and Poda with pool-side BBQs rounding off your culinary experience. The indoor and outdoor spaces are ideal for weddings & events.',
        number: '13 1239 89985',
      ),
    ];
    if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}
