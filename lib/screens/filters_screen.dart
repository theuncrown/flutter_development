import 'package:flutter/material.dart';

import '../main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilter;
  final Map<String, bool> currentFilter;

  FilterScreen(this.currentFilter, this.saveFilter);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenFree = false;
  bool vegetarian = false;
  bool vegan = false;
  bool lactoseFree = false;

  @override
  initState() {
    glutenFree = widget.currentFilter['gluten'];
    lactoseFree = widget.currentFilter['lactose'];
    vegetarian = widget.currentFilter['vegetarian'];
    vegan = widget.currentFilter['vegan'];
    super.initState();
  }

  Widget buildListTile(
      String title, String desc, bool currentValue, Function function) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(desc),
        onChanged: function);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final selectedFilters = {
                {
                  'gluten': glutenFree,
                  'lactose': lactoseFree,
                  'vegan': vegan,
                  'vegetarian': vegetarian,
                }
              };
              widget.saveFilter(selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              buildListTile(
                  'Gluten-free', 'Only include gluten-free meals', glutenFree,
                  (newValue) {
                setState(() {
                  glutenFree = newValue;
                });
              }),
              buildListTile('Lactose-free', 'Only include Lactose-free meals',
                  lactoseFree, (newValue) {
                setState(() {
                  lactoseFree = newValue;
                });
              }),
              buildListTile('Vegan', 'Only include vegan meals', vegan,
                  (newValue) {
                setState(() {
                  vegan = newValue;
                });
              }),
              buildListTile(
                  'Vegetarian', 'Only include vegetarian meals', vegetarian,
                  (newValue) {
                setState(() {
                  vegetarian = newValue;
                });
              }),
            ],
          )),
        ],
      ),
    );
  }
}
