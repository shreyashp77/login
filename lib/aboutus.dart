import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/fa_icon.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About Us',
          style: TextStyle(color: Colors.black),
          textScaleFactor: 1.2,
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: FaIcon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 35,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset('assets/iskcon.png'),
            SizedBox(height: 12),
            // Image.network(
            //     'http://www.iskconpune.com/dev/wp-content/uploads/2013/10/iskcon_logo.png'),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "The International Society for Krishna Consciousness (ISKCON), known colloquially as the Hare Krishna movement or Hare Krishnas, is a Gaudiya Vaishnava religious organisation. It was founded in 1966 in New York City by A. C. Bhaktivedanta Swami Prabhupada. Its core beliefs are based on select traditional Indian scriptures, particularly the Bhagavad-gītā and the ŚrīmadBhāgavatam. The distinctive appearance of the movement and its culture come from the Gaudiya Vaishnava tradition, which has had adherents in India since the late 15th century and Western converts since the early 1900s in America, and in England in the 1930s.ISKCON was formed to spread the practice of bhakti yoga, in which aspirant devotees (bhaktas) dedicate their thoughts and actions towards pleasing the Supreme Lord, Krishna. ISKCON today is a worldwide confederation of more than 400 centres, including 60 farm communities, some aiming for self-sufficiency, 50 schools and 90 restaurants. In recent decades the movement’s most rapid expansions in terms of numbers of membership have been within Eastern Europe (especially since the collapse of the Soviet Union) and India.",
                style: TextStyle(fontSize: 14.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
