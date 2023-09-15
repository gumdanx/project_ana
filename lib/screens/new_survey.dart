import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'package:project_ana/screens/new_asset.dart';
import 'package:project_ana/screens/assets.dart';

class TelaNovoLevantamento extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Levantamento'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Container(
                  width: 280.0,
                  height: 60,
                  child: OutlinedButton(
                    child: Text(
                      surveyName,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: AnaColors.front,
                      onSurface: AnaColors.front,
                      side: BorderSide(color: AnaColors.front, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        /* pop up para um pop up com TextField */
                    },
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Center(
                child: Container(
                  width: 280.0,
                  height: 60,
                  child: OutlinedButton(
                    child: Text(
                      'Novo Asset',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: AnaColors.champagne,
                      onSurface: AnaColors.champagne,
                      side: BorderSide(color: AnaColors.champagne, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaNovoAsset()),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Center(
                child: Container(
                  width: 280.0,
                  height: 60,
                  child: OutlinedButton(
                    child: Text(
                      'Ver Assets',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: AnaColors.champagne,
                      onSurface: AnaColors.champagne,
                      side: BorderSide(color: AnaColors.champagne, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaVerAssets()),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Center(
                child: Container(
                  width: 280.0,
                  height: 60,
                  child: OutlinedButton(
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: AnaColors.champagne,
                      onSurface: AnaColors.champagne,
                      side: BorderSide(color: AnaColors.champagne, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Logic to save data
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
