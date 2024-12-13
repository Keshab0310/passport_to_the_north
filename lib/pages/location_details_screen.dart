import 'package:flutter/material.dart';

class LocationDetailsScreen extends StatelessWidget {
  final String categoryName;

  const LocationDetailsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Sample data for sub-categories with description
    final List<Map<String, String>> subCategories =
        _getSubCategories(categoryName);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: const Color(0xFF4E342E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: subCategories.length,
          itemBuilder: (context, index) {
            final subCategory = subCategories[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Image.asset(
                  subCategory['image']!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  subCategory['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(subCategory['description']!),
              ),
            );
          },
        ),
      ),
    );
  }

  // Method to return sub-categories based on the category name
  List<Map<String, String>> _getSubCategories(String category) {
    if (category == 'Hiking') {
      return [
        {
          'name': 'Blueberry Hill Trail',
          'image': 'assets/blueberry_hill.jpg',
          'description':
              'Started at the main parking lot (P1) and hiked the Beaver Pond Loop and the Mount Ramsey Trail on the northeast side of the park.This peaceful, natural environment is only a 10 minute drive from downtown Sudbury, so you don’t need to travel far to experience the wilderness. 23km of hiking trails. There’s a variety of scenic views and habitats to discover, like a lake, a pond, wetlands, hiking and nature trails, and birding opportunities.'
        },
        {
          'name': 'Jane Goodall Reclamation Trail',
          'image': 'assets/jane_goodall.jpg',
          'description':
              'is a 1km nature walk from the Coniston Welcome Centre. Logging and smelting of nickel ore caused soil erosion and depletion of vegetation. Thankfully, through the City of Greater Sudbury’s Regreening Program, this area is now a beautiful nature trail for all to enjoy.'
        },
        {
          'name': 'Kelly Lake Trail',
          'image': 'assets/kelly_lake.jpg',
          'description':
              'The first kilometre of the trail is barrier free as it’s a wooden boardwalk. You can continue on Kelly Lake for much farther if you’d like. You can walk for a 4-6km loop, or keep walking for 8 or 9km if you’d like. Start your adventure at Fielding Memorial Park where there’s ample free parking. Then, hike on the south side of Kelly Lake. It’s one of the most amazing Sudbury hiking trails where it’s easy to get immersed with nature."'
        },
        {
          'name': 'Kivi Park',
          'image': 'assets/kivi_park.jpg',
          'description':
              'You can go hiking, biking, skiing, and snowshoeing, depending on the season. During the spring, summer, and fall, there are several hiking trails at Kivi Park of varying lengths.For a longer, scenic trail, follow the red trail (5km). At the southern end of the red trail, you’ll be able to witness amazing lookout points.'
        },
        {
          'name': 'Lake Laurentian Conservation Area',
          'image': 'assets/lake_laurentian.jpg',
          'description':
              'Started at the main parking lot (P1) and hiked the Beaver Pond Loop and the Mount Ramsey Trail on the northeast side of the park.This peaceful, natural environment is only a 10 minute drive from downtown Sudbury, so you don’t need to travel far to experience the wilderness. 23km of hiking trails. There’s a variety of scenic views and habitats to discover, like a lake, a pond, wetlands, hiking and nature trails, and birding opportunities.'
        },
        {
          'name': 'Lily Creek Boardwalk',
          'image': 'assets/lily_creek_broadwalk.jpg',
          'description':
              'The shorter Sudbury hiking trail is a little under 1km, and it’s a lovely little walk on Ramsey Lake around the Science North property. The path starts at the James Jerome Sports Complex. Then, continue your walk as you pass Science North, Lake Ramsey, and pretty little gardens.'
        },
        {
          'name': 'Onaping Falls and the A.Y. Jackson Lookout',
          'image': 'assets/onnaping_falls.jpg',
          'description':
              'The entire trail is around 2km, but it will take a little longer than usual because you will need to navigate across some rocky surfaces and short inclines. The A.Y. Jackson Lookout offers spectacular views of stunning Onaping Falls. This waterfall is like several waterfalls in one, as there are several cascades to see as you walk. Starting at the A.Y. Jackson Welcome Centre, admire the falls from the first lookout point."'
        },
        {
          'name': 'Robinson Lake Trail',
          'image': 'assets/robinson_lake_trail.jpg',
          'description':
              'is a short, 1.3km out and back trail that offers pretty scenery of Robinson Lake and the wetlands. It’s an easy jaunt on paved paths, wooden boardwalks, and grassy terrain. There are multiple entrances from Cranbrook Cr, Arnold St and Nova Dr, and the path connects all three streets.'
        },
        {
          'name': 'Rotary Park Trail (New Sudbury Conservation Area)',
          'image': 'assets/rotary_trail_park.jpg',
          'description':
              '"It iss a 3km walking path through Rotary Park, also known as the New Sudbury Conservation Area. You’ll find free parking at the Adanac Ski Hill off Beatrice Street. This is an easy walk on a gravel path, and there’s also a boardwalk trail here, too. This is one of the best Sudbury hiking trails because there’s a gorgeous lookout from the main hiking trail. It’s labeled as the “New Sudbury Lookout”"'
        },
        {
          'name': 'Walking Trails in Sudbury: Bell Park Walkway',
          'image': 'assets/bell_park.jpg',
          'description':
              'The Bell Park Walkway is a paved and boardwalk path that’s barrier free and accessible. It follows the edge of Ramsey Lake, and you’ll be able to see landmarks like gazebos and beaches. You can start at Science North or Elizabeth Street on the north side of the trail. It’s easy to combine a day at the beach with a walk. Plus, it is a Blue Flag Beach, meaning that the water is clean and the beach meets high environmental standards.'
        },
      ];
    } else if (category == 'Provincial Park') {
      return [
        {
          'name': 'Halfway Lake Provincial Park',
          'image': 'assets/halfway_provincial_park.jpg',
          'description':
              'Halfway Lake Provincial Park is perfect for day hikes, multiday hiking trips, and canoeing. There are also two beaches with great swimming opportunities for families. There are four hiking trails at Halfway Lake Provincial Park and two canoeing routes.'
        },
        {
          'name': 'Killarney Provincial Park',
          'image': 'assets/killarney_park.jpg',
          'description':
              'one of the best places to go hiking in Ontario, most famous for its stunning scenery. Soak up views of the La Cloche Mountains, coastlines dripping in pink granite, and over 50 crystal clear sapphire lakes. For hikers looking for a lengthy journey, there’s the 80km La Cloche Silhouette Trail that could take up to a week to hike. If you’re going to Killarney Provincial Park, you absolutely need to hike the Crack trail. It’s a little bit of a scramble up those rocks, but the panoramic viewpoint at the top is well worth it.'
        },
      ];
    } else if (category == 'Tourist Attraction') {
      return [
        {
          'name': 'Science North',
          'image': 'assets/science_north.jpg',
          'description':
              'most popular tourist attraction and an educational resource for children and adults across the globe. Science North maintains the second and eighth largest science centres in all of Canada and features an IMAX® with Laser theatre, digital Planetarium, butterfly gallery, special exhibits hall, and so much more'
        },
        {
          'name': 'Dynamic Earth',
          'image': 'assets/dynamic_earth.jpg',
          'description':
              'Dynamic Earth, home of the Big Nickel, is an immersive, hands-on science centre that features earth science and mining experiences. Complete with a guided underground tour, multimedia theatres, engaging exhibits, and an outdoor science park, this iconic space entertains visitors of all ages in an interactive and educational setting.'
        },
      ];
    } else if (category == 'Museum') {
      return [
        {
          'name': 'Anderson Farm Museum',
          'image': 'assets/anderson_farm_museum.jpg',
          'description':
              'Explore Northern Ontario’s railroading, lumbering and mining history through engaging, educational and entertaining experiences. Operate a locomotive simulator, explore life on the railroad through the box car house and school on wheels, climb inside a historic locomotive and a caboose, and experience our massive model train layout and interactive programs.'
        },
        {
          'name': 'Art Gallery of Sudbury',
          'image': 'assets/arts_gallery_sudbury.jpg',
          'description':
              'Step back into the history of law enforcement in the Sudbury Region from 1883 to the present day.'
        },
        {
          'name': 'Flour Mill Museum',
          'image': 'assets/flour_mill_museum.jpg',
          'description':
              'Explore the century-old heritage buildings of a former dairy farm, once among the largest operating in Northern Ontario during the 1920s-1930s, and visit a log cabin originally from the ghost town of Creighton Mine'
        },
        {
          'name': 'Northern Ontario Railroad Museum & Heritage Centre',
          'image': 'assets/northern_ontario_railroad_museum.jpg',
          'description':
              'Explore Northern Ontario’s railroading, lumbering and mining history through engaging, educational and entertaining experiences. Operate a locomotive simulator, explore life on the railroad through the box car house and school on wheels, climb inside a historic locomotive and a caboose, and experience our massive model train layout and interactive programs.'
        },
        {
          'name': 'Sudbury Region Police Museum',
          'image': 'assets/sudbury_regional_police_museum.jpg',
          'description':
              'Step back into the history of law enforcement in the Sudbury Region from 1883 to the present day.'
        }
      ];
    } else if (category == 'Festival/Event') {
      return [
        {
          'name': 'Afrofest Sudbury',
          'image': 'assets/afrofest_sudbury.jpg',
          'description':
              'Celebrate Afro culture while enjoying live performances by local talent and shopping African inspired vendors.'
        },
        {
          'name': 'Blueberry Festival',
          'image': 'assets/blueberry_festival.jpg',
          'description': 'https://www.blueberryfestival.ca/'
        },
        {
          'name': 'Capreol Days',
          'image': 'assets/capreol_days_festival.jpg',
          'description':
              'Capreol Downtown Part \n Capreol Days Vendors Market (over 50 vendors \nFood Vendor \nKids Activitie \nLive Music \nPancake Breakfast \nDuck Race\nCommunity BBQ\nInflatable Bouncy Castle\nBeer Garden'
        },
        {
          'name': 'Caruso Club – Società Caruso Italian Festival',
          'image': 'assets/italian_festival.jpg',
          'description':
              'The Società Caruso\'s Italian Festival is an annual celebration of Italian culture where we encourage our community to come and experience the regional food, performances, music, and activities that we schedule throughout the weekend!'
        },
        {
          'name': 'Celebrate Canada Day',
          'image': 'assets/canada_day.png',
          'description':
              '3-day Canada Day celebration in the heart of Sudbury! Bell Park transforms into a vibrant hub of excitement, showcasing the best of Canadian culture, music, and community spirit.'
        },
        {
          'name': 'Cinéfest Sudbury International Film Festival',
          'image': 'assets/cinefest_festival.jpg',
          'description':
              'Screening upwards of 125 films to over 34,000 attendees each year, Cinéfest Sudbury is one of Canada’s major film festivals. Recognized as The People’s Festival for the unparalleled access it provides visitors, Cinéfest offers the best in Canadian and international cinema'
        },
        {
          'name': 'Graphic-Con Sudbury',
          'image': 'assets/graphic_con.png',
          'description':
              'Celebrate the contributions of comic books, graphic novels, film, and other media in our community with cosplay and comradery at this annual fan convention. SUDBURY COMMUNITY ARENA'
        },
        {
          'name': 'Greater Sudbury Earth Festival',
          'image': 'assets/sudbury_earth_festival.png',
          'description':
              'Greater Sudbury Earth Festival took place at Delki Dozzi Park. The day included vendors, children’s activities, and a chance to learn from community groups across Greater Sudbury!'
        },
        {
          'name': 'Northern Lights Festival Boréal',
          'image': 'assets/northern_lights_festival.jpg',
          'description': 'Outdoor music festival, Grace Hartman Amphiteatre'
        },
        {
          'name': 'Ribfest Sudbury',
          'image': 'assets/Ribfest_sudbury.png',
          'description':
              'Annual community event is Northern Ontario\'s largest festival, bell park'
        },
        {
          'name': 'Spring Fling Fest',
          'image': 'assets/spring_fling.jpg',
          'description':
              'Northern Ontario’s largest inflatable park comes to life at Spring Fling 2024, with over 20 unique attractions provided by A Maze N Fun Inc., including some of the largest available in Ontario, there is something for everyone to enjoy'
        },
        {
          'name': 'Sudbury Greek Festival',
          'image': 'assets/greek_festival.png',
          'description':
              'Celebrate Greek heritage and culture in Sudbury with a weekend of authentic food and desserts, live music and traditional dancing, raffles, and tours of the beautiful St. Nicholas Greek Orthodox Church.)'
        },
        {
          'name': 'Sudbury Poutine Fest',
          'image': 'assets/sudbury_poutine_fest.jpg',
          'description': 'Bell Park & Grace Hartman Amphitheatre'
        },
      ];
    }
    return [];
  }
}
