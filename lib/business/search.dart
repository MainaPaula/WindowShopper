import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class InfoSearch extends SearchDelegate<String> {
  final listings = ['Automotive', 'Business Support', 'Business Supplies', 'Computers', 'Construction', 'Contractors', 'Education', 'Entertainment', 'Food/Dining',
    'Health/Medicine', 'Home/Garden', 'Legal/Financial', 'Manufacturing', 'Wholesale', 'Distribution', 'Merchant(Retail)', 'Miscellaneous', 'Personal Care', 'Real Estate',
    'Travel', 'Transportation'];
  final recentListings = ['Automotive', 'Business Support', 'Business Supplies', 'Computers', 'Construction'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Actions for the search
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Leading search icon
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null.toString());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show results of search
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Card(
          color: Colors.redAccent,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show when search is invoked
    final suggestList = query.isEmpty ? recentListings : listings.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            showResults(context);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
              text: suggestList[index].substring(0,query.length),
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                )
              ],
          ),
          ),
        ),
        itemCount: suggestList.length
    );
  }

}
