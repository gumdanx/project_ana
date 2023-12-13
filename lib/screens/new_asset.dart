import 'package:flutter/material.dart';
import 'package:projeto_ana/screens/asset_data.dart';
import 'package:projeto_ana/globals.dart';

class TelaNovoAsset extends StatefulWidget {
  final String surveyName;

  TelaNovoAsset({required this.surveyName});

  @override
  _TelaNovoAssetState createState() => _TelaNovoAssetState();
}


class _TelaNovoAssetState extends State<TelaNovoAsset> {
  Map<String, dynamic> categories = {};
  late final String surveyName = widget.surveyName;

  @override
  void initState() {
    super.initState();
    loadCategoriesFromAsset().then((data) {
      setState(() {
        categories = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (categories == null) {
      return CircularProgressIndicator();
    }
    return Scaffold(
      backgroundColor: AnaColors.back,
      appBar: AppBar(
          backgroundColor: AnaColors.back,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: AnaColors.champagne, // Define a cor do ícone do botão de retornar
          ),
          title: Text('Novo Asset', style: TextStyle(color: AnaColors.desertSand))),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final categoryKey = categories.keys.elementAt(index);
          final category = categories[categoryKey];
          return _buildCategoryTile(category, context, categoryKey, isMainCategory: index < 5);
        },
      ),
    );
  }

  Widget _buildCategoryTile(Map<String, dynamic> category, BuildContext context, String categoryId, {bool isMainCategory = false}) {
    TextStyle mainCategoryStyle = TextStyle(
      color: AnaColors.champagne,
      fontWeight: FontWeight.bold, // negrito
    );

    if (category['subcategories'] == null) {
      return ListTile(
        title: Text(
            category['name'],
            style: isMainCategory
                ? mainCategoryStyle
                : TextStyle(color: category['subcategories'] != null
                ? AnaColors.champagne
                : AnaColors.front)
        ),
        onTap: () {
          print("Categoria ID: $categoryId"); // Aqui, você pode ver o ID da categoria.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaTipoAsset(tipo: category['name'], categoryId: categoryId, surveyName: surveyName),
            ),
          );
        },
      );
    } else {
      return ExpansionTile(
        title: Text(
          category['name'],
          style: isMainCategory ? mainCategoryStyle : TextStyle(color: AnaColors.champagne),
          textAlign: isMainCategory ? TextAlign.center : TextAlign.start, // centralizado se for uma categoria principal
        ),
        collapsedIconColor: AnaColors.champagne,
        iconColor: AnaColors.champagne,
        children: category['subcategories'].entries.map<Widget>((entry) {
          String subCategoryId = entry.key;
          Map<String, dynamic> subCategory = entry.value;
          return _buildCategoryTile(subCategory, context, subCategoryId);
        }).toList(),
      );
    }
  }
}
